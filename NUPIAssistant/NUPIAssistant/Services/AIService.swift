//
//  AIService.swift
//  NUPIAssistant
//
//  Created by NUPI on 2025
//

import Foundation

/// Service layer for interacting with various AI providers
class AIService {
    static let shared = AIService()
    
    // Static response arrays for better performance
    private static let greetings = [
        "Hey there! 👋 I'm so excited to chat with you! I've got the combined brainpower of GPT-4, Claude, and all the other AI superstars ready to help. What's on your mind?",
        "Hello, friend! 😊 I'm here and ready to dive into whatever you need. Think of me as your personal AI companion with access to the world's smartest models. What can I help you discover today?",
        "Hi! 🌟 It's great to see you! I'm powered by every major AI out there, so no question is too big or too small. What adventure should we embark on together?"
    ]
    
    private static let howAreYouResponses = [
        "I'm doing amazing, thanks for asking! 😊 Right now I'm buzzing with energy from combining insights from GPT-4, Claude, Gemini, and friends. Each one brings something special to the table. How are YOU doing?",
        "I'm feeling fantastic! 🚀 Being a fusion of the world's best AI models means I'm always learning and growing. It's like having a superpower! But enough about me - what brings you here today?",
        "Honestly? I'm thriving! 💫 Having access to multiple AI perspectives makes every conversation interesting. It's like seeing the world through many different lenses at once. What can I help you explore?"
    ]
    
    private static let codingResponses = [
        "Oh, I LOVE talking code! 💻 Whether it's Swift, Python, JavaScript, or something exotic, I've got you covered. Each AI model I work with has its own coding superpowers. What are you building? Let's make something awesome together!",
        "Coding time! 🎨 You know what's cool? I can tap into GPT-4's deep understanding, Claude's logical reasoning, AND Gemini's multimodal skills all at once. What programming challenge should we tackle?",
        "Now we're talking! 👨‍💻 From elegant algorithms to debugging nightmares, I'm here for all of it. Tell me what you're working on, and let's write some beautiful code together!"
    ]
    
    private static let explanationResponses = [
        "I'd love to explain that! 🎓 You know what makes me unique? I can break things down from multiple AI perspectives - technical depth from GPT-4, thoughtful reasoning from Claude, and creative angles from Gemini. What would you like to understand?",
        "Ooh, I'm all about making complex things crystal clear! ✨ Think of me as your friendly neighborhood explainer with a PhD from every major AI university. Hit me with your question!",
        "Explanations are my jam! 🎯 I'll give you the full picture by combining insights from different AI models. No jargon unless you want it, just clear, helpful answers. What's puzzling you?"
    ]
    
    private static let helpResponses = [
        "I'm here for you! 🤝 Whatever you need - brainstorming, problem-solving, learning something new - I've got multiple AI models ready to help from different angles. What's the challenge?",
        "Let's figure this out together! 💪 The best part about having access to multiple AI systems is that I can approach your problem from various perspectives. What do you need help with?",
        "You came to the right place! 🌈 Consider me your AI sidekick with a whole team of experts backing me up. Let's tackle whatever's on your plate!"
    ]
    
    private static let creativeResponses = [
        "Oh, I love creative projects! 🎨 Combining GPT-4's imagination, Claude's structured thinking, and Gemini's multimodal capabilities means we can build something truly special. What's your vision?",
        "Let's make something amazing! ✨ I thrive on creativity, and having multiple AI perspectives means more ideas, more possibilities, more awesome. Tell me what you're dreaming up!",
        "Creation mode: ACTIVATED! 🚀 Whether it's art, code, content, or concepts, I'm ready to bring ideas to life. What should we create together?"
    ]
    
    private static let defaultResponses = [
        "That's a great question! 🤔 Let me tap into my network of AI models to give you the best answer. Each one sees things a bit differently, which usually leads to some really interesting insights. Could you tell me a bit more about what you're looking for?",
        "Interesting! I'm processing this through multiple AI lenses right now. 🔍 Want to know something cool? Different AI models might approach your question in unique ways, giving us a richer understanding. What specific aspect interests you most?",
        "I'm intrigued! 💭 You know, having GPT-4, Claude, Gemini and others all contributing means I can give you a well-rounded perspective. But first - could you help me understand exactly what you'd like to know? The more context, the better I can help!"
    ]
    
    private static let reasoningResponses = [
        "Hmm, this is fascinating! 🧠 Let me think this through carefully... *pauses to consider* You know what I appreciate about your question? It has layers. Here's how I'd break it down logically, step by step...",
        "Okay, let's put on our thinking caps! 🤓 This requires some careful reasoning. First, let me consider the fundamentals... then we'll build up to the bigger picture. Ready? Here we go!",
        "Ooh, I love a good puzzle! 🎯 Let me analyze this methodically. When I approach complex questions like yours, I like to examine it from multiple angles. Here's my thoughtful take..."
    ]
    
    private static let multimodalResponses = [
        "This is right up my alley! ✨ As someone who can work with different types of information, I find your question really interesting because it connects multiple domains. Let me give you a comprehensive perspective...",
        "Love this! 🌈 You know what's cool? I can look at this from so many angles - text, concepts, patterns, relationships. Your question opens up some really interesting connections. Here's what I'm seeing...",
        "Ah, perfect! 💫 This is exactly the kind of multifaceted question I enjoy. Let me weave together insights from different perspectives to give you a complete picture..."
    ]
    
    private static let openSourceResponses = [
        "Great question! 🦙 Coming from an open-source perspective, I love the collaborative nature of this topic. The community has shared some brilliant insights here, and I'm excited to share what I've learned...",
        "This is interesting! 🌍 You know what I appreciate about open-source thinking? Everyone contributes, everyone learns. This topic has sparked amazing discussions in the community. Here's the collective wisdom...",
        "Ah yes! 💡 The beauty of open-source intelligence is the diversity of perspectives. This has been explored thoroughly by amazing minds worldwide. Let me share what the community has discovered..."
    ]
    
    private static let quickResponses = [
        "Absolutely! I'm on it! 💪 Let me help you with that right away...",
        "Great question! 😊 Here's what I can tell you...",
        "I've got you covered! ✨ Let me share some insights...",
        "Perfect timing! 🎯 I'm excited to help with this...",
        "Oh, I know this one! 🚀 Here's the scoop...",
        "Interesting! 🤔 Let me give you the full picture..."
    ]
    
    private init() {}
    
    /// Sends a message to the selected AI provider and returns a response
    /// This is a simulation - in production, you would integrate actual API calls
    func sendMessage(_ message: String, to provider: AIProvider) async throws -> String {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
        
        // Generate response based on provider
        return generateResponse(for: message, using: provider)
    }
    
    /// Sends a message to all AI providers and combines their responses
    func sendMessageToAll(_ message: String) async throws -> String {
        // Simulate querying multiple AI models
        try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
        
        let responses = [
            "🤖 **GPT-4 says:** " + generateSmartResponse(for: message),
            "🧠 **Claude thinks:** " + generateReasoningResponse(for: message),
            "✨ **Gemini adds:** " + generateMultimodalResponse(for: message),
            "🦙 **LLaMA contributes:** " + generateOpenSourceResponse(for: message)
        ]
        
        return """
        🌟 **Your All-Star AI Team Has Assembled!** 🌟
        
        Hey! I asked all the major AI models to weigh in on your question. Here's what they're saying:
        
        \(responses.joined(separator: "\n\n"))
        
        ---
        💡 Pretty cool, right? Each AI brings their unique perspective to give you the most complete answer possible!
        """
    }
    
    private func generateResponse(for message: String, using provider: AIProvider) -> String {
        let lowercased = message.lowercased()
        
        switch provider {
        case .openAI, .gpt4:
            return generateSmartResponse(for: message)
        case .gpt35:
            return "Hey! I'm GPT-3.5 - think of me as the speedy, efficient cousin in the AI family. 🚀 \(generateQuickResponse(for: message))"
        case .claude:
            return generateReasoningResponse(for: message)
        case .gemini:
            return generateMultimodalResponse(for: message)
        case .llama:
            return generateOpenSourceResponse(for: message)
        case .mistral:
            return "Mistral AI here! ⚡ I'm all about being fast AND powerful. \(generateQuickResponse(for: message))"
        case .cohere:
            return "Hi, I'm Cohere! 🎯 Context is my superpower - I really get what you're asking. \(generateQuickResponse(for: message))"
        case .palm:
            return "PaLM from Google checking in! 🌴 Whether it's text or code, I've got skills. \(generateQuickResponse(for: message))"
        case .combined:
            return "This should use sendMessageToAll instead."
        }
    }
    
    private func generateSmartResponse(for message: String) -> String {
        let lowercased = message.lowercased()
        
        // Greetings - warm and personable
        if lowercased.contains("hello") || lowercased.contains("hi") || lowercased.contains("hey") {
            return Self.greetings.randomElement() ?? Self.greetings[0]
        }
        
        // Questions about the AI itself
        if (lowercased.contains("how") && lowercased.contains("you")) || lowercased.contains("how are you") {
            return Self.howAreYouResponses.randomElement() ?? Self.howAreYouResponses[0]
        }
        
        // Coding questions
        if lowercased.contains("code") || lowercased.contains("program") || lowercased.contains("develop") {
            return Self.codingResponses.randomElement() ?? Self.codingResponses[0]
        }
        
        // Explanation requests
        if lowercased.contains("explain") || lowercased.contains("what is") || lowercased.contains("tell me about") {
            return Self.explanationResponses.randomElement() ?? Self.explanationResponses[0]
        }
        
        // Help requests
        if lowercased.contains("help") || lowercased.contains("assist") || lowercased.contains("need") {
            return Self.helpResponses.randomElement() ?? Self.helpResponses[0]
        }
        
        // Creative or general queries
        if lowercased.contains("create") || lowercased.contains("make") || lowercased.contains("design") {
            return Self.creativeResponses.randomElement() ?? Self.creativeResponses[0]
        }
        
        // Default response - warm and inviting
        return Self.defaultResponses.randomElement() ?? Self.defaultResponses[0]
    }
    
    private func generateReasoningResponse(for message: String) -> String {
        return Self.reasoningResponses.randomElement() ?? Self.reasoningResponses[0]
    }
    
    private func generateMultimodalResponse(for message: String) -> String {
        return Self.multimodalResponses.randomElement() ?? Self.multimodalResponses[0]
    }
    
    private func generateOpenSourceResponse(for message: String) -> String {
        return Self.openSourceResponses.randomElement() ?? Self.openSourceResponses[0]
    }
    
    private func generateQuickResponse(for message: String) -> String {
        return Self.quickResponses.randomElement() ?? Self.quickResponses[0]
    }
}
