//
//  ContentView.swift
//  NUPIApp
//
//  Main content view with tab navigation
//

import SwiftUI

struct ContentView: View {
    @StateObject private var conversationManager = ConversationManager()
    
    var body: some View {
        TabView {
            ChatView()
                .environmentObject(conversationManager)
                .tabItem {
                    Label("Chat", systemImage: "message")
                }
            
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "sparkles")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear {
            // Create initial conversation if none exists
            if conversationManager.conversations.isEmpty {
                conversationManager.createNewConversation()
            }
        }
    }
}

struct ExploreView: View {
    @State private var selectedCategory: String?
    
    let categories = [
        Category(icon: "chevron.left.forwardslash.chevron.right", title: "Programming", color: .blue, examples: [
            "Write a Python function to sort a list",
            "Explain object-oriented programming",
            "Debug my JavaScript code"
        ]),
        Category(icon: "doc.text.magnifyingglass", title: "Research", color: .green, examples: [
            "Explain quantum computing",
            "Summarize recent AI developments",
            "Compare different database systems"
        ]),
        Category(icon: "pencil.line", title: "Writing", color: .orange, examples: [
            "Write a professional email",
            "Create a blog post outline",
            "Improve this paragraph"
        ]),
        Category(icon: "chart.line.uptrend.xyaxis", title: "Analysis", color: .purple, examples: [
            "Analyze market trends",
            "Compare two approaches",
            "Identify patterns in data"
        ]),
        Category(icon: "brain", title: "Learning", color: .pink, examples: [
            "Teach me linear algebra",
            "Explain how neural networks work",
            "Create a study plan"
        ]),
        Category(icon: "lightbulb", title: "Creative", color: .yellow, examples: [
            "Brainstorm app ideas",
            "Generate creative solutions",
            "Design a user interface"
        ])
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text("Explore NUPI's Capabilities")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Discover what NUPI can help you with")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Categories
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(categories) { category in
                            CategoryCard(category: category)
                                .onTapGesture {
                                    selectedCategory = category.id.uuidString
                                }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Capabilities overview
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Powerful AI Capabilities")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            CapabilityCard(icon: "cpu", title: "Advanced Reasoning", description: "Complex problem-solving with step-by-step logic")
                            CapabilityCard(icon: "globe", title: "Vast Knowledge", description: "Trained on diverse topics across all domains")
                            CapabilityCard(icon: "arrow.triangle.2.circlepath", title: "Context Awareness", description: "Maintains conversation context for coherent dialogue")
                            CapabilityCard(icon: "arrow.up.right", title: "Continuous Learning", description: "Adapts responses based on conversation flow")
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
                .padding(.bottom)
            }
            .navigationTitle("Explore")
        }
    }
}

struct Category: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let color: Color
    let examples: [String]
}

struct CategoryCard: View {
    let category: Category
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: category.icon)
                .font(.system(size: 32))
                .foregroundColor(category.color)
            
            Text(category.title)
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(category.color.opacity(0.1))
        .cornerRadius(16)
    }
}

struct CapabilityCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.blue)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    ContentView()
}
