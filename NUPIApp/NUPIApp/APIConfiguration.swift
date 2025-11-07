//
//  APIConfiguration.swift
//  NUPIApp
//
//  Created for NUPI AI Assistant
//

import Foundation

struct APIConfiguration {
    /// Your NUPI Premium API Key
    /// To use the app, add your API key here or set it via Settings
    static var apiKey: String {
        // First check if it's set in UserDefaults (from Settings)
        if let savedKey = UserDefaults.standard.string(forKey: "nupi_api_key"), !savedKey.isEmpty {
            return savedKey
        }
        
        // Fallback to hardcoded key (for development)
        // Replace "YOUR_API_KEY_HERE" with your actual NUPI Premium API key
        return "YOUR_API_KEY_HERE"
    }
    
    static var isConfigured: Bool {
        return !apiKey.isEmpty && apiKey != "YOUR_API_KEY_HERE"
    }
    
    static func setAPIKey(_ key: String) {
        UserDefaults.standard.set(key, forKey: "nupi_api_key")
        UserDefaults.standard.synchronize()
    }
}
