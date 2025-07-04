#!/bin/bash

echo "🚀 Starting WhatsApp File Sender Application..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if PHP is installed
if ! command -v php &> /dev/null; then
    echo "❌ PHP is not installed. Please install PHP first."
    exit 1
fi

# Check if Composer is installed
if ! command -v composer &> /dev/null; then
    echo "❌ Composer is not installed. Please install Composer first."
    exit 1
fi

echo "✅ Prerequisites check passed"

# Install Laravel dependencies if not already installed
if [ ! -d "vendor" ]; then
    echo "📦 Installing Laravel dependencies..."
    composer install
fi

# Install Node.js dependencies if not already installed
if [ ! -d "whatsapp-sender/node_modules" ]; then
    echo "📦 Installing Node.js dependencies..."
    cd whatsapp-sender
    npm install
    cd ..
fi

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file..."
    cp .env.example .env
    php artisan key:generate
fi

# Run migrations
echo "🗄️ Running database migrations..."
php artisan migrate --force

echo ""
echo "🎯 Starting servers..."
echo ""

# Start Laravel server in background
echo "🌐 Starting Laravel server on http://localhost:8000"
php artisan serve --host=0.0.0.0 --port=8000 > laravel.log 2>&1 &
LARAVEL_PID=$!

# Start Node.js server in background
echo "📱 Starting Node.js server on http://localhost:3000"
cd whatsapp-sender
node server.js > ../nodejs.log 2>&1 &
NODEJS_PID=$!
cd ..

echo ""
echo "✅ Servers started successfully!"
echo ""
echo "📱 Laravel Dashboard: http://localhost:8000/admin/dashboard"
echo "🔧 Node.js Server: http://localhost:3000"
echo ""
echo "📋 Logs:"
echo "   Laravel: tail -f laravel.log"
echo "   Node.js: tail -f nodejs.log"
echo ""
echo "🛑 To stop servers, press Ctrl+C"

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "🛑 Stopping servers..."
    kill $LARAVEL_PID 2>/dev/null
    kill $NODEJS_PID 2>/dev/null
    echo "✅ Servers stopped"
    exit 0
}

# Trap Ctrl+C and cleanup
trap cleanup SIGINT

# Wait for both processes
wait 