#!/bin/bash

# Fix Baileys Configuration Issues
# This script fixes the logger and QR code issues

set -e

echo "🔧 Fixing Baileys configuration issues..."

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Please run this script from the whatsapp-sender directory"
    exit 1
fi

print_status "Removing old dependencies..."
rm -rf node_modules package-lock.json

print_status "Installing fixed Baileys version..."
npm install @whiskeysockets/baileys@^6.5.0 express@^4.18.2 qrcode@^1.5.3 axios@^1.6.0 cors@^2.8.5

print_status "Creating auth directory..."
mkdir -p auth_info_baileys

print_status "Setting permissions..."
chmod 755 auth_info_baileys
chmod 644 server.js
chmod 644 package.json

print_status "Baileys configuration fixed!"

echo ""
echo "🎯 Next steps:"
echo "  1. Start the server: npm start"
echo "  2. Check for QR code in terminal"
echo "  3. Scan QR code with WhatsApp Web"
echo "  4. Test status: curl http://localhost:3000/status"
echo ""
print_status "Configuration issues resolved!" 