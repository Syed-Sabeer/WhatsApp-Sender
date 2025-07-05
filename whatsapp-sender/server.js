const { default: makeWASocket, DisconnectReason, useMultiFileAuthState, fetchLatestBaileysVersion } = require('@whiskeysockets/baileys');
const express = require('express');
const qrcode = require('qrcode'); 
const axios = require('axios');
const fs = require('fs');
const path = require('path');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Global state management
class WhatsAppManager {
    constructor() {
        this.sock = null;
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
        this.authFolder = './auth_info_baileys';
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
        this.log('🚀 Initializing WhatsApp client with Baileys...');

        try {
            // Create auth folder if it doesn't exist
            if (!fs.existsSync(this.authFolder)) {
                fs.mkdirSync(this.authFolder, { recursive: true });
            }

            // Get auth state
            const { state, saveCreds } = await useMultiFileAuthState(this.authFolder);
            
            // Fetch latest version
            const { version, isLatest } = await fetchLatestBaileysVersion();
            this.log(`📱 Using Baileys version: ${version.join('.')}`);

            // Create socket
            this.sock = makeWASocket({
                version,
                auth: state,
                browser: ['WhatsApp File Sender', 'Chrome', '1.0.0']
            });

            this.setupEventHandlers(saveCreds);
            this.log('✅ Baileys client initialized successfully');
        } catch (error) {
            this.log(`❌ Failed to initialize client: ${error.message}`);
            this.isInitializing = false;
            this.isConnected = false;
        }
    }

    setupEventHandlers(saveCreds) {
        this.sock.ev.on('connection.update', async (update) => {
            const { connection, lastDisconnect, qr } = update;

            if (qr) {
                this.log('📱 QR Code generated - scan to connect');
                try {
                    this.qrCodeData = await qrcode.toDataURL(qr);
                    this.isConnected = false;
                    // Also log QR code to terminal for easy scanning
                    console.log('\n📱 Scan this QR code with WhatsApp Web:');
                    console.log(qr);
                } catch (error) {
                    this.log(`❌ Error generating QR code: ${error.message}`);
                }
            }

            if (connection === 'close') {
                const shouldReconnect = (lastDisconnect?.error)?.output?.statusCode !== DisconnectReason.loggedOut;
                this.log(`🔌 Connection closed due to ${lastDisconnect?.error?.message || 'unknown reason'}, reconnecting ${shouldReconnect}`);
                
                if (shouldReconnect) {
                    this.isConnected = false;
                    this.isInitializing = false;
                    this.handleDisconnection();
                } else {
                    this.log('❌ Connection closed permanently');
                    this.isConnected = false;
                    this.isInitializing = false;
                }
            } else if (connection === 'open') {
                this.log('✅ WhatsApp client is ready and connected!');
                this.isConnected = true;
                this.isInitializing = false;
                this.qrCodeData = null;
                this.reconnectAttempts = 0;
                this.processQueue();
            }
        });

        this.sock.ev.on('creds.update', saveCreds);

        this.sock.ev.on('messages.upsert', async (m) => {
            if (m.type === 'notify') {
                for (const msg of m.messages) {
                    if (!msg.key.fromMe && msg.message) {
                        this.log(`📨 Received message from ${msg.key.remoteJid}: ${msg.message.conversation || 'Media message'}`);
                    }
                }
            }
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
        if (!this.isConnected || !this.sock) {
            throw new Error('WhatsApp client is not connected');
        }

        // Validate number format
        const cleanNumber = String(number).replace(/\D/g, '');
        if (cleanNumber.length < 10) {
            throw new Error('Invalid phone number format');
        }

        try {
            this.log(`📦 Downloading file: ${fileUrl}`);
            const response = await axios.get(fileUrl, { 
                responseType: 'arraybuffer',
                timeout: 30000 
            });
            
            const mime = response.headers['content-type'];
            const buffer = Buffer.from(response.data);
            
            // Determine file type and extension
            let fileType = 'document';
            let fileName = 'file';
            
            if (mime.startsWith('image/')) {
                fileType = 'image';
                fileName = 'image.jpg';
            } else if (mime.startsWith('video/')) {
                fileType = 'video';
                fileName = 'video.mp4';
            } else if (mime.startsWith('audio/')) {
                fileType = 'audio';
                fileName = 'audio.mp3';
            } else if (mime.includes('pdf')) {
                fileName = 'document.pdf';
            } else if (mime.includes('word') || mime.includes('document')) {
                fileName = 'document.docx';
            } else if (mime.includes('excel') || mime.includes('spreadsheet')) {
                fileName = 'document.xlsx';
            }

            const chatId = `${cleanNumber}@s.whatsapp.net`;
            this.log(`📨 Sending ${fileType} to: ${chatId}`);
            
            // Send file based on type
            if (fileType === 'image') {
                await this.sock.sendMessage(chatId, {
                    image: buffer,
                    caption: 'File sent via WhatsApp File Sender'
                });
            } else if (fileType === 'video') {
                await this.sock.sendMessage(chatId, {
                    video: buffer,
                    caption: 'File sent via WhatsApp File Sender'
                });
            } else if (fileType === 'audio') {
                await this.sock.sendMessage(chatId, {
                    audio: buffer,
                    mimetype: mime
                });
            } else {
                await this.sock.sendMessage(chatId, {
                    document: buffer,
                    mimetype: mime,
                    fileName: fileName
                });
            }
            
            this.log(`✅ File sent successfully to ${cleanNumber}`);
            
            return { success: true, message: 'File sent successfully' };
        } catch (error) {
            this.log(`❌ Failed to send file to ${cleanNumber}: ${error.message}`);
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
            this.log('🛑 Queue processing stopped due to force quit');
        } else {
            this.log('✅ Queue processing completed');
        }
    }

    forceQuit() {
        this.log('🛑 Force quit requested');
        this.forceQuitRequested = true;
        this.taskQueue = [];
        if (this.sock) {
            this.sock.end();
        }
    }

    getStatus() {
        return {
            connected: this.isConnected,
            initializing: this.isInitializing,
            qr: this.qrCodeData,
            logs: this.logs,
            taskRunning: this.isTaskRunning,
            currentTask: this.currentTask,
            queueLength: this.taskQueue.length,
            reconnectAttempts: this.reconnectAttempts,
            totalFiles: this.totalFiles,
            sentFiles: this.sentFiles,
            failedFiles: this.failedFiles
        };
    }

    getTaskStatus() {
        return {
            taskRunning: this.isTaskRunning,
            currentTask: this.currentTask,
            queueLength: this.taskQueue.length,
            totalFiles: this.totalFiles,
            sentFiles: this.sentFiles,
            failedFiles: this.failedFiles,
            progress: this.totalFiles > 0 ? Math.round((this.sentFiles + this.failedFiles) / this.totalFiles * 100) : 0,
            logs: this.logs.slice(0, 10)
        };
    }
}

const manager = new WhatsAppManager();

// Initialize client on startup
manager.initializeClient();

// API Routes
app.get('/status', (req, res) => {
    res.json(manager.getStatus());
});

app.post('/send', async (req, res) => {
    try {
        const { number, file_url } = req.body;
        
        // Validate input parameters
        if (!number || !file_url) {
            return res.status(400).json({ 
                success: false, 
                message: 'Number and file_url are required' 
            });
        }

        // Ensure number is a string and clean it
        const cleanNumber = String(number).replace(/\D/g, '');
        
        if (cleanNumber.length < 10) {
            return res.status(400).json({ 
                success: false, 
                message: 'Invalid phone number format' 
            });
        }

        const task = {
            number: cleanNumber,
            fileUrl: file_url,
            description: `Send file to ${cleanNumber}`,
            onSuccess: (result) => {
                manager.log(`✅ Task completed successfully: ${result.message}`);
            },
            onError: (error) => {
                manager.log(`❌ Task failed: ${error.message}`);
            }
        };

        manager.addTask(task);
        
        res.json({ 
            success: true, 
            message: 'File queued for sending',
            queueLength: manager.taskQueue.length
        });
    } catch (error) {
        manager.log(`❌ Send request error: ${error.message}`);
        res.status(500).json({ 
            success: false, 
            message: error.message 
        });
    }
});

app.post('/force-quit', (req, res) => {
    manager.forceQuit();
    res.json({ success: true, message: 'Force quit requested' });
});

app.post('/reconnect', (req, res) => {
    manager.initializeClient();
    res.json({ success: true, message: 'Reconnection initiated' });
});

app.get('/task-status', (req, res) => {
    res.json(manager.getTaskStatus());
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🚀 WhatsApp File Sender server running on port ${PORT}`);
    console.log(`📱 Using Baileys for WhatsApp Web API`);
    console.log(`🌐 Server URL: http://localhost:${PORT}`);
    console.log(`📋 Status: http://localhost:${PORT}/status`);
});
