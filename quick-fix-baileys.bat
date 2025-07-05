@echo off
setlocal enabledelayedexpansion

REM Quick Fix for Baileys Logger Error for Windows
REM This script fixes the logger.error is not a function error

echo 🔧 Quick fix for Baileys logger error...

REM Check if we're in the right directory
if not exist "package.json" (
    echo ❌ Please run this script from the whatsapp-sender directory
    exit /b 1
)

echo ✓ Removing problematic dependencies...
if exist "node_modules" rmdir /s /q node_modules
if exist "package-lock.json" del package-lock.json

echo ✓ Installing stable Baileys version...
npm install @whiskeysockets/baileys@^6.4.0 express@^4.18.2 qrcode@^1.5.3 axios@^1.6.0 cors@^2.8.5

echo ✓ Creating auth directory...
if not exist "auth_info_baileys" mkdir auth_info_baileys

echo ✓ Logger error fixed!

echo.
echo 🎯 Test the server:
echo   npm start
echo.
echo ✓ Ready to test!
pause 