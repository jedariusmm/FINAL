//
//  ChatViewModel.swift
//  NUPIAssistant
//
//  Created by NUPI on 2025
//

import Foundation
import SwiftUI

/// ViewModel for managing chat state and interactions
@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var currentInput: String = ""
    @Published var selectedProvider: AIProvider = .combined
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let aiService = AIService.shared
    
    init() {
        // Add welcome message
        let welcomeMessage = ChatMessage(
            content: """
            Hey there! Welcome to NUPI Assistant! 👋✨
            
            I'm so excited you're here! Think of me as your friendly AI companion who has ALL the superpowers. 🦸‍♂️
            
            🌟 **My All-Star Team:**
            • 🤖 OpenAI (GPT-4 & GPT-3.5) - The brainiacs
            • 🧠 Anthropic Claude - The deep thinker  
            • ✨ Google Gemini - The creative one
            • 🦙 Meta LLaMA - The open-source champion
            • ⚡ Mistral AI - Speed demon
            • 🎯 Cohere - Context master
            • 🌴 Google PaLM - The versatile one
            
            You can chat with any specific AI, or tap "All AI Models" to get a symphony of insights! 🎵
            
            So... what amazing thing should we explore together today? 😊
            """,
            isUser: false,
            provider: .combined
        )
        messages.append(welcomeMessage)
    }
    
    /// Sends a user message to the selected AI provider
    func sendMessage() {
        guard !currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        let userMessage = ChatMessage(
            content: currentInput,
            isUser: true
        )
        messages.append(userMessage)
        
        let messageToSend = currentInput
        currentInput = ""
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response: String
                
                if selectedProvider == .combined {
                    response = try await aiService.sendMessageToAll(messageToSend)
                } else {
                    response = try await aiService.sendMessage(messageToSend, to: selectedProvider)
                }
                
                let aiMessage = ChatMessage(
                    content: response,
                    isUser: false,
                    provider: selectedProvider
                )
                messages.append(aiMessage)
                isLoading = false
            } catch {
                errorMessage = "Failed to get response: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
    
    /// Clears all messages except the welcome message
    func clearChat() {
        // Keep only the welcome message (identified by being the first non-user message)
        let welcomeMessage = messages.first(where: { !$0.isUser })
        messages.removeAll()
        if let welcome = welcomeMessage {
            messages.append(welcome)
        }
    }
}
