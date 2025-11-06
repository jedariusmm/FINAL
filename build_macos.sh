#!/bin/bash

# NUPI iOS/macOS App Build Script
# This script builds the NUPI app for macOS

set -e

echo "🚀 Building NUPI for macOS..."
echo ""

# Navigate to the project directory
cd "$(dirname "$0")/NUPIApp"

# Check if xcodebuild is available
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Error: xcodebuild not found. Please install Xcode from the App Store."
    exit 1
fi

# Clean build folder
echo "🧹 Cleaning build folder..."
xcodebuild clean -project NUPIApp.xcodeproj -scheme NUPIApp -configuration Release > /dev/null 2>&1

# Build for macOS
echo "🔨 Building NUPI for macOS (Release configuration)..."
xcodebuild \
    -project NUPIApp.xcodeproj \
    -scheme NUPIApp \
    -configuration Release \
    -destination 'platform=macOS' \
    -derivedDataPath ./build \
    build

# Check if build was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build successful!"
    echo ""
    echo "📦 The NUPI.app is located at:"
    APP_PATH="./build/Build/Products/Release/NUPIApp.app"
    echo "   $(cd "$(dirname "$APP_PATH")" && pwd)/$(basename "$APP_PATH")"
    echo ""
    echo "📋 Installation options:"
    echo ""
    echo "Option 1: Open directly"
    echo "   open \"$APP_PATH\""
    echo ""
    echo "Option 2: Copy to Applications folder"
    echo "   cp -R \"$APP_PATH\" /Applications/"
    echo "   open /Applications/NUPIApp.app"
    echo ""
    echo "Option 3: Create an alias in Applications"
    echo "   ln -s \"$(cd "$(dirname "$APP_PATH")" && pwd)/$(basename "$APP_PATH")\" /Applications/"
    echo ""
    echo "🎉 NUPI is ready to use on your Mac!"
else
    echo ""
    echo "❌ Build failed. Please check the error messages above."
    exit 1
fi
