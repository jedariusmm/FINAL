//
//  ContentView.swift
//  NUPIAssistant
//
//  Created by NUPI on 2025
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var showProviderPicker = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Provider Selection Bar
                providerSelectionBar
                
                Divider()
                
                // Messages List
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                            
                            if viewModel.isLoading {
                                LoadingIndicator()
                            }
                        }
                        .padding()
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        if let lastMessage = viewModel.messages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                Divider()
                
                // Input Bar
                inputBar
            }
            .navigationTitle("NUPI Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.clearChat()
                    }) {
                        Image(systemName: "trash")
                    }
                }
            }
            .sheet(isPresented: $showProviderPicker) {
                ProviderPickerView(selectedProvider: $viewModel.selectedProvider)
            }
        }
    }
    
    private var providerSelectionBar: some View {
        HStack {
            Image(systemName: viewModel.selectedProvider.icon)
                .foregroundColor(.blue)
            
            Text(viewModel.selectedProvider.rawValue)
                .font(.subheadline)
                .fontWeight(.medium)
            
            Spacer()
            
            Button("Change") {
                showProviderPicker = true
            }
            .font(.caption)
            .buttonStyle(.bordered)
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var inputBar: some View {
        HStack(spacing: 12) {
            TextField("Ask anything...", text: $viewModel.currentInput, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(1...5)
                .disabled(viewModel.isLoading)
            
            Button(action: {
                viewModel.sendMessage()
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(viewModel.currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .blue)
            }
            .disabled(viewModel.currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)
        }
        .padding()
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer(minLength: 50)
            }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                if !message.isUser, let provider = message.provider {
                    HStack(spacing: 4) {
                        Image(systemName: provider.icon)
                            .font(.caption2)
                        Text(provider.rawValue)
                            .font(.caption2)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.secondary)
                }
                
                Text(message.content)
                    .padding(12)
                    .background(message.isUser ? Color.blue : Color(.systemGray5))
                    .foregroundColor(message.isUser ? .white : .primary)
                    .cornerRadius(16)
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            if !message.isUser {
                Spacer(minLength: 50)
            }
        }
    }
}

struct LoadingIndicator: View {
    var body: some View {
        HStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Text("Thinking...")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
    }
}

struct ProviderPickerView: View {
    @Binding var selectedProvider: AIProvider
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    providerRow(for: .combined)
                } header: {
                    Text("Recommended")
                }
                
                Section {
                    ForEach(AIProvider.allCases.filter { $0 != .combined }) { provider in
                        providerRow(for: provider)
                    }
                } header: {
                    Text("Individual AI Models")
                }
            }
            .navigationTitle("Select AI Provider")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func providerRow(for provider: AIProvider) -> some View {
        Button(action: {
            selectedProvider = provider
            dismiss()
        }) {
            HStack(spacing: 12) {
                Image(systemName: provider.icon)
                    .font(.title3)
                    .foregroundColor(.blue)
                    .frame(width: 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(provider.rawValue)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(provider.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                if selectedProvider == provider {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    ContentView()
}
