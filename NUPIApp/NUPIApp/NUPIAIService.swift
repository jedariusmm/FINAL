//
//  NUPIAIService.swift
//  NUPIApp
//
//  Created for NUPI AI Assistant
//

import Foundation

class NUPIAIService {
    static let shared = NUPIAIService()
    
    private var conversationHistory: [Message] = []
    
    struct Message: Codable {
        let role: String // "user" or "assistant"
        let content: String
        let timestamp: Date
        
        init(role: String, content: String) {
            self.role = role
            self.content = content
            self.timestamp = Date()
        }
    }
    
    private init() {
        // Initialize with welcome message
        conversationHistory.append(Message(role: "assistant", content: NUPIPersonality.generateWelcomeMessage()))
    }
    
    func getConversationHistory() -> [Message] {
        return conversationHistory
    }
    
    func sendMessage(_ userMessage: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Add user message to history
        conversationHistory.append(Message(role: "user", content: userMessage))
        
        // Check if API key is configured
        guard APIConfiguration.isConfigured else {
            let errorMessage = "I'd love to help, but I need an API key to connect! 🔑 Please configure your NUPI Premium API key in the settings."
            conversationHistory.append(Message(role: "assistant", content: errorMessage))
            completion(.success(errorMessage))
            return
        }
        
        // Handle simple greetings locally
        let lowercaseMessage = userMessage.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if ["hi", "hello", "hey", "greetings", "howdy"].contains(lowercaseMessage) {
            let response = NUPIPersonality.getResponseToGreeting()
            conversationHistory.append(Message(role: "assistant", content: response))
            completion(.success(response))
            return
        }
        
        // Call the AI API
        callNUPIAPI(with: userMessage, completion: completion)
    }
    
    private func callNUPIAPI(with message: String, completion: @escaping (Result<String, Error>) -> Void) {
        // This is a placeholder for the actual API call
        // In a real implementation, you would make an HTTP request to the NUPI API
        
        // Simulate API processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            // For now, generate contextual responses based on the message
            let response = self?.generateContextualResponse(for: message) ?? "I'm here to help! 😊"
            self?.conversationHistory.append(Message(role: "assistant", content: response))
            completion(.success(response))
        }
        
        /* 
        // Actual API implementation would look like this:
        
        let url = URL(string: "https://api.nupi.ai/v1/chat")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(APIConfiguration.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "messages": conversationHistory.map { ["role": $0.role, "content": $0.content] },
            "system": NUPIPersonality.systemPrompt,
            "temperature": 0.7,
            "max_tokens": 500
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let responseText = json["response"] as? String else {
                    completion(.failure(NSError(domain: "NUPIAIService", code: -1)))
                    return
                }
                
                self?.conversationHistory.append(Message(role: "assistant", content: responseText))
                completion(.success(responseText))
            }
        }.resume()
        */
    }
    
    private func generateContextualResponse(for message: String) -> String {
        let lowercaseMessage = message.lowercased()
        
        // Help requests
        if lowercaseMessage.contains("help") || lowercaseMessage.contains("what can you") {
            return """
            I'm here to assist you with lots of things! 😊 Here's what I can do:
            
            💬 Have conversations and answer questions
            📚 Provide information on various topics
            💡 Offer suggestions and advice
            ✍️ Help with writing and creative tasks
            🔧 Assist with problem-solving
            
            Just ask me anything, and I'll do my best to help! What would you like to know?
            """
        }
        
        // Questions about NUPI
        if lowercaseMessage.contains("who are you") || lowercaseMessage.contains("what are you") {
            return """
            I'm NUPI, your AI assistant with a friendly personality! 🤖✨
            
            I'm designed to be helpful, understanding, and personable. I love having conversations, answering questions, and assisting with all sorts of tasks. Think of me as your knowledgeable friend who's always here to help!
            
            What would you like to talk about today?
            """
        }
        
        // Gratitude
        if lowercaseMessage.contains("thank") {
            return "You're very welcome! 😊 I'm always happy to help. Is there anything else you'd like to know?"
        }
        
        // Capabilities
        if lowercaseMessage.contains("can you") {
            return "I'd be happy to try! 💪 What specifically would you like me to help you with? The more details you give me, the better I can assist you!"
        }
        
        // Default intelligent response
        return """
        That's an interesting question! 🤔 
        
        I'd love to give you a thoughtful answer. With your NUPI Premium API key configured, I can access my full capabilities to provide detailed, helpful responses to all your questions.
        
        For now, I'm running in demo mode, but I'm still here to help however I can! What else would you like to know?
        """
    }
    
    func clearHistory() {
        conversationHistory.removeAll()
        conversationHistory.append(Message(role: "assistant", content: NUPIPersonality.generateWelcomeMessage()))
    }
}
