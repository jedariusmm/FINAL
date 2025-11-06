# Installing NUPI on macOS

NUPI is now a universal app that runs natively on both iOS and macOS!

## Prerequisites

- macOS 14.0 (Sonoma) or later
- Xcode 15.0 or later (for building from source)

## Option 1: Build and Install Using the Script (Recommended)

The easiest way to build and install NUPI on your Mac:

```bash
# Clone the repository if you haven't already
git clone https://github.com/jedariusmm/nupidmesktopai.git
cd nupidmesktopai

# Run the build script
./build_macos.sh
```

The script will:
1. Build the app for macOS
2. Show you the location of the built app
3. Provide installation options

After building, you can:
- Open the app directly from the build folder
- Copy it to your Applications folder
- Create an alias in Applications

## Option 2: Build Using Xcode

1. Open `NUPIApp/NUPIApp.xcodeproj` in Xcode
2. Select "My Mac" as the run destination at the top
3. Press Cmd+B to build, or Cmd+R to build and run
4. The app will launch on your Mac!

To install permanently:
1. In Xcode, select Product → Archive
2. Click "Distribute App" → "Copy App"
3. Choose a location and copy
4. Move NUPIApp.app to your Applications folder

## Option 3: Command Line Build

Build directly using xcodebuild:

```bash
cd NUPIApp

# Build for macOS
xcodebuild \
    -project NUPIApp.xcodeproj \
    -scheme NUPIApp \
    -configuration Release \
    -destination 'platform=macOS' \
    build

# The built app will be in:
# DerivedData/NUPIApp/Build/Products/Release/NUPIApp.app
```

## Running NUPI

Once installed, you can:

1. **Launch from Applications**: Find NUPI in your Applications folder and double-click
2. **Launch from Spotlight**: Press Cmd+Space and type "NUPI"
3. **Launch from Dock**: Drag NUPI to your Dock for quick access
4. **Launch from Terminal**: `open /Applications/NUPIApp.app`

## Features on macOS

NUPI on macOS includes all the powerful AI capabilities:

- 💬 **Full chat interface** with multi-turn conversations
- 🧠 **AI assistance** for coding, research, problem-solving, and more
- 🗂️ **Conversation management** with persistent storage
- ⚙️ **Settings and customization**
- 📱 **Native macOS experience** with resizable windows

## Keyboard Shortcuts

- `Cmd+N`: New conversation
- `Cmd+,`: Settings
- `Cmd+Q`: Quit NUPI

## Troubleshooting

### "NUPIApp.app is damaged and can't be opened"

If you see this message, it's because the app isn't signed with an Apple Developer certificate. To fix:

```bash
# Remove the quarantine attribute
xattr -cr /Applications/NUPIApp.app

# Or allow the app in System Settings
# Go to System Settings → Privacy & Security → Allow apps from App Store and identified developers
```

### Build Errors

If you encounter build errors:

1. Make sure you have the latest Xcode: `xcodebuild -version`
2. Clean the build folder: Product → Clean Build Folder (Shift+Cmd+K)
3. Restart Xcode
4. Update macOS to the latest version

### App Won't Launch

1. Check Console.app for error messages
2. Verify macOS version: System Settings → General → About
3. Try rebuilding the app with the build script

## Uninstalling

To remove NUPI from your Mac:

```bash
# Remove the app
rm -rf /Applications/NUPIApp.app

# Remove stored data (optional)
rm -rf ~/Library/Containers/com.nupi.NUPIApp
```

## System Requirements

- **macOS**: 14.0 (Sonoma) or later
- **Processor**: Apple Silicon (M1/M2/M3) or Intel
- **RAM**: 4 GB minimum, 8 GB recommended
- **Storage**: 50 MB for the app

## Support

For issues, questions, or feature requests, please visit:
https://github.com/jedariusmm/nupidmesktopai/issues
