@echo off
echo 🚀 Starting WhatsApp File Sender Application...

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed. Please install Node.js first.
    pause
    exit /b 1
)

REM Check if PHP is installed
php --version >nul 2>&1
if errorlevel 1 (
    echo ❌ PHP is not installed. Please install PHP first.
    pause
    exit /b 1
)

REM Check if Composer is installed
composer --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Composer is not installed. Please install Composer first.
    pause
    exit /b 1
)

echo ✅ Prerequisites check passed

REM Install Laravel dependencies if not already installed
if not exist "vendor" (
    echo 📦 Installing Laravel dependencies...
    composer install
)

REM Install Node.js dependencies if not already installed
if not exist "whatsapp-sender\node_modules" (
    echo 📦 Installing Node.js dependencies...
    cd whatsapp-sender
    npm install
    cd ..
)

REM Create .env file if it doesn't exist
if not exist ".env" (
    echo 📝 Creating .env file...
    copy .env.example .env
    php artisan key:generate
)

REM Run migrations
echo 🗄️ Running database migrations...
php artisan migrate --force

echo.
echo 🎯 Starting servers...
echo.

REM Start Laravel server in background
echo 🌐 Starting Laravel server on http://localhost:8000
start "Laravel Server" cmd /c "php artisan serve --host=0.0.0.0 --port=8000"

REM Start Node.js server in background
echo 📱 Starting Node.js server on http://localhost:3000
cd whatsapp-sender
start "Node.js Server" cmd /c "node server.js"
cd ..

echo.
echo ✅ Servers started successfully!
echo.
echo 📱 Laravel Dashboard: http://localhost:8000/admin/dashboard
echo 🔧 Node.js Server: http://localhost:3000
echo.
echo 🛑 Close the command windows to stop the servers
echo.
pause 