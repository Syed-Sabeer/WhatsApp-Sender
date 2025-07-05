// cPanel Node.js Configuration
module.exports = {
    // cPanel typically uses a proxy, so we need to trust it
    trustProxy: true,
    
    // Common cPanel Node.js ports
    possiblePorts: [3000, 8080, 5000, 4000, 3001, 8081],
    
    // Environment variables for cPanel
    env: {
        NODE_ENV: 'production',
        PORT: process.env.PORT || 3000,
        HOST: '0.0.0.0'
    },
    
    // CORS settings for cPanel
    cors: {
        origin: '*',
        methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
        allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With']
    },
    
    // Health check endpoints
    healthEndpoints: [
        '/',
        '/health',
        '/status',
        '/api/health',
        '/api/status'
    ]
}; 