# nupidmesktopai
NUPI - Powerful AI Assistant for iOS and macOS

## Universal App

NUPI is a comprehensive AI assistant app that runs natively on both iOS and macOS, built with SwiftUI. Like advanced AI assistants such as GitHub Copilot, NUPI provides powerful capabilities to help with coding, research, analysis, learning, and creative tasks.

### Key Features

#### 💬 **Conversational AI Interface**
- Natural, context-aware conversations
- Multi-turn dialogue with conversation history
- Auto-generated conversation titles
- Save and manage multiple conversations

#### 🧠 **Powerful AI Capabilities**
- **Code Generation & Debugging**: Write, debug, and optimize code in multiple languages
- **Research & Analysis**: Deep insights, data analysis, and information synthesis
- **Problem Solving**: Step-by-step solutions to complex challenges
- **Learning & Teaching**: Clear explanations and personalized tutoring
- **Creative Writing**: Content creation, brainstorming, and editing
- **Multi-domain Expertise**: Knowledge across science, technology, arts, and more

#### 🎯 **Explore & Discover**
- Categorized capability exploration
- Example prompts for different use cases
- Discover what NUPI can do for you

#### ⚙️ **Settings & Customization**
- Configure assistant preferences
- View detailed capabilities
- Manage notifications and themes

### Architecture

The app follows modern iOS development best practices:

- **SwiftUI**: Declarative UI framework
- **MVVM Pattern**: Clear separation of concerns
- **ObservableObject**: Reactive state management
- **UserDefaults**: Persistent conversation storage
- **Async/Await**: Modern concurrency for AI responses

### Project Structure

```
NUPIApp/
├── NUPIApp.xcodeproj/              # Xcode project file
└── NUPIApp/                        # Source code
    ├── NUPIAppApp.swift            # App entry point
    ├── ContentView.swift           # Main tab view
    ├── ChatView.swift              # Chat interface
    ├── ConversationListView.swift  # Conversation management
    ├── SettingsView.swift          # Settings and configuration
    ├── Message.swift               # Message data model
    ├── Conversation.swift          # Conversation data model
    ├── AIService.swift             # AI response generation
    ├── ConversationManager.swift   # Conversation state management
    ├── Assets.xcassets/            # App assets and icons
    └── Preview Content/            # SwiftUI preview assets
```

### Requirements

- **iOS**: iOS 17.0 or later
- **macOS**: macOS 14.0 (Sonoma) or later
- **Xcode**: 15.0 or later (for building)
- **Swift**: 5.0 or later

### Building the App

#### For iOS:
1. Open `NUPIApp/NUPIApp.xcodeproj` in Xcode
2. Select your iOS device or simulator
3. Press Cmd+R to build and run

#### For macOS:
1. Use the automated build script:
   ```bash
   ./build_macos.sh
   ```

2. Or open in Xcode:
   - Open `NUPIApp/NUPIApp.xcodeproj`
   - Select "My Mac" as the destination
   - Press Cmd+R to build and run

For detailed macOS installation instructions, see [INSTALL_MACOS.md](INSTALL_MACOS.md).

### Features in Detail

#### Chat Interface
- Real-time message display with timestamps
- User and assistant message bubbles
- Smooth scrolling to latest messages
- Input field with multi-line support
- Loading indicator during AI processing

#### Conversation Management
- Create new conversations
- View conversation history
- Delete conversations
- Auto-generated conversation titles
- Persistent storage across app launches

#### AI Capabilities
NUPI can assist with:
- Writing and debugging code in Python, Swift, JavaScript, and more
- Explaining complex technical concepts
- Analyzing data and providing insights
- Solving mathematical and logical problems
- Creating content and documents
- Learning new skills and concepts
- Research and information synthesis

### App Icon

The app uses the iOS standard app icon format. You can add custom app icons by replacing the files in `NUPIApp/Assets.xcassets/AppIcon.appiconset/`.

### Future Enhancements

Potential future features:
- Integration with external AI APIs (OpenAI, Anthropic, etc.)
- Code syntax highlighting
- Voice input support
- Export conversations
- Cloud sync across devices
- Custom AI model selection
- Markdown rendering
- File attachments
