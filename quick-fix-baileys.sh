#!/bin/bash

# Quick Fix for Baileys Logger Error
# This script fixes the logger.error is not a function error

set -e

echo "🔧 Quick fix for Baileys logger error..."

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

print_status "Removing problematic dependencies..."
rm -rf node_modules package-lock.json

print_status "Installing stable Baileys version..."
npm install @whiskeysockets/baileys@^6.4.0 express@^4.18.2 qrcode@^1.5.3 axios@^1.6.0 cors@^2.8.5

print_status "Creating auth directory..."
mkdir -p auth_info_baileys

print_status "Logger error fixed!"

echo ""
echo "🎯 Test the server:"
echo "  npm start"
echo ""
print_status "Ready to test!" 