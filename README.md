# NUPI Assistant - Universal AI Knowledge Platform

![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![Xcode](https://img.shields.io/badge/Xcode-15.0+-blue.svg)
![iPhone](https://img.shields.io/badge/iPhone-15_Pro_Max-black.svg)

NUPI Assistant is a revolutionary AI assistant app for iPhone that combines the knowledge and capabilities of every major AI platform into one unified interface.

## 🚀 Features

### Multi-AI Integration
Access knowledge from all leading AI platforms:
- **OpenAI** (GPT-4, GPT-3.5)
- **Anthropic Claude** - Advanced reasoning
- **Google Gemini** - Multimodal capabilities
- **Meta LLaMA** - Open-source power
- **Mistral AI** - Efficient processing
- **Cohere** - Context understanding
- **Google PaLM** - Code generation

### Key Capabilities
- 🤖 **Combined AI Mode**: Get insights from all AI models simultaneously
- 💬 **Real-time Chat**: Interactive conversation interface
- 🎯 **Provider Selection**: Choose specific AI models for specialized tasks
- 📱 **Native iOS**: Built with SwiftUI for iPhone 15 Pro Max
- 🎨 **Modern UI**: Clean, intuitive interface optimized for iOS 17+
- ⚡ **Fast & Responsive**: Async/await architecture for smooth performance

## 📋 Requirements

- **iOS**: 17.0 or later
- **Xcode**: 15.0 or later
- **Device**: iPhone (optimized for iPhone 15 Pro Max)
- **Swift**: 5.9+

## 🛠️ Installation

### Building with Xcode

1. Clone the repository:
```bash
git clone https://github.com/jedariusmm/nupidmesktopai.git
cd nupidmesktopai
```

2. Open the project in Xcode:
```bash
open NUPIAssistant/NUPIAssistant.xcodeproj
```

3. Select your target device or simulator (iPhone 15 Pro Max recommended)

4. Build and run (⌘R)

## 📱 Usage

### Quick Start

1. **Launch the App**: Open NUPI Assistant on your iPhone
2. **Select AI Provider**: Tap "Change" to choose between individual AI models or "All AI Models" for combined responses
3. **Start Chatting**: Type your question and tap the send button
4. **Get Insights**: Receive responses powered by the world's leading AI systems

### AI Provider Selection

- **All AI Models**: Get comprehensive responses combining insights from multiple AI systems
- **GPT-4**: OpenAI's most advanced model for complex reasoning
- **Claude**: Anthropic's AI for nuanced understanding
- **Gemini**: Google's multimodal AI for diverse tasks
- **And more**: Choose from 8+ different AI providers

## 🏗️ Project Structure

```
NUPIAssistant/
├── NUPIAssistant/
│   ├── Models/
│   │   ├── AIProvider.swift       # AI provider definitions
│   │   └── ChatMessage.swift      # Message data model
│   ├── ViewModels/
│   │   └── ChatViewModel.swift    # Chat state management
│   ├── Views/
│   │   └── ContentView.swift      # Main UI
│   ├── Services/
│   │   └── AIService.swift        # AI integration layer
│   ├── Assets.xcassets/           # App assets
│   └── NUPIAssistantApp.swift     # App entry point
└── NUPIAssistant.xcodeproj/       # Xcode project
```

## 🎨 Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern:

- **Models**: Data structures for messages and AI providers
- **Views**: SwiftUI views for the user interface
- **ViewModels**: Business logic and state management
- **Services**: External integrations and API handling

## 🔄 Future Enhancements

- [ ] Real API integration with AI providers
- [ ] Voice input/output support
- [ ] Message history persistence
- [ ] User authentication
- [ ] Custom AI model configurations
- [ ] Share conversations
- [ ] Dark mode optimization
- [ ] iPad support
- [ ] Widget support
- [ ] Siri integration

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Developer

Created with ❤️ by the NUPI team

## 🙏 Acknowledgments

- OpenAI for GPT models
- Anthropic for Claude
- Google for Gemini and PaLM
- Meta for LLaMA
- Mistral AI
- Cohere
- The entire AI community

---

**Note**: This is a demonstration app. For production use, you'll need to integrate actual API keys and implement proper authentication with each AI provider.
