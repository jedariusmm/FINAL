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
            Welcome to NUPI Assistant! 🚀
            
            I combine the knowledge of every major AI system:
            • OpenAI (GPT-4, GPT-3.5)
            • Anthropic Claude
            • Google Gemini
            • Meta LLaMA
            • Mistral AI
            • Cohere
            • Google PaLM
            
            Select a specific AI provider or use "All AI Models" to get combined insights from all systems.
            
            How can I assist you today?
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
        let welcomeMessage = messages.first
        messages.removeAll()
        if let welcome = welcomeMessage {
            messages.append(welcome)
        }
    }
}
