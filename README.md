<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

You may also try the [Laravel Bootcamp](https://bootcamp.laravel.com), where you will be guided through building a modern Laravel application from scratch.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains over 2000 video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the Laravel [Patreon page](https://patreon.com/taylorotwell).

### Premium Partners

- **[Vehikl](https://vehikl.com/)**
- **[Tighten Co.](https://tighten.co)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Cubet Techno Labs](https://cubettech.com)**
- **[Cyber-Duck](https://cyber-duck.co.uk)**
- **[Many](https://www.many.co.uk)**
- **[Webdock, Fast VPS Hosting](https://www.webdock.io/en)**
- **[DevSquad](https://devsquad.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel/)**
- **[OP.GG](https://op.gg)**
- **[WebReinvent](https://webreinvent.com/?utm_source=laravel&utm_medium=github&utm_campaign=patreon-sponsors)**
- **[Lendio](https://lendio.com)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

# WhatsApp File Sender

A Laravel-based application that allows you to send multiple files to WhatsApp contacts using WhatsApp Web API. The application features a clean architecture with proper separation of concerns, real-time status monitoring, and robust error handling.

## Features

- ✅ **Multiple File Upload**: Upload multiple files at once with drag & drop
- ✅ **QR Code Authentication**: Scan QR code to connect WhatsApp
- ✅ **Real-time Status Monitoring**: Live connection status and task progress
- ✅ **Progress Tracking**: Visual progress bar showing files sent/total files
- ✅ **File Status Management**: Track pending, sent, and failed files
- ✅ **Send Pending Files**: Manually trigger sending of pending files
- ✅ **Retry Failed Files**: Retry failed file sends with one click
- ✅ **Clear Completed**: Remove completed files from history
- ✅ **Task Management**: Queue-based file sending with progress tracking
- ✅ **Force Quit Functionality**: Stop running tasks immediately
- ✅ **Auto Reconnection**: Automatic reconnection on network issues
- ✅ **Loading Indicators**: Visual feedback during file processing
- ✅ **Clean Architecture**: Follows SOLID principles and clean code practices
- ✅ **Error Handling**: Comprehensive error handling and logging
- ✅ **Retry Logic**: Automatic retry with exponential backoff
- ✅ **File Type Support**: Supports various file types (images, documents, videos, audio)

## Architecture

The application follows a clean architecture pattern:

```
├── Laravel (Backend)
│   ├── Controllers (HTTP Layer)
│   ├── Services (Business Logic)
│   ├── Jobs (Background Processing)
│   └── Models (Data Layer)
├── Node.js (WhatsApp Client)
│   ├── WhatsAppManager (Core Logic)
│   ├── Task Queue (File Processing)
│   └── Event Handlers (Status Management)
└── Frontend (Vue.js/Blade)
    ├── Status Monitoring
    ├── File Upload
    └── Task Progress
```

## Prerequisites

- PHP 8.1+
- Node.js 16+
- Composer
- MySQL/PostgreSQL
- WhatsApp account

## Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd whatsapp-file-sender
```

### 2. Install Laravel Dependencies

```bash
composer install
cp .env.example .env
php artisan key:generate
```

### 3. Configure Database

Edit `.env` file:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=whatsapp_sender
DB_USERNAME=your_username
DB_PASSWORD=your_password
```

### 4. Run Migrations

```bash
php artisan migrate
```

### 5. Install Node.js Dependencies

```bash
cd whatsapp-sender
npm install
```

### 6. Configure WhatsApp Settings

Add to your `.env` file:

```env
WHATSAPP_NODE_SERVER_URL=http://127.0.0.1:3000
WHATSAPP_TIMEOUT=30
WHATSAPP_MAX_RETRY_ATTEMPTS=3
WHATSAPP_RETRY_DELAY=30
WHATSAPP_MAX_FILE_SIZE=10240
WHATSAPP_STATUS_POLLING_INTERVAL=3000
WHATSAPP_CACHE_DURATION=5
```

### 7. Start the Application

#### Terminal 1: Start Laravel
```bash
php artisan serve
```

#### Terminal 2: Start Node.js Server
```bash
cd whatsapp-sender
node server.js
```

#### Terminal 3: Start Queue Worker (Optional)
```bash
php artisan queue:work
```

## Usage

### 1. Access the Application

Navigate to `http://localhost:8000/admin/dashboard`

### 2. Connect WhatsApp

1. The application will show a QR code
2. Open WhatsApp on your phone
3. Go to Settings > Linked Devices
4. Scan the QR code
5. Wait for connection confirmation

### 3. Upload Files

1. Prepare files with phone numbers in the filename (e.g., `1234567890_document.pdf`)
2. Click "Choose Files" and select multiple files
3. Review the file list
4. Click "Send Files"

### 4. Monitor Progress

- **Connection Status**: Real-time WhatsApp connection status
- **Task Progress**: Current task and queue information
- **Logs**: Detailed operation logs
- **Force Quit**: Stop all running tasks
- **Reconnect**: Reconnect WhatsApp if disconnected

## File Naming Convention

Files must be named with the phone number as a prefix:

```
1234567890_document.pdf
9876543210_image.jpg
5551234567_video.mp4
```

The phone number will be extracted from the filename and used as the recipient.

## Supported File Types

- **Images**: JPEG, PNG, GIF, WebP
- **Documents**: PDF, DOC, DOCX, XLS, XLSX, TXT
- **Audio**: MP3, WAV
- **Video**: MP4, AVI, MOV

## API Endpoints

### Laravel Endpoints

- `POST /upload-files` - Upload files for sending
- `GET /whatsapp/status` - Get WhatsApp connection status
- `POST /whatsapp/force-quit` - Force quit all tasks
- `POST /whatsapp/reconnect` - Reconnect WhatsApp
- `GET /whatsapp/task-status` - Get task status

### Node.js Endpoints

- `GET /status` - Get detailed status
- `POST /send` - Send file to WhatsApp
- `POST /force-quit` - Force quit tasks
- `POST /reconnect` - Reconnect client
- `GET /health` - Health check

## Error Handling

The application includes comprehensive error handling:

- **Connection Errors**: Automatic retry with exponential backoff
- **File Upload Errors**: Validation and size checks
- **WhatsApp API Errors**: Detailed logging and user feedback
- **Network Issues**: Automatic reconnection
- **Task Failures**: Retry logic with configurable attempts

## Monitoring and Logging

### Laravel Logs
```bash
tail -f storage/logs/laravel.log
```

### Node.js Logs
```bash
cd whatsapp-sender
tail -f logs/whatsapp.log
```

## Configuration

### WhatsApp Settings

Edit `config/whatsapp.php`:

```php
return [
    'node_server_url' => env('WHATSAPP_NODE_SERVER_URL', 'http://127.0.0.1:3000'),
    'timeout' => env('WHATSAPP_TIMEOUT', 30),
    'max_retry_attempts' => env('WHATSAPP_MAX_RETRY_ATTEMPTS', 3),
    'retry_delay' => env('WHATSAPP_RETRY_DELAY', 30),
    'max_file_size' => env('WHATSAPP_MAX_FILE_SIZE', 10240),
    'status_polling_interval' => env('WHATSAPP_STATUS_POLLING_INTERVAL', 3000),
    'cache_duration' => env('WHATSAPP_CACHE_DURATION', 5),
];
```

## Troubleshooting

### QR Code Not Showing
1. Check if Node.js server is running
2. Verify port 3000 is not blocked
3. Check browser console for errors
4. Restart Node.js server

### Files Not Sending
1. Ensure WhatsApp is connected
2. Check file naming convention
3. Verify file size limits
4. Check Laravel logs for errors

### Connection Issues
1. Restart Node.js server
2. Clear browser cache
3. Check network connectivity
4. Verify WhatsApp session

## Security Considerations

- Store sensitive data in environment variables
- Use HTTPS in production
- Implement rate limiting
- Validate file uploads
- Log security events

## Performance Optimization

- Use queue workers for background processing
- Implement caching for status checks
- Optimize file upload handling
- Monitor memory usage

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support and questions:
- Create an issue on GitHub
- Check the troubleshooting section
- Review the logs for error details
#   W h a t s A p p - S e n d e r  
 