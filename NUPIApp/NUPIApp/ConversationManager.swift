//
//  ConversationManager.swift
//  NUPIApp
//
//  Manages conversations persistence and state
//

import Foundation
import SwiftUI

class ConversationManager: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var currentConversation: Conversation?
    
    private let userDefaults = UserDefaults.standard
    private let conversationsKey = "saved_conversations"
    
    init() {
        loadConversations()
    }
    
    func createNewConversation() {
        let conversation = Conversation()
        conversations.insert(conversation, at: 0)
        currentConversation = conversation
        saveConversations()
    }
    
    func deleteConversation(_ conversation: Conversation) {
        conversations.removeAll { $0.id == conversation.id }
        if currentConversation?.id == conversation.id {
            currentConversation = conversations.first
        }
        saveConversations()
    }
    
    func updateCurrentConversation(_ conversation: Conversation) {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index] = conversation
            currentConversation = conversation
            saveConversations()
        }
    }
    
    private func saveConversations() {
        if let encoded = try? JSONEncoder().encode(conversations) {
            userDefaults.set(encoded, forKey: conversationsKey)
        }
    }
    
    private func loadConversations() {
        if let data = userDefaults.data(forKey: conversationsKey),
           let decoded = try? JSONDecoder().decode([Conversation].self, from: data) {
            conversations = decoded
            currentConversation = decoded.first
        }
    }
}
