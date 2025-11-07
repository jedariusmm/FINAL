//
//  ChatMessage.swift
//  NUPIAssistant
//
//  Created by NUPI on 2025
//

import Foundation

/// Represents a chat message in the conversation
struct ChatMessage: Identifiable, Equatable {
    let id: UUID
    let content: String
    let isUser: Bool
    let timestamp: Date
    let provider: AIProvider?
    
    init(id: UUID = UUID(), content: String, isUser: Bool, timestamp: Date = Date(), provider: AIProvider? = nil) {
        self.id = id
        self.content = content
        self.isUser = isUser
        self.timestamp = timestamp
        self.provider = provider
    }
}
