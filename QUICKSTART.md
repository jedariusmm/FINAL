# Quick Start Guide - NUPI Assistant

## ⚡ 5-Minute Setup

### Prerequisites
- Mac with macOS 13.0+ (Ventura or later)
- Xcode 15.0 or later
- iOS 17.0+ simulator or device

### Step 1: Clone the Repository
```bash
git clone https://github.com/jedariusmm/nupidmesktopai.git
cd nupidmesktopai
```

### Step 2: Open in Xcode
```bash
open NUPIAssistant/NUPIAssistant.xcodeproj
```

Or:
1. Launch Xcode
2. File → Open
3. Navigate to `nupidmesktopai/NUPIAssistant/NUPIAssistant.xcodeproj`

### Step 3: Select Target Device
1. Click the device selector in Xcode toolbar (next to the Run button)
2. Choose "iPhone 15 Pro Max" simulator
3. Or select any iPhone simulator running iOS 17.0+

### Step 4: Build & Run
Press `⌘R` or click the Run button ▶️

**That's it!** The app should launch in the simulator.

---

## 🎯 First Use

### Welcome Screen
You'll see a welcome message listing all available AI providers:
- OpenAI (GPT-4, GPT-3.5)
- Anthropic Claude
- Google Gemini
- Meta LLaMA
- Mistral AI
- Cohere
- Google PaLM

### Sending Your First Message

1. **Default Mode**: "All AI Models" (combines all AI systems)
2. **Type a message** in the text field at the bottom
3. **Press send** (↑ button) or hit Return
4. **Wait 1-2 seconds** for the AI response

### Try These Examples

**General Question:**
```
Hello! What can you help me with?
```

**Technical Question:**
```
Explain how async/await works in Swift
```

**Code Request:**
```
Show me how to create a SwiftUI button
```

**Complex Query:**
```
What are the differences between various AI models?
```

---

## 🔄 Switching AI Providers

### To Use a Specific AI Model:

1. Tap **"Change"** button at the top of the screen
2. Browse the list of AI providers
3. Tap on any provider to select it
4. Tap **"Done"**
5. Send a message - it will use only that AI model

### Provider Descriptions:

- **All AI Models**: Get comprehensive responses combining multiple AIs
- **GPT-4**: Most advanced reasoning and understanding
- **Claude**: Excellent for nuanced, thoughtful responses
- **Gemini**: Multimodal capabilities (text, code, etc.)
- **GPT-3.5**: Fast, efficient responses
- **LLaMA**: Open-source community knowledge
- **Mistral AI**: Efficient and powerful
- **Cohere**: Strong context understanding
- **PaLM**: Google's text and code generation

---

## 💬 Using the Chat Interface

### Message Features
- **Your messages**: Blue bubbles on the right
- **AI responses**: Gray bubbles on the left
- **Timestamps**: Below each message
- **Provider label**: Shows which AI responded

### Interface Actions
- **Clear Chat**: Tap trash icon (🗑️) in top right
- **Scroll**: Automatically scrolls to latest message
- **Multi-line input**: Text field expands up to 5 lines

---

## 🎨 Customization (For Developers)

### Change App Colors
Edit: `NUPIAssistant/Assets.xcassets/AccentColor.colorset/Contents.json`

### Modify Welcome Message
Edit: `NUPIAssistant/ViewModels/ChatViewModel.swift` (lines ~20-35)

### Add New AI Provider
1. Edit: `NUPIAssistant/Models/AIProvider.swift`
2. Add new case to enum
3. Add description and icon
4. Update `AIService.swift` with response logic

---

## 🐛 Troubleshooting

### App Won't Build
**Solution:**
1. Clean build folder: `⌘⇧K`
2. Quit and restart Xcode
3. Delete DerivedData:
   ```bash
   rm -rf ~/Library/Developer/Xcode/DerivedData
   ```

### Simulator Issues
**Solution:**
1. Device → Erase All Content and Settings
2. Restart Mac
3. Try a different simulator version

### Can't Find Project File
**Solution:**
Make sure you're opening the `.xcodeproj` file, not the folder:
```bash
open NUPIAssistant/NUPIAssistant.xcodeproj
```

### Build Fails with "No Such Module"
**Solution:**
The project uses only system frameworks. If you see this error:
1. Check minimum deployment target is iOS 17.0
2. Verify Xcode version is 15.0+

---

## 📱 Testing on Physical Device

### Requirements
1. Apple Developer account (free or paid)
2. iPhone with iOS 17.0+
3. USB cable

### Steps
1. Connect iPhone to Mac
2. Trust computer on iPhone
3. In Xcode, select your iPhone from device list
4. Signing & Capabilities → Team → Select your Apple ID
5. Press `⌘R` to build and run

### First Time Setup
- Xcode may prompt to "Register Device"
- On iPhone: Settings → General → VPN & Device Management
- Trust your developer certificate

---

## 🚀 Next Steps

### For Users
- Explore different AI providers
- Try various question types
- Test the combined AI mode
- Clear and restart conversations

### For Developers
- Review `DEVELOPMENT.md` for architecture details
- Check `PROJECT_SUMMARY.md` for project overview
- Start with real API integration
- Add new features from the roadmap

---

## 📚 Additional Resources

### Documentation
- `README.md` - Main project documentation
- `DEVELOPMENT.md` - Technical architecture guide
- `PROJECT_SUMMARY.md` - Complete project overview

### Apple Resources
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Swift Language Guide](https://docs.swift.org/swift-book/)
- [Xcode Help](https://help.apple.com/xcode/)

### AI Provider APIs
- [OpenAI API](https://platform.openai.com/docs)
- [Anthropic Claude](https://docs.anthropic.com/)
- [Google AI](https://ai.google.dev/)

---

## ✅ Verification Checklist

After setup, verify everything works:

- [ ] Project opens in Xcode without errors
- [ ] Build completes successfully (⌘B)
- [ ] App launches in simulator
- [ ] Welcome message displays
- [ ] Can type in text field
- [ ] Send button is enabled when typing
- [ ] Messages appear after sending
- [ ] Provider selection modal opens
- [ ] Can switch between providers
- [ ] Clear chat button works

---

## 🆘 Getting Help

If you encounter issues:

1. **Check the documentation** in this repository
2. **Review error messages** in Xcode console
3. **Open an issue** on GitHub with:
   - Xcode version
   - macOS version
   - Error message/screenshot
   - Steps to reproduce

---

**Enjoy using NUPI Assistant!** 🎉

*Your unified AI knowledge platform for iOS*
