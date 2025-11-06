//
//  SettingsView.swift
//  NUPIApp
//
//  Settings and configuration view
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("assistantName") private var assistantName = "NUPI"
    @AppStorage("enableNotifications") private var enableNotifications = true
    @AppStorage("theme") private var theme = "auto"
    
    var body: some View {
        NavigationView {
            Form {
                Section("Assistant") {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(assistantName)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Capabilities")
                            .font(.subheadline)
                        
                        CapabilityBadge(text: "Code Generation")
                        CapabilityBadge(text: "Problem Solving")
                        CapabilityBadge(text: "Research & Analysis")
                        CapabilityBadge(text: "Creative Writing")
                        CapabilityBadge(text: "Learning & Teaching")
                        CapabilityBadge(text: "Multi-language Support")
                    }
                    .padding(.vertical, 4)
                }
                
                Section("Preferences") {
                    Toggle("Notifications", isOn: $enableNotifications)
                    
                    Picker("Theme", selection: $theme) {
                        Text("Auto").tag("auto")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Model")
                        Spacer()
                        Text("NUPI Advanced")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Information") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("NUPI is a powerful AI assistant designed to help you with:")
                            .font(.subheadline)
                        
                        BulletPoint(text: "Writing and debugging code in multiple languages")
                        BulletPoint(text: "Explaining complex concepts clearly")
                        BulletPoint(text: "Analyzing data and providing insights")
                        BulletPoint(text: "Solving problems creatively")
                        BulletPoint(text: "Learning and teaching new skills")
                        BulletPoint(text: "Research and information synthesis")
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct CapabilityBadge: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.blue.opacity(0.1))
            .foregroundColor(.blue)
            .cornerRadius(12)
    }
}

struct BulletPoint: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.caption)
            Text(text)
                .font(.caption)
        }
    }
}

#Preview {
    SettingsView()
}
