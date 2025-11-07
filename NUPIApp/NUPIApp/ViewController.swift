//
//  ViewController.swift
//  NUPIApp
//
//  Created for NUPI AI Assistant
//

#if canImport(UIKit)
import UIKit
typealias PlatformViewController = UIViewController
typealias PlatformLabel = UILabel
typealias PlatformButton = UIButton
typealias PlatformTextField = UITextField
typealias PlatformColor = UIColor
typealias PlatformFont = UIFont
#elseif canImport(AppKit)
import AppKit
typealias PlatformViewController = NSViewController
typealias PlatformLabel = NSTextField
typealias PlatformButton = NSButton
typealias PlatformTextField = NSTextField
typealias PlatformColor = NSColor
typealias PlatformFont = NSFont
#endif

class ViewController: PlatformViewController {
    
    private let titleLabel: PlatformLabel = {
        #if canImport(UIKit)
        let label = UILabel()
        label.text = "NUPI AI Assistant"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        #else
        let label = NSTextField(labelWithString: "NUPI AI Assistant")
        label.font = NSFont.systemFont(ofSize: 32, weight: .bold)
        label.alignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        #endif
    }()
    
    private let subtitleLabel: PlatformLabel = {
        #if canImport(UIKit)
        let label = UILabel()
        label.text = "Welcome to NUPI"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        #else
        let label = NSTextField(labelWithString: "Welcome to NUPI")
        label.font = NSFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .systemGray
        label.alignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        #endif
    }()
    
    private let descriptionLabel: PlatformLabel = {
        #if canImport(UIKit)
        let label = UILabel()
        label.text = "Your AI Assistant for iOS & macOS"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .systemGray2
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        #else
        let label = NSTextField(labelWithString: "Your AI Assistant for iOS & macOS")
        label.font = NSFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .systemGray
        label.alignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        #endif
    }()
    
    private let statusLabel: PlatformLabel = {
        #if canImport(UIKit)
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        #else
        let label = NSTextField(labelWithString: "")
        label.font = NSFont.systemFont(ofSize: 14, weight: .regular)
        label.alignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        #endif
    }()
    
    private let chatButton: PlatformButton = {
        #if canImport(UIKit)
        let button = UIButton(type: .system)
        button.setTitle("💬 Start Chat with NUPI", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        #else
        let button = NSButton()
        button.title = "💬 Start Chat with NUPI"
        button.bezelStyle = .rounded
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        #endif
    }()
    
    private let configureButton: PlatformButton = {
        #if canImport(UIKit)
        let button = UIButton(type: .system)
        button.setTitle("Configure API Key", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        #else
        let button = NSButton()
        button.title = "Configure API Key"
        button.bezelStyle = .rounded
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        #endif
    }()

    #if canImport(UIKit)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NUPI AI Assistant"
        view.backgroundColor = .systemBackground
        setupUI()
        updateAPIStatus()
        chatButton.addTarget(self, action: #selector(openChat), for: .touchUpInside)
        configureButton.addTarget(self, action: #selector(configureAPIKey), for: .touchUpInside)
    }
    #else
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        setupUI()
        updateAPIStatus()
        chatButton.target = self
        chatButton.action = #selector(openChat)
        configureButton.target = self
        configureButton.action = #selector(configureAPIKey)
    }
    #endif
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(statusLabel)
        view.addSubview(chatButton)
        view.addSubview(configureButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 12),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            statusLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            chatButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 30),
            chatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chatButton.widthAnchor.constraint(equalToConstant: 280),
            chatButton.heightAnchor.constraint(equalToConstant: 50),
            
            configureButton.topAnchor.constraint(equalTo: chatButton.bottomAnchor, constant: 15),
            configureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            configureButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }
    
    private func updateAPIStatus() {
        if APIConfiguration.isConfigured {
            #if canImport(UIKit)
            statusLabel.text = "✓ API Key Configured (Premium Account)"
            statusLabel.textColor = .systemGreen
            #else
            statusLabel.stringValue = "✓ API Key Configured (Premium Account)"
            statusLabel.textColor = .systemGreen
            #endif
        } else {
            #if canImport(UIKit)
            statusLabel.text = "⚠️ API Key Not Configured\nPlease add your NUPI Premium API key"
            statusLabel.textColor = .systemOrange
            #else
            statusLabel.stringValue = "⚠️ API Key Not Configured\nPlease add your NUPI Premium API key"
            statusLabel.textColor = .systemOrange
            #endif
        }
    }
    
    @objc private func openChat() {
        #if canImport(UIKit)
        let chatVC = ChatViewController()
        let navController = UINavigationController(rootViewController: chatVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
        #else
        // macOS chat interface would go here
        let alert = NSAlert()
        alert.messageText = "Chat with NUPI"
        alert.informativeText = "The full chat interface is coming soon to macOS! For now, you can use the iOS version."
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
        #endif
    }
    
    @objc private func configureAPIKey() {
        #if canImport(UIKit)
        let alert = UIAlertController(title: "Configure API Key", message: "Enter your NUPI Premium API key:", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "API Key"
            textField.text = APIConfiguration.apiKey == "YOUR_API_KEY_HERE" ? "" : APIConfiguration.apiKey
            textField.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let apiKey = alert.textFields?.first?.text, !apiKey.isEmpty {
                APIConfiguration.setAPIKey(apiKey)
                self?.updateAPIStatus()
            }
        })
        present(alert, animated: true)
        #else
        let alert = NSAlert()
        alert.messageText = "Configure API Key"
        alert.informativeText = "Enter your NUPI Premium API key:"
        alert.alertStyle = .informational
        
        let textField = NSSecureTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 24))
        textField.stringValue = APIConfiguration.apiKey == "YOUR_API_KEY_HERE" ? "" : APIConfiguration.apiKey
        alert.accessoryView = textField
        
        alert.addButton(withTitle: "Save")
        alert.addButton(withTitle: "Cancel")
        
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            let apiKey = textField.stringValue
            if !apiKey.isEmpty {
                APIConfiguration.setAPIKey(apiKey)
                updateAPIStatus()
            }
        }
        #endif
    }
}
