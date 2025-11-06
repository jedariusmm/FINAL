//
//  ChatView.swift
//  NUPIApp
//
//  Main chat interface view
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var conversationManager: ConversationManager
    @StateObject private var aiService = AIService()
    @State private var messageText = ""
    @State private var showingSidebar = false
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Messages list
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            if let conversation = conversationManager.currentConversation {
                                if conversation.messages.isEmpty {
                                    EmptyStateView()
                                } else {
                                    ForEach(conversation.messages) { message in
                                        MessageBubble(message: message)
                                            .id(message.id)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .onChange(of: conversationManager.currentConversation?.messages.count) { _ in
                        if let lastMessage = conversationManager.currentConversation?.messages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Input area
                VStack(spacing: 0) {
                    Divider()
                    
                    HStack(alignment: .bottom, spacing: 12) {
                        TextField("Ask NUPI anything...", text: $messageText, axis: .vertical)
                            .textFieldStyle(.plain)
                            .padding(12)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(20)
                            .focused($isInputFocused)
                            .lineLimit(1...5)
                        
                        Button(action: sendMessage) {
                            Image(systemName: aiService.isProcessing ? "hourglass" : "arrow.up.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(messageText.isEmpty ? .gray : .blue)
                        }
                        .disabled(messageText.isEmpty || aiService.isProcessing)
                    }
                    .padding()
                }
                #if os(iOS)
                .background(Color(uiColor: .systemBackground))
                #else
                .background(Color(nsColor: .windowBackgroundColor))
                #endif
            }
            .navigationTitle(conversationManager.currentConversation?.title ?? "NUPI")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingSidebar = true }) {
                        Image(systemName: "line.3.horizontal")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: newConversation) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            #else
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: { showingSidebar = true }) {
                        Image(systemName: "line.3.horizontal")
                    }
                }
                
                ToolbarItem(placement: .automatic) {
                    Button(action: newConversation) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            #endif
            .sheet(isPresented: $showingSidebar) {
                ConversationListView()
                    .environmentObject(conversationManager)
            }
        }
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        
        let message = messageText
        messageText = ""
        
        Task {
            if var conversation = conversationManager.currentConversation {
                try? await aiService.sendMessage(message, conversation: &conversation)
                await MainActor.run {
                    conversationManager.updateCurrentConversation(conversation)
                }
            }
        }
    }
    
    private func newConversation() {
        conversationManager.createNewConversation()
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "brain.head.profile")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("NUPI AI Assistant")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Your powerful AI companion")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 16) {
                CapabilityRow(icon: "chevron.left.forwardslash.chevron.right", title: "Code & Development", description: "Write, debug, and optimize code")
                CapabilityRow(icon: "doc.text.magnifyingglass", title: "Research & Analysis", description: "Deep insights and data analysis")
                CapabilityRow(icon: "text.bubble", title: "Conversation", description: "Natural, context-aware dialogue")
                CapabilityRow(icon: "lightbulb", title: "Problem Solving", description: "Creative solutions to challenges")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16)
            
            Spacer()
        }
        .padding()
    }
}

struct CapabilityRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.blue)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.role == .user {
                Spacer()
            }
            
            VStack(alignment: message.role == .user ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .padding(12)
                    .background(message.role == .user ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundColor(message.role == .user ? .white : .primary)
                    .cornerRadius(16)
                
                Text(formatTime(message.timestamp))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: 300, alignment: message.role == .user ? .trailing : .leading)
            
            if message.role == .assistant {
                Spacer()
            }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ChatView()
        .environmentObject(ConversationManager())
}
