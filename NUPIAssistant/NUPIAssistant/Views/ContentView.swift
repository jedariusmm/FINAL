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
            ZStack {
                // OUT OF THIS WORLD COSMIC BACKGROUND! 🌌✨🚀
                CosmicBackground()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Modern provider selection bar
                    providerSelectionBar
                    
                    // Messages List with fade effect
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.messages) { message in
                                    MessageBubble(message: message)
                                        .id(message.id)
                                        .transition(.asymmetric(
                                            insertion: .scale.combined(with: .opacity),
                                            removal: .opacity
                                        ))
                                }
                                
                                if viewModel.isLoading {
                                    LoadingIndicator()
                                        .transition(.scale.combined(with: .opacity))
                                }
                            }
                            .padding()
                            .padding(.bottom, 20)
                        }
                        .onChange(of: viewModel.messages.count) { _ in
                            if let lastMessage = viewModel.messages.last {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                    
                    // Elevated input bar
                    inputBar
                }
            }
            .navigationTitle("NUPI Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("🌟")
                        .font(.title2)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            viewModel.clearChat()
                        }
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .font(.title3)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.purple, .blue],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                }
            }
            .sheet(isPresented: $showProviderPicker) {
                ProviderPickerView(selectedProvider: $viewModel.selectedProvider)
            }
        }
    }
    
    private var providerSelectionBar: some View {
        HStack(spacing: 12) {
            // Avatar/Icon
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.purple.opacity(0.6), .blue.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40, height: 40)
                
                Image(systemName: viewModel.selectedProvider.icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.selectedProvider.rawValue)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Active AI")
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            Button(action: {
                showProviderPicker = true
            }) {
                HStack(spacing: 6) {
                    Text("Switch")
                        .font(.system(size: 14, weight: .semibold))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .bold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .overlay(
                            Capsule()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
                        )
                )
            }
        }
        .padding()
        .background(
            Color.black.opacity(0.3)
                .background(.ultraThinMaterial)
        )
    }
    
    private var inputBar: some View {
        HStack(spacing: 12) {
            // Text input with glassmorphism
            HStack {
                TextField("Ask me anything...", text: $viewModel.currentInput, axis: .vertical)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .lineLimit(1...5)
                    .disabled(viewModel.isLoading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white.opacity(0.15))
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
                    )
            )
            
            // Send button with COSMIC ENERGY! 🚀
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    viewModel.sendMessage()
                }
            }) {
                ZStack {
                    // Pulsing glow when active
                    if !viewModel.currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [.purple.opacity(0.6), .blue.opacity(0.4), .clear],
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: 30
                                )
                            )
                            .frame(width: 60, height: 60)
                            .blur(radius: 10)
                    }
                    
                    Circle()
                        .fill(
                            AngularGradient(
                                colors: viewModel.currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty 
                                    ? [.gray.opacity(0.3), .gray.opacity(0.3)]
                                    : [.purple, .blue, .cyan, .purple],
                                center: .center
                            )
                        )
                        .frame(width: 44, height: 44)
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: viewModel.currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                            ? [.clear]
                                            : [.cyan.opacity(0.8), .purple.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                    
                    Image(systemName: "arrow.up")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .cyan, radius: 5)
                }
            }
            .disabled(viewModel.currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)
            .scaleEffect(viewModel.currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.9 : 1.1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: viewModel.currentInput)
        }
        .padding()
        .background(
            Color.black.opacity(0.3)
                .background(.ultraThinMaterial)
        )
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    @State private var appeared = false
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            if message.isUser {
                Spacer(minLength: 60)
            } else {
                // AI Avatar - MYSTICAL GLOW
                ZStack {
                    // Ethereal outer glow
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [.purple.opacity(0.6), .blue.opacity(0.4), .clear],
                                center: .center,
                                startRadius: 0,
                                endRadius: 25
                            )
                        )
                        .frame(width: 44, height: 44)
                        .blur(radius: 10)
                    
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.purple.opacity(0.9), .blue.opacity(0.9)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 32, height: 32)
                        .overlay(
                            Circle()
                                .stroke(Color.cyan.opacity(0.5), lineWidth: 1.5)
                        )
                    
                    if let provider = message.provider {
                        Image(systemName: provider.icon)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(color: .cyan, radius: 3)
                    }
                }
                .offset(y: 8)
            }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 6) {
                if !message.isUser, let provider = message.provider {
                    HStack(spacing: 4) {
                        Text(provider.rawValue)
                            .font(.system(size: 12, weight: .semibold))
                        Image(systemName: "sparkles")
                            .font(.system(size: 10))
                    }
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 4)
                }
                
                Text(message.content)
                    .font(.system(size: 16))
                    .padding(16)
                    .background(
                        Group {
                            if message.isUser {
                                // COSMIC USER BUBBLE with glow
                                ZStack {
                                    // Outer glow
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(
                                            LinearGradient(
                                                colors: [.blue.opacity(0.5), .purple.opacity(0.5)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .blur(radius: 10)
                                        .padding(-5)
                                    
                                    // Main bubble with shimmer
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    Color(red: 0.3, green: 0.4, blue: 1.0),
                                                    Color(red: 0.5, green: 0.3, blue: 0.9),
                                                    Color(red: 0.4, green: 0.2, blue: 1.0)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(
                                                    LinearGradient(
                                                        colors: [.cyan.opacity(0.6), .purple.opacity(0.6)],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    ),
                                                    lineWidth: 2
                                                )
                                        )
                                }
                            } else {
                                // COSMIC AI BUBBLE with ethereal glow
                                ZStack {
                                    // Magical outer glow
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(
                                            RadialGradient(
                                                colors: [
                                                    Color.purple.opacity(0.4),
                                                    Color.blue.opacity(0.3),
                                                    Color.clear
                                                ],
                                                center: .center,
                                                startRadius: 0,
                                                endRadius: 100
                                            )
                                        )
                                        .blur(radius: 15)
                                        .padding(-10)
                                    
                                    // Glassmorphic AI bubble
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(Color.white.opacity(0.1))
                                        .background(.ultraThinMaterial)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .strokeBorder(
                                                    LinearGradient(
                                                        colors: [
                                                            Color.white.opacity(0.5),
                                                            Color.cyan.opacity(0.3),
                                                            Color.purple.opacity(0.3)
                                                        ],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    ),
                                                    lineWidth: 1.5
                                                )
                                        )
                                }
                            }
                        }
                    )
                    .foregroundColor(.white)
                    .shadow(
                        color: message.isUser 
                            ? Color.blue.opacity(0.6) 
                            : Color.purple.opacity(0.4),
                        radius: 15,
                        x: 0,
                        y: 8
                    )
                
                Text(message.timestamp, style: .time)
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.horizontal, 4)
            }
            
            if !message.isUser {
                Spacer(minLength: 60)
            } else {
                // User Avatar - COSMIC GLOW
                ZStack {
                    // Pulsing glow effect
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [.cyan.opacity(0.6), .blue.opacity(0.3), .clear],
                                center: .center,
                                startRadius: 0,
                                endRadius: 25
                            )
                        )
                        .frame(width: 44, height: 44)
                        .blur(radius: 8)
                    
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.cyan, .blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 32, height: 32)
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
                .offset(y: 8)
            }
        }
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 20)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                appeared = true
            }
        }
    }
}

struct LoadingIndicator: View {
    @State private var animating = false
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.purple.opacity(0.8), .blue.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 32, height: 32)
                
                Image(systemName: "sparkles")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(animating ? 360 : 0))
            }
            .offset(y: 8)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 8, height: 8)
                            .scaleEffect(animating ? 1.0 : 0.5)
                            .animation(
                                Animation.easeInOut(duration: 0.6)
                                    .repeatForever()
                                    .delay(Double(index) * 0.2),
                                value: animating
                            )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.white.opacity(0.15))
                        .background(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
                        )
                )
                
                Text("AI is thinking...")
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.horizontal, 4)
            }
            
            Spacer()
        }
        .onAppear {
            animating = true
        }
    }
}

struct ProviderPickerView: View {
    @Binding var selectedProvider: AIProvider
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.1, green: 0.1, blue: 0.2),
                        Color(red: 0.2, green: 0.1, blue: 0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Recommended section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("⭐ RECOMMENDED")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white.opacity(0.6))
                                .padding(.horizontal, 20)
                            
                            providerCard(for: .combined)
                        }
                        
                        // Individual AI models
                        VStack(alignment: .leading, spacing: 12) {
                            Text("🤖 INDIVIDUAL AI MODELS")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white.opacity(0.6))
                                .padding(.horizontal, 20)
                            
                            ForEach(AIProvider.allCases.filter { $0 != .combined }) { provider in
                                providerCard(for: provider)
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            .navigationTitle("Choose Your AI")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.purple, .blue],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                }
            }
        }
    }
    
    private func providerCard(for provider: AIProvider) -> some View {
        Button(action: {
            selectedProvider = provider
            dismiss()
        }) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: selectedProvider == provider 
                                    ? [.purple, .blue]
                                    : [.white.opacity(0.2), .white.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: provider.icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                // Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(provider.rawValue)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(provider.description)
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(2)
                }
                
                Spacer()
                
                // Selection indicator
                if selectedProvider == provider {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.green, .cyan],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white.opacity(selectedProvider == provider ? 0.2 : 0.1))
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(
                                selectedProvider == provider 
                                    ? Color.purple.opacity(0.5)
                                    : Color.white.opacity(0.2), 
                                lineWidth: selectedProvider == provider ? 2 : 1
                            )
                    )
            )
            .shadow(color: selectedProvider == provider ? Color.purple.opacity(0.3) : Color.clear, 
                   radius: 10, x: 0, y: 5)
            .padding(.horizontal, 20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - OUT OF THIS WORLD COSMIC BACKGROUND 🌌✨🚀
struct CosmicBackground: View {
    @State private var animateStars = false
    @State private var animateNebula = false
    @State private var animateGalaxy = false
    
    var body: some View {
        ZStack {
            // Deep space gradient - multiple layers for depth
            RadialGradient(
                colors: [
                    Color(red: 0.05, green: 0.0, blue: 0.15),
                    Color(red: 0.1, green: 0.0, blue: 0.2),
                    Color(red: 0.05, green: 0.1, blue: 0.25),
                    Color.black
                ],
                center: .center,
                startRadius: 50,
                endRadius: 600
            )
            
            // Nebula clouds - animated and mystical
            ZStack {
                // Purple nebula
                Ellipse()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.purple.opacity(0.4),
                                Color.purple.opacity(0.2),
                                Color.clear
                            ],
                            center: .topLeading,
                            startRadius: 0,
                            endRadius: 300
                        )
                    )
                    .frame(width: 400, height: 400)
                    .blur(radius: 40)
                    .offset(x: animateNebula ? -50 : 50, y: animateNebula ? -30 : 30)
                
                // Blue nebula
                Ellipse()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.blue.opacity(0.4),
                                Color.cyan.opacity(0.2),
                                Color.clear
                            ],
                            center: .bottomTrailing,
                            startRadius: 0,
                            endRadius: 250
                        )
                    )
                    .frame(width: 350, height: 350)
                    .blur(radius: 50)
                    .offset(x: animateNebula ? 40 : -40, y: animateNebula ? 50 : -50)
                
                // Pink nebula
                Ellipse()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.pink.opacity(0.3),
                                Color.purple.opacity(0.2),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: 200
                        )
                    )
                    .frame(width: 300, height: 300)
                    .blur(radius: 60)
                    .offset(x: animateNebula ? 30 : -30, y: animateNebula ? -40 : 40)
            }
            
            // Twinkling stars field
            ForEach(0..<150, id: \.self) { index in
                Circle()
                    .fill(Color.white.opacity(Double.random(in: 0.3...1.0)))
                    .frame(width: CGFloat.random(in: 1...3), height: CGFloat.random(in: 1...3))
                    .position(
                        x: CGFloat.random(in: 0...400),
                        y: CGFloat.random(in: 0...800)
                    )
                    .opacity(animateStars ? 1.0 : 0.3)
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 0.5...2.0))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...1.0)),
                        value: animateStars
                    )
            }
            
            // Shooting stars
            ForEach(0..<5, id: \.self) { index in
                ShootingStar(delay: Double(index) * 3.0)
            }
            
            // Rotating galaxy effect in background
            Circle()
                .fill(
                    AngularGradient(
                        colors: [
                            Color.purple.opacity(0.3),
                            Color.blue.opacity(0.2),
                            Color.cyan.opacity(0.2),
                            Color.purple.opacity(0.3)
                        ],
                        center: .center
                    )
                )
                .frame(width: 500, height: 500)
                .blur(radius: 80)
                .rotationEffect(.degrees(animateGalaxy ? 360 : 0))
                .opacity(0.4)
        }
        .onAppear {
            withAnimation(.linear(duration: 60).repeatForever(autoreverses: false)) {
                animateGalaxy = true
            }
            withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                animateNebula = true
            }
            animateStars = true
        }
    }
}

// Shooting star effect
struct ShootingStar: View {
    @State private var isVisible = false
    @State private var offset: CGSize = .zero
    let delay: Double
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [Color.white, Color.white.opacity(0.0)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: 60, height: 2)
            .rotationEffect(.degrees(-45))
            .offset(offset)
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                animateShootingStar()
            }
    }
    
    private func animateShootingStar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            // Random starting position
            offset = CGSize(
                width: CGFloat.random(in: -200...200),
                y: CGFloat.random(in: -400...0)
            )
            isVisible = true
            
            withAnimation(.easeIn(duration: 0.8)) {
                offset = CGSize(
                    width: offset.width + 300,
                    y: offset.height + 300
                )
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                isVisible = false
                // Repeat after random delay
                DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 3...8)) {
                    animateShootingStar()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
