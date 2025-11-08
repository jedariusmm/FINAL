//
//  AIProvider.swift
//  NUPIAssistant
//
//  Created by NUPI on 2025
//

import Foundation

/// Represents different AI service providers
enum AIProvider: String, CaseIterable, Identifiable {
    case openAI = "OpenAI"
    case claude = "Claude (Anthropic)"
    case gemini = "Google Gemini"
    case llama = "Meta LLaMA"
    case mistral = "Mistral AI"
    case cohere = "Cohere"
    case palm = "Google PaLM"
    case gpt4 = "GPT-4"
    case gpt35 = "GPT-3.5"
    case combined = "All AI Models"
    
    var id: String { rawValue }
    
    var description: String {
        switch self {
        case .openAI:
            return "Access to GPT models including GPT-4 and GPT-3.5"
        case .claude:
            return "Anthropic's Claude models for advanced reasoning"
        case .gemini:
            return "Google's Gemini for multimodal AI capabilities"
        case .llama:
            return "Meta's open-source LLaMA models"
        case .mistral:
            return "Mistral AI's powerful language models"
        case .cohere:
            return "Cohere's language understanding and generation"
        case .palm:
            return "Google's PaLM for text and code generation"
        case .gpt4:
            return "OpenAI's most advanced GPT-4 model"
        case .gpt35:
            return "Fast and efficient GPT-3.5 Turbo"
        case .combined:
            return "Combines knowledge from all AI models"
        }
    }
    
    var icon: String {
        switch self {
        case .openAI, .gpt4, .gpt35:
            return "cpu.fill"
        case .claude:
            return "brain.head.profile"
        case .gemini:
            return "sparkles"
        case .llama:
            return "cloud.fill"
        case .mistral:
            return "wind"
        case .cohere:
            return "text.bubble.fill"
        case .palm:
            return "hand.raised.fill"
        case .combined:
            return "network"
        }
    }
}
