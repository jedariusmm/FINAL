# NUPI AI Assistant

NUPI AI Assistant - Your friendly AI companion for iOS & macOS

## ⚠️ Public Release Ready

This app is prepared for public distribution on the App Store. Before submitting:
1. **Add your app icon** (see `NUPIApp/ICON_GUIDE.md`)
2. **Review the checklist** (see `PUBLIC_RELEASE_CHECKLIST.md`)
3. **Configure App Store metadata**
4. **Add privacy policy URL**

## Overview

NUPI AI Assistant is a cross-platform application (iOS and macOS) that provides AI-powered assistance with a warm, human personality. Chat naturally with NUPI to get help with questions, tasks, and more!

**Important**: Users must have their own NUPI Premium API key to use this app. The app does not include a shared API key for security and cost reasons.

## Features

### 🤖 AI Chat Interface
- Natural, conversational AI with a friendly personality
- Context-aware responses that remember your conversation
- Emoji support for expressive communication
- Real-time chat interface
- Vibrant gradient UI with modern design

### 💬 Human Personality
NUPI has been designed with a warm, empathetic personality that:
- Speaks in a natural, friendly way
- Shows enthusiasm about helping
- Admits when it doesn't know something
- Provides encouraging, supportive responses
- Adapts to your communication style

### 🔐 API Key Configuration (Required)
- **Users must configure their own NUPI Premium API key**
- Easy setup through in-app configuration
- Secure storage using UserDefaults
- API key validation
- Visual status indicators

### 📱 Cross-Platform
- **iOS 15.0+**: Full-featured native iOS app
- **macOS**: Compatible with macOS (Catalyst-ready)
- Universal app supporting iPhone and iPad
- Responsive UI with Auto Layout
- Vibrant gradient themes

## Project Structure

```
NUPIApp/
├── NUPIApp.xcodeproj/          # Xcode project file
└── NUPIApp/                     # Source code directory
    ├── AppDelegate.swift        # Application delegate (iOS/macOS)
    ├── SceneDelegate.swift      # Scene delegate (iOS only)
    ├── ViewController.swift     # Main welcome screen
    ├── ChatViewController.swift # Chat interface (iOS)
    ├── APIConfiguration.swift   # API key management
    ├── NUPIPersonality.swift   # AI personality definition
    ├── NUPIAIService.swift     # AI service layer
    ├── Main.storyboard          # Main UI storyboard
    ├── LaunchScreen.storyboard  # Launch screen
    ├── Assets.xcassets/         # Asset catalog
    └── Info.plist              # App configuration
```

## Requirements

- **iOS**: iOS 15.0 or later
- **macOS**: macOS 11.0 or later (for Catalyst support)
- **Xcode**: 14.0 or later
- **Swift**: 5.0 or later
- **NUPI Premium API Key**: Required for full AI capabilities

## Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/jedariusmm/nupidmesktopai.git
cd nupidmesktopai
```

### 2. Open in Xcode
```bash
open NUPIApp/NUPIApp.xcodeproj
```

### 3. Configure Your API Key

**Option A: In the app (Recommended)**
1. Build and run the app
2. Tap "Configure API Key"
3. Enter your NUPI Premium API key
4. The key will be saved securely

**Option B: In code (For development)**
1. Open `APIConfiguration.swift`
2. Replace `"YOUR_API_KEY_HERE"` with your actual API key
3. Rebuild the app

### 4. Build and Run

**For iOS:**
1. Select an iOS simulator or connected device
2. Press `⌘ + R` to build and run
3. The app will launch with the welcome screen

**For macOS:**
1. Select "My Mac" as the destination
2. Press `⌘ + R` to build and run
3. The app will launch as a native macOS application

### 5. Install on Your Computer (macOS)

**Development Build:**
1. Build the app in Xcode (⌘ + B)
2. Find the built app in DerivedData
3. Copy to Applications folder

**Or use Archive for Distribution:**
1. Product → Archive
2. Distribute App → Copy App
3. Move to /Applications

## Using the App

### Welcome Screen
- View API key configuration status
- Configure your NUPI Premium API key
- Start chatting with NUPI

### Chat Interface
- Type your message in the text field
- Press Send or hit Return to send
- NUPI will respond with a helpful, friendly message
- Tap "Clear" to start a new conversation

### API Configuration
- The app checks for a valid API key
- Green status = API key configured and ready
- Orange warning = API key needs configuration
- Configure anytime via the settings button

## NUPI's Personality Traits

- **Friendly & Approachable**: Speaks conversationally
- **Empathetic**: Understands and acknowledges your needs
- **Knowledgeable**: Provides accurate information
- **Patient**: Never rushes or pressures
- **Encouraging**: Motivates and supports positively
- **Honest**: Admits when unsure about something
- **Professional yet Personable**: Maintains warmth while being helpful

## App Store Release

The app is configured for App Store distribution:

1. **Update Bundle ID**: Change `com.nupi.NUPIApp` to your unique identifier
2. **Set Development Team**: Configure in Xcode project settings
3. **Add App Icon**: Replace placeholder in Assets.xcassets
4. **Archive**: Product → Archive in Xcode
5. **Distribute**: Upload to App Store Connect
6. **Submit for Review**: Follow Apple's guidelines

## Development

### Adding Features
- AI services are in `NUPIAIService.swift`
- Personality configuration in `NUPIPersonality.swift`
- UI components follow platform conventions (UIKit/AppKit)

### Testing
- Run on multiple iOS simulators
- Test on physical devices
- Verify macOS compatibility

### Debugging
- Check console for API errors
- Verify API key configuration
- Monitor conversation history

## License

All rights reserved.
