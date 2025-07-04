<?php

return [
    /*
    |--------------------------------------------------------------------------
    | WhatsApp Node.js Server Configuration
    |--------------------------------------------------------------------------
    |
    | This file contains the configuration for the WhatsApp Node.js server
    | that handles WhatsApp Web API operations.
    |
    */

    'node_server_url' => env('WHATSAPP_NODE_SERVER_URL', 'http://127.0.0.1:3000'),
    
    'timeout' => env('WHATSAPP_TIMEOUT', 30),
    
    'max_retry_attempts' => env('WHATSAPP_MAX_RETRY_ATTEMPTS', 3),
    
    'retry_delay' => env('WHATSAPP_RETRY_DELAY', 30),
    
    'max_file_size' => env('WHATSAPP_MAX_FILE_SIZE', 10240), // 10MB in KB
    
    'supported_file_types' => [
        'image/jpeg',
        'image/png',
        'image/gif',
        'image/webp',
        'application/pdf',
        'application/msword',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'text/plain',
        'audio/mpeg',
        'audio/wav',
        'video/mp4',
        'video/avi',
        'video/mov'
    ],
    
    'status_polling_interval' => env('WHATSAPP_STATUS_POLLING_INTERVAL', 3000), // milliseconds
    
    'cache_duration' => env('WHATSAPP_CACHE_DURATION', 5), // seconds
]; 