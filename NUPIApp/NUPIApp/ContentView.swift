//
//  ContentView.swift
//  NUPIApp
//
//  Main content view for NUPI iOS Application
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "brain.head.profile")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .font(.system(size: 80))
                
                Text("Welcome to NUPI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Your AI Assistant")
                    .font(.title2)
                    .foregroundStyle(.secondary)
                
                Spacer()
                    .frame(height: 40)
                
                VStack(alignment: .leading, spacing: 15) {
                    FeatureRow(icon: "sparkles", title: "AI-Powered", description: "Intelligent assistance at your fingertips")
                    FeatureRow(icon: "shield.checkered", title: "Secure", description: "Your data is protected")
                    FeatureRow(icon: "bolt.fill", title: "Fast", description: "Quick responses when you need them")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                
                Spacer()
                
                Button(action: {
                    // Action to be implemented
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("NUPI")
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.system(size: 24))
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
