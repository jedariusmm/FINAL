//
//  APIConfiguration.swift
//  NUPIApp
//
//  Created for NUPI AI Assistant
//

import Foundation

struct APIConfiguration {
    /// NUPI Premium API Key Configuration
    /// For public release: Users must configure their own API key
    static var apiKey: String {
        // Always use UserDefaults for public release
        if let savedKey = UserDefaults.standard.string(forKey: "nupi_api_key"), !savedKey.isEmpty {
            return savedKey
        }
        
        // No default key for public release - users must configure their own
        return ""
    }
    
    static var isConfigured: Bool {
        return !apiKey.isEmpty
    }
    
    static func setAPIKey(_ key: String) {
        UserDefaults.standard.set(key, forKey: "nupi_api_key")
        UserDefaults.standard.synchronize()
    }
    
    static func clearAPIKey() {
        UserDefaults.standard.removeObject(forKey: "nupi_api_key")
        UserDefaults.standard.synchronize()
    }
    
    static func validateAPIKey(_ key: String) -> Bool {
        // Basic validation: ensure key is not empty and has reasonable length
        return key.count > 10
    }
}
