@echo off
setlocal enabledelayedexpansion

REM Baileys WhatsApp Server Setup Script for Windows
REM This script sets up the WhatsApp server using Baileys instead of Puppeteer

echo 🚀 Setting up WhatsApp File Sender with Baileys...

REM Check if we're in the right directory
if not exist "package.json" (
    echo ✗ Please run this script from the whatsapp-sender directory
    exit /b 1
)

echo ✓ Setting up Baileys WhatsApp server...

REM Remove old dependencies
echo ✓ Removing old dependencies...
if exist "node_modules" rmdir /s /q node_modules
if exist "package-lock.json" del package-lock.json

REM Install Baileys dependencies
echo ✓ Installing Baileys dependencies...
npm install @whiskeysockets/baileys@^6.6.0 express@^4.18.2 qrcode@^1.5.3 axios@^1.6.0 cors@^2.8.5

REM Create auth directory
echo ✓ Creating auth directory...
if not exist "auth_info_baileys" mkdir auth_info_baileys

echo ✓ Baileys setup completed!

echo.
echo 🎯 Next steps:
echo   1. Start the server: npm start
echo   2. Check status: curl http://localhost:3000/status
echo   3. Scan QR code with WhatsApp Web
echo   4. Test file sending
echo.
echo 📋 Baileys Features:
echo   ✓ Better performance than Puppeteer
echo   ✓ More reliable connection
echo   ✓ Automatic reconnection
echo   ✓ Better file type detection
echo   ✓ Persistent authentication
echo.
echo ✓ Baileys setup completed successfully!
pause 