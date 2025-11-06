//
//  Conversation.swift
//  NUPIApp
//
//  Data model for conversation management
//

import Foundation

struct Conversation: Identifiable, Codable {
    let id: UUID
    var title: String
    var messages: [Message]
    let createdAt: Date
    var updatedAt: Date
    
    init(title: String = "New Conversation") {
        self.id = UUID()
        self.title = title
        self.messages = []
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    mutating func addMessage(_ message: Message) {
        messages.append(message)
        updatedAt = Date()
        
        // Auto-generate title from first user message
        if title == "New Conversation" && message.role == .user && !message.content.isEmpty {
            let words = message.content.split(separator: " ").prefix(5)
            title = words.joined(separator: " ") + (message.content.count > 30 ? "..." : "")
        }
    }
}
