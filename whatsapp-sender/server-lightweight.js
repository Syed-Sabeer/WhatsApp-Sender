const express = require('express');
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

// Simple WhatsApp Manager (without actual WhatsApp connection)
class LightweightWhatsAppManager {
    constructor() {
        this.isConnected = false;
        this.isInitializing = false;
        this.logs = [];
        this.taskQueue = [];
        this.isTaskRunning = false;
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
        this.log('🚀 Initializing lightweight WhatsApp client...');
        this.isInitializing = true;
        
        // Simulate initialization delay
        setTimeout(() => {
            this.isConnected = true;
            this.isInitializing = false;
            this.log('✅ Lightweight WhatsApp client ready (simulated)');
        }, 2000);
    }

    getStatus() {
        return {
            connected: this.isConnected,
            initializing: this.isInitializing,
            qr: null,
            logs: this.logs,
            taskRunning: this.isTaskRunning,
            currentTask: null,
            queueLength: this.taskQueue.length,
            reconnectAttempts: 0,
            totalFiles: this.totalFiles,
            sentFiles: this.sentFiles,
            failedFiles: this.failedFiles,
            progress: 0
        };
    }

    forceQuit() {
        this.log('🛑 Force quit requested');
        return { success: true, message: 'Force quit requested' };
    }
}

// Initialize lightweight manager
const whatsappManager = new LightweightWhatsAppManager();

// API Routes
app.get('/', (req, res) => {
    res.json({
        message: 'WhatsApp Sender Server (Lightweight) is running!',
        timestamp: new Date().toISOString(),
        port: process.env.PORT || 3000,
        host: process.env.HOST || '0.0.0.0',
        env: process.env.NODE_ENV || 'development',
        mode: 'lightweight'
    });
});

app.get('/health', (req, res) => {
    res.json({
        status: 'ok',
        timestamp: new Date().toISOString(),
        mode: 'lightweight'
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
    const result = whatsappManager.forceQuit();
    res.json(result);
});

app.post('/reconnect', async (req, res) => {
    await whatsappManager.initializeClient();
    res.json({ 
        success: true, 
        message: 'Reconnection initiated' 
    });
});

// Start server
const PORT = process.env.PORT || process.env.NODE_PORT || 3000;
const HOST = process.env.HOST || '0.0.0.0';

app.listen(PORT, HOST, () => {
    console.log(`🚀 Lightweight WhatsApp server running on http://${HOST}:${PORT}`);
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
    process.exit(0);
}); 