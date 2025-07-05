#!/bin/bash

# Baileys WhatsApp Server Setup Script
# This script sets up the WhatsApp server using Baileys instead of Puppeteer

set -e

echo "🚀 Setting up WhatsApp File Sender with Baileys..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "Please run this script from the whatsapp-sender directory"
    exit 1
fi

print_status "Setting up Baileys WhatsApp server..."

# Remove old dependencies
print_status "Removing old dependencies..."
rm -rf node_modules package-lock.json

# Install Baileys dependencies
print_status "Installing Baileys dependencies..."
npm install @whiskeysockets/baileys@^6.6.0 express@^4.18.2 qrcode@^1.5.3 axios@^1.6.0 cors@^2.8.5

# Create auth directory
print_status "Creating auth directory..."
mkdir -p auth_info_baileys

# Set proper permissions
print_status "Setting file permissions..."
chmod 755 auth_info_baileys
chmod 644 server.js
chmod 644 package.json

print_status "Baileys setup completed!"

echo ""
echo "🎯 Next steps:"
echo "  1. Start the server: npm start"
echo "  2. Check status: curl http://localhost:3000/status"
echo "  3. Scan QR code with WhatsApp Web"
echo "  4. Test file sending"
echo ""
echo "📋 Baileys Features:"
echo "  ✓ Better performance than Puppeteer"
echo "  ✓ More reliable connection"
echo "  ✓ Automatic reconnection"
echo "  ✓ Better file type detection"
echo "  ✓ Persistent authentication"
echo ""
print_status "Baileys setup completed successfully!" 