//
//  ConversationListView.swift
//  NUPIApp
//
//  View for managing conversations
//

import SwiftUI

struct ConversationListView: View {
    @EnvironmentObject var conversationManager: ConversationManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(conversationManager.conversations) { conversation in
                    ConversationRow(conversation: conversation)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            conversationManager.currentConversation = conversation
                            dismiss()
                        }
                }
                .onDelete(perform: deleteConversations)
            }
            .navigationTitle("Conversations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        conversationManager.createNewConversation()
                        dismiss()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func deleteConversations(at offsets: IndexSet) {
        for index in offsets {
            let conversation = conversationManager.conversations[index]
            conversationManager.deleteConversation(conversation)
        }
    }
}

struct ConversationRow: View {
    let conversation: Conversation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(conversation.title)
                .font(.headline)
            
            HStack {
                Text(formatDate(conversation.updatedAt))
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("•")
                    .foregroundColor(.secondary)
                
                Text("\(conversation.messages.count) messages")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ConversationListView()
        .environmentObject(ConversationManager())
}
