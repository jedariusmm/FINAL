# NUPI Assistant - Development Guide

## Overview
NUPI Assistant is an iOS application that provides a unified interface to interact with multiple AI systems including GPT-4, Claude, Gemini, LLaMA, and more.

## Technical Stack
- **Language**: Swift 5.9
- **Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Minimum iOS**: 17.0
- **Target Device**: iPhone (optimized for iPhone 15 Pro Max)

## Project Components

### Models
#### AIProvider.swift
Defines the enumeration of available AI providers:
- OpenAI (GPT-4, GPT-3.5)
- Claude (Anthropic)
- Gemini (Google)
- LLaMA (Meta)
- Mistral AI
- Cohere
- PaLM (Google)
- Combined mode (all models)

Each provider includes:
- Unique identifier
- Display name
- Description
- SF Symbols icon

#### ChatMessage.swift
Represents individual messages in the chat:
- Unique ID (UUID)
- Message content
- Sender type (user/AI)
- Timestamp
- Associated AI provider

### ViewModels
#### ChatViewModel.swift
Manages the application state:
- Message history array
- Current input text
- Selected AI provider
- Loading state
- Error handling

Key methods:
- `sendMessage()`: Sends user input to AI service
- `clearChat()`: Resets conversation

### Views
#### ContentView.swift
Main user interface with three sections:
1. **Provider Selection Bar**: Shows current AI model and allows switching
2. **Message List**: Scrollable chat history with message bubbles
3. **Input Bar**: Text field and send button

Additional views:
- `MessageBubble`: Individual message display
- `LoadingIndicator`: Shows AI thinking state
- `ProviderPickerView`: Modal for selecting AI provider

### Services
#### AIService.swift
Handles communication with AI backends:
- Singleton pattern for global access
- Async/await for non-blocking operations
- Response generation (currently simulated)
- Combined AI mode for multiple provider queries

## Building the Project

### Requirements
- macOS 13.0+ (Ventura or later)
- Xcode 15.0+
- iOS 17.0+ SDK

### Steps
1. Open `NUPIAssistant.xcodeproj` in Xcode
2. Select target device (iPhone 15 Pro Max or any iPhone simulator)
3. Product > Build (⌘B) to build
4. Product > Run (⌘R) to run

### Build Configurations
- **Debug**: Development with debug symbols
- **Release**: Optimized for App Store distribution

## Code Architecture

### MVVM Pattern
```
View (ContentView)
  ↓ User Actions
ViewModel (ChatViewModel)
  ↓ Data Operations
Service (AIService)
  ↓ API Calls
Model (AIProvider, ChatMessage)
```

### Data Flow
1. User types message in `ContentView`
2. `ContentView` calls `ChatViewModel.sendMessage()`
3. `ChatViewModel` updates state and calls `AIService`
4. `AIService` processes request and returns response
5. `ChatViewModel` updates message array
6. SwiftUI automatically updates `ContentView`

## Extending the App

### Adding a New AI Provider
1. Add case to `AIProvider` enum in `AIProvider.swift`
2. Add description and icon
3. Implement response logic in `AIService.swift`

### Implementing Real API Integration
Replace simulation code in `AIService.swift` with actual API calls:
```swift
func sendMessage(_ message: String, to provider: AIProvider) async throws -> String {
    // Implement actual API call
    let url = URL(string: "https://api.example.com/chat")!
    // ... network request
}
```

### Adding Message Persistence
Integrate CoreData or SwiftData:
1. Create data model
2. Update `ChatViewModel` to save/load messages
3. Add database initialization in app lifecycle

## Testing

### Manual Testing
1. Launch app in simulator
2. Test each AI provider selection
3. Send various message types
4. Verify UI responsiveness
5. Test error scenarios

### Future Automated Testing
Consider adding:
- Unit tests for ViewModels
- Integration tests for Services
- UI tests for user flows

## Deployment

### App Store Preparation
1. Configure signing certificates
2. Set app icon and launch screen
3. Update bundle identifier
4. Add API keys for production
5. Submit through App Store Connect

## Performance Considerations
- Messages use `LazyVStack` for efficient rendering
- Async/await prevents UI blocking
- `@Published` properties trigger minimal updates
- SF Symbols for zero-asset-size icons

## Security Notes
- API keys should be stored in Keychain
- Implement certificate pinning for production
- Validate all user inputs
- Use HTTPS for all network calls
- Consider implementing rate limiting

## Accessibility
- VoiceOver compatible
- Dynamic Type support through SwiftUI
- High contrast color support
- Semantic labels on all interactive elements

## Troubleshooting

### Build Errors
- Clean build folder: Product > Clean Build Folder (⌘⇧K)
- Reset package cache if using SPM
- Verify iOS deployment target

### Runtime Issues
- Check console for error messages
- Verify network permissions in Info.plist
- Test on physical device for accurate performance

## Resources
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [Swift Language Guide](https://docs.swift.org/swift-book/)
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

---

For questions or issues, please open an issue on GitHub.
