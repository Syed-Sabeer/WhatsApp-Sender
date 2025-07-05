const { Client, LocalAuth, MessageMedia } = require('whatsapp-web.js');
const express = require('express');
const qrcode = require('qrcode'); 
const axios = require('axios');
const fs = require('fs');
const path = require('path');
const cors = require('cors');

const app = express();

// Enhanced CORS for cPanel
app.use(cors({
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With']
}));

app.use(express.json());

// Trust proxy for cPanel
app.set('trust proxy', true);

// Global state management
class WhatsAppManager {
    constructor() {
        this.client = null;
        this.isConnected = false;
        this.isInitializing = false;
        this.qrCodeData = null;
        this.logs = [];
        this.currentTask = null;
        this.taskQueue = [];
        this.isTaskRunning = false;
        this.forceQuitRequested = false;
        this.reconnectAttempts = 0;
        this.maxReconnectAttempts = 5;
        this.processedFiles = [];
        this.totalFiles = 0;
        this.sentFiles = 0;
        this.failedFiles = 0;
    }

    log(message) {
        const timestamp = new Date().toLocaleTimeString();
        const logEntry = `[${timestamp}] ${message}`;
        this.logs.unshift(logEntry);
        if (this.logs.length > 50) this.logs.pop();
        console.log(logEntry);
    }

    async initializeClient() {
        if (this.isInitializing) {
            this.log('⚠️ Client initialization already in progress');
            return;
        }

        this.isInitializing = true;
        this.log('🚀 Initializing WhatsApp client...');

        try {
            this.client = new Client({
    authStrategy: new LocalAuth(),
                puppeteer: { 
                    headless: true,
                    args: ['--no-sandbox', '--disable-setuid-sandbox']
                }
            });

            this.setupEventHandlers();
            await this.client.initialize();
        } catch (error) {
            this.log(`❌ Failed to initialize client: ${error.message}`);
            this.isInitializing = false;
            this.isConnected = false;
        }
    }

    setupEventHandlers() {
        this.client.on('qr', async (qr) => {
            this.log('📱 QR Code generated - scan to connect');
            try {
                this.qrCodeData = await qrcode.toDataURL(qr);
                this.isConnected = false;
            } catch (error) {
                this.log(`❌ Error generating QR code: ${error.message}`);
            }
        });

        this.client.on('ready', () => {
            this.log('✅ WhatsApp client is ready and connected!');
            this.isConnected = true;
            this.isInitializing = false;
            this.qrCodeData = null;
            this.reconnectAttempts = 0;
            this.processQueue();
        });

        this.client.on('authenticated', () => {
            this.log('🔐 WhatsApp authentication successful');
        });

        this.client.on('auth_failure', (msg) => {
            this.log(`❌ Authentication failed: ${msg}`);
            this.isConnected = false;
            this.isInitializing = false;
        });

        this.client.on('disconnected', (reason) => {
            this.log(`🔌 WhatsApp disconnected: ${reason}`);
            this.isConnected = false;
            this.isInitializing = false;
            this.handleDisconnection();
        });

        this.client.on('loading_screen', (percent, message) => {
            this.log(`📱 Loading: ${percent}% - ${message}`);
        });
    }

    async handleDisconnection() {
        if (this.reconnectAttempts < this.maxReconnectAttempts) {
            this.reconnectAttempts++;
            this.log(`🔄 Attempting to reconnect (${this.reconnectAttempts}/${this.maxReconnectAttempts})...`);
            setTimeout(() => {
                this.initializeClient();
            }, 5000);
        } else {
            this.log('❌ Max reconnection attempts reached. Please restart the server.');
        }
    }

    async sendFile(number, fileUrl) {
        if (!this.isConnected) {
            throw new Error('WhatsApp client is not connected');
        }

        try {
            this.log(`📦 Downloading file: ${fileUrl}`);
            const response = await axios.get(fileUrl, { 
                responseType: 'arraybuffer',
                timeout: 30000 
            });
            
            const mime = response.headers['content-type'];
            const base64 = Buffer.from(response.data).toString('base64');
            const media = new MessageMedia(mime, base64, 'file');

            const chatId = `${number}@c.us`;
            this.log(`📨 Sending file to: ${chatId}`);
            
            await this.client.sendMessage(chatId, media);
            this.log(`✅ File sent successfully to ${number}`);
            
            return { success: true, message: 'File sent successfully' };
        } catch (error) {
            this.log(`❌ Failed to send file to ${number}: ${error.message}`);
            throw error;
        }
    }

    addTask(task) {
        this.taskQueue.push(task);
        this.totalFiles++;
        this.log(`📋 Task added to queue: ${task.description}`);
        if (!this.isTaskRunning) {
            this.processQueue();
        }
    }

    async processQueue() {
        if (this.taskQueue.length === 0 || this.isTaskRunning || !this.isConnected) {
            return;
        }

        this.isTaskRunning = true;
        this.forceQuitRequested = false;

        while (this.taskQueue.length > 0 && !this.forceQuitRequested) {
            const task = this.taskQueue.shift();
            this.currentTask = task;
            
            this.log(`🔄 Processing task: ${task.description}`);
            
            try {
                const result = await this.sendFile(task.number, task.fileUrl);
                this.sentFiles++;
                this.processedFiles.push({
                    number: task.number,
                    fileUrl: task.fileUrl,
                    status: 'sent',
                    timestamp: new Date().toISOString()
                });
                task.onSuccess(result);
            } catch (error) {
                this.failedFiles++;
                this.processedFiles.push({
                    number: task.number,
                    fileUrl: task.fileUrl,
                    status: 'failed',
                    error: error.message,
                    timestamp: new Date().toISOString()
                });
                this.log(`❌ Task failed: ${error.message}`);
                task.onError(error);
            }
        }

        this.isTaskRunning = false;
        this.currentTask = null;
        
        if (this.forceQuitRequested) {
            this.log('🛑 Task processing stopped by force quit');
        } else {
            this.log('✅ All tasks completed');
        }
    }

    forceQuit() {
        this.forceQuitRequested = true;
        this.taskQueue = [];
        this.log('🛑 Force quit requested - stopping all tasks');
    }

    getStatus() {
        const totalFiles = this.processedFiles.length + this.taskQueue.length + (this.currentTask ? 1 : 0);
        const sentFiles = this.processedFiles.filter(f => f.status === 'sent').length;
        const failedFiles = this.processedFiles.filter(f => f.status === 'failed').length;
        const progress = totalFiles > 0 ? Math.round((sentFiles + failedFiles) / totalFiles * 100) : 0;
        
        return {
            connected: this.isConnected,
            initializing: this.isInitializing,
            qr: this.qrCodeData,
            logs: this.logs,
            taskRunning: this.isTaskRunning,
            currentTask: this.currentTask,
            queueLength: this.taskQueue.length,
            reconnectAttempts: this.reconnectAttempts,
            totalFiles,
            sentFiles,
            failedFiles,
            progress
        };
    }
}

// Initialize WhatsApp manager
const whatsappManager = new WhatsAppManager();

// API Routes
app.post('/send', async (req, res) => {
    const { number, file_url } = req.body;

    if (!number || !file_url) {
        return res.status(400).json({ 
            error: 'number and file_url are required' 
        });
    }

    const task = {
        number,
        fileUrl: file_url,
        description: `Send file to ${number}`,
        onSuccess: (result) => {
            // Task completed successfully
        },
        onError: (error) => {
            // Task failed
        }
    };

    whatsappManager.addTask(task);

    res.json({ 
        success: true, 
        message: 'Task added to queue',
        taskId: Date.now()
    });
});

app.get('/status', (req, res) => {
    res.json(whatsappManager.getStatus());
});

app.get('/task-status', (req, res) => {
    const status = whatsappManager.getStatus();
    res.json({
        taskRunning: status.taskRunning,
        queueLength: status.queueLength,
        currentTask: status.currentTask,
        totalFiles: status.totalFiles,
        sentFiles: status.sentFiles,
        failedFiles: status.failedFiles,
        progress: status.progress,
        logs: status.logs.slice(-10)
    });
});

app.post('/force-quit', (req, res) => {
    whatsappManager.forceQuit();
    res.json({ 
        success: true, 
        message: 'Force quit requested' 
    });
});

app.post('/reconnect', async (req, res) => {
    whatsappManager.reconnectAttempts = 0;
    await whatsappManager.initializeClient();
    res.json({ 
        success: true, 
        message: 'Reconnection initiated' 
    });
});

// Health check endpoint
app.get('/health', (req, res) => {
    res.json({
        status: 'ok', 
        timestamp: new Date().toISOString() 
    });
});

// Add a simple test route
app.get('/', (req, res) => {
    res.json({
        message: 'WhatsApp Sender Server is running!',
        timestamp: new Date().toISOString(),
        port: PORT,
        host: HOST,
        env: process.env.NODE_ENV || 'development'
    });
});

// Start server and initialize WhatsApp client
const PORT = process.env.PORT || process.env.NODE_PORT || 3000;
const HOST = process.env.HOST || '0.0.0.0';

app.listen(PORT, HOST, () => {
    console.log(`🚀 WhatsApp server running on http://${HOST}:${PORT}`);
    console.log(`🌐 Server accessible at: ${process.env.APP_URL || 'http://localhost'}:${PORT}`);
    console.log(`📊 Environment variables:`);
    console.log(`   - PORT: ${process.env.PORT}`);
    console.log(`   - NODE_PORT: ${process.env.NODE_PORT}`);
    console.log(`   - HOST: ${process.env.HOST}`);
    console.log(`   - APP_URL: ${process.env.APP_URL}`);
    console.log(`   - NODE_ENV: ${process.env.NODE_ENV}`);
    console.log(`🔗 Health check available at: http://${HOST}:${PORT}/health`);
    console.log(`📱 Status endpoint: http://${HOST}:${PORT}/status`);
    console.log(`🏠 Root endpoint: http://${HOST}:${PORT}/`);
    whatsappManager.initializeClient();
});

// Graceful shutdown
process.on('SIGINT', async () => {
    console.log('\n🛑 Shutting down gracefully...');
    if (whatsappManager.client) {
        await whatsappManager.client.destroy();
    }
    process.exit(0);
});
