//
//  Message.swift
//  NUPIApp
//
//  Data model for chat messages
//

import Foundation

struct Message: Identifiable, Codable {
    let id: UUID
    let content: String
    let role: MessageRole
    let timestamp: Date
    
    init(content: String, role: MessageRole) {
        self.id = UUID()
        self.content = content
        self.role = role
        self.timestamp = Date()
    }
}

enum MessageRole: String, Codable {
    case user
    case assistant
    case system
}
