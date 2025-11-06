//
//  AIService.swift
//  NUPIApp
//
//  AI service for processing user queries
//

import Foundation

class AIService: ObservableObject {
    @Published var isProcessing = false
    
    func sendMessage(_ content: String, conversation: inout Conversation) async throws {
        isProcessing = true
        defer { isProcessing = false }
        
        // Add user message
        let userMessage = Message(content: content, role: .user)
        conversation.addMessage(userMessage)
        
        // Simulate AI processing with intelligent responses
        let response = await generateResponse(for: content, conversation: conversation)
        
        let assistantMessage = Message(content: response, role: .assistant)
        conversation.addMessage(assistantMessage)
    }
    
    private func generateResponse(for query: String, conversation: Conversation) async -> String {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        let lowercaseQuery = query.lowercased()
        
        // Code-related queries
        if lowercaseQuery.contains("code") || lowercaseQuery.contains("function") || lowercaseQuery.contains("program") {
            return """
            I can help you with coding! I'm capable of:
            
            • Writing code in Swift, Python, JavaScript, and many other languages
            • Debugging and fixing issues in your code
            • Explaining complex algorithms and data structures
            • Code reviews and optimization suggestions
            • Creating complete applications and components
            
            What specific coding task can I help you with?
            """
        }
        
        // Explanation queries
        if lowercaseQuery.contains("explain") || lowercaseQuery.contains("what is") || lowercaseQuery.contains("how does") {
            return """
            I excel at providing clear, detailed explanations on virtually any topic:
            
            • Technical concepts (programming, AI, data science, etc.)
            • Scientific principles and theories
            • Historical events and context
            • Mathematical concepts and problem-solving
            • General knowledge across diverse fields
            
            I break down complex topics into understandable parts with examples. What would you like me to explain?
            """
        }
        
        // Problem-solving queries
        if lowercaseQuery.contains("help") || lowercaseQuery.contains("solve") || lowercaseQuery.contains("problem") {
            return """
            I'm here to help solve problems across many domains:
            
            ✓ Technical debugging and troubleshooting
            ✓ Mathematical and logical problem-solving
            ✓ Writing and content creation
            ✓ Research and information synthesis
            ✓ Planning and organization strategies
            ✓ Learning new skills and concepts
            
            Describe your problem in detail, and I'll provide step-by-step solutions.
            """
        }
        
        // Data analysis queries
        if lowercaseQuery.contains("analyze") || lowercaseQuery.contains("data") || lowercaseQuery.contains("compare") {
            return """
            I can perform comprehensive analysis:
            
            📊 Data interpretation and insights
            📈 Trend identification and predictions
            🔍 Deep comparisons and evaluations
            💡 Strategic recommendations
            📋 Summarization of complex information
            
            Share what you need analyzed, and I'll provide detailed insights.
            """
        }
        
        // Creative queries
        if lowercaseQuery.contains("write") || lowercaseQuery.contains("create") || lowercaseQuery.contains("generate") {
            return """
            I can assist with creative tasks:
            
            ✍️ Writing articles, essays, and stories
            🎨 Brainstorming creative ideas
            📝 Drafting emails and documents
            💼 Creating business plans and proposals
            🎯 Marketing copy and content
            
            Tell me what you'd like to create!
            """
        }
        
        // Learning queries
        if lowercaseQuery.contains("learn") || lowercaseQuery.contains("teach") || lowercaseQuery.contains("tutorial") {
            return """
            I'm an excellent tutor! I can help you learn:
            
            📚 Step-by-step tutorials on any subject
            🎓 Personalized learning paths
            🧩 Practice problems with detailed solutions
            📖 Concept reinforcement with examples
            🎯 Skill development strategies
            
            What would you like to learn today?
            """
        }
        
        // Greeting
        if lowercaseQuery.contains("hello") || lowercaseQuery.contains("hi") || lowercaseQuery.contains("hey") {
            return """
            Hello! I'm NUPI, your powerful AI assistant. I'm designed to help you with:
            
            🧠 Complex problem-solving and analysis
            💻 Programming and software development
            📝 Writing and content creation
            🔬 Research and information synthesis
            🎓 Learning and explanations
            🎯 Strategic planning and decision-making
            
            I have extensive knowledge across science, technology, arts, history, and more. How can I assist you today?
            """
        }
        
        // Capabilities query
        if lowercaseQuery.contains("can you") || lowercaseQuery.contains("capabilities") || lowercaseQuery.contains("what can") {
            return """
            I'm a highly capable AI assistant with expertise in:
            
            💻 **Programming & Development**
            - Write, debug, and optimize code in multiple languages
            - Explain algorithms and data structures
            - Build complete applications
            
            🔬 **Analysis & Research**
            - Analyze data and identify patterns
            - Conduct research across diverse topics
            - Provide evidence-based insights
            
            ✍️ **Writing & Communication**
            - Create clear, compelling content
            - Edit and improve existing text
            - Adapt tone for different audiences
            
            🎓 **Education & Tutoring**
            - Explain complex concepts simply
            - Provide step-by-step guidance
            - Create learning materials
            
            🎯 **Problem-Solving**
            - Break down complex challenges
            - Generate creative solutions
            - Offer strategic recommendations
            
            Ask me anything!
            """
        }
        
        // Default intelligent response
        return """
        I understand you're asking about "\(query)". I'm NUPI, a powerful AI assistant with capabilities similar to advanced AI models.
        
        I can help you with:
        • In-depth analysis and research
        • Complex problem-solving
        • Code generation and debugging
        • Detailed explanations
        • Creative content generation
        • Learning and tutoring
        
        Could you provide more details about what you need? I'm here to provide comprehensive, thoughtful assistance.
        """
    }
}
