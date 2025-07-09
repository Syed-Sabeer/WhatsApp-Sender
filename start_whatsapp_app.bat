@echo off
echo Starting Laravel Server...
start cmd /k "cd /d C:\xampp\htdocs\Whatsapp && php artisan serve"

timeout /t 5 /nobreak > NUL

echo Starting Node.js WhatsApp Sender...
start cmd /k "cd /d C:\xampp\htdocs\Whatsapp\whatsapp-sender && node server.js"
