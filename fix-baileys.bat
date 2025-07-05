@echo off
setlocal enabledelayedexpansion

REM Fix Baileys Configuration Issues for Windows
REM This script fixes the logger and QR code issues

echo 🔧 Fixing Baileys configuration issues...

REM Check if we're in the right directory
if not exist "package.json" (
    echo ❌ Please run this script from the whatsapp-sender directory
    exit /b 1
)

echo ✓ Removing old dependencies...
if exist "node_modules" rmdir /s /q node_modules
if exist "package-lock.json" del package-lock.json

echo ✓ Installing fixed Baileys version...
npm install @whiskeysockets/baileys@^6.5.0 express@^4.18.2 qrcode@^1.5.3 axios@^1.6.0 cors@^2.8.5

echo ✓ Creating auth directory...
if not exist "auth_info_baileys" mkdir auth_info_baileys

echo ✓ Baileys configuration fixed!

echo.
echo 🎯 Next steps:
echo   1. Start the server: npm start
echo   2. Check for QR code in terminal
echo   3. Scan QR code with WhatsApp Web
echo   4. Test status: curl http://localhost:3000/status
echo.
echo ✓ Configuration issues resolved!
pause 