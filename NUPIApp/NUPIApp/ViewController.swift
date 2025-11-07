//
//  ViewController.swift
//  NUPIApp
//
//  Created for NUPI AI Assistant
//

#if canImport(UIKit)
import UIKit
typealias PlatformViewController = UIViewController
#elseif canImport(AppKit)
import AppKit
typealias PlatformViewController = NSViewController
#endif

class ViewController: PlatformViewController {
    
    #if canImport(UIKit)
    // Modern UI components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemPurple
        imageView.image = UIImage(systemName: "brain.head.profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NUPI AI"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textAlignment = .center
        
        // Add gradient text color effect
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Intelligent Companion"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .systemIndigo
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Powered by advanced AI"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemPurple
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statusIconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Conversation", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.systemPurple.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Create gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.cornerRadius = 16
        button.layer.insertSublayer(gradientLayer, at: 0)
        
        return button
    }()
    
    private let configureButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⚙️ Configure API Key", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.systemIndigo, for: .normal)
        button.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.1)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.systemIndigo.withAlphaComponent(0.3).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NUPI"
        
        // Vibrant gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemPink.withAlphaComponent(0.05).cgColor,
            UIColor.systemPurple.withAlphaComponent(0.08).cgColor,
            UIColor.systemBlue.withAlphaComponent(0.05).cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        setupUI()
        updateAPIStatus()
        
        // Update button gradient frame after layout
        DispatchQueue.main.async { [weak self] in
            if let gradientLayer = self?.chatButton.layer.sublayers?.first as? CAGradientLayer {
                gradientLayer.frame = self?.chatButton.bounds ?? .zero
            }
        }
        
        chatButton.addTarget(self, action: #selector(openChat), for: .touchUpInside)
        configureButton.addTarget(self, action: #selector(configureAPIKey), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update gradient frames
        if let gradientLayer = view.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = view.bounds
        }
        if let buttonGradient = chatButton.layer.sublayers?.first as? CAGradientLayer {
            buttonGradient.frame = chatButton.bounds
        }
    }
    
    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(statusContainerView)
        statusContainerView.addSubview(statusIconLabel)
        statusContainerView.addSubview(statusLabel)
        contentView.addSubview(chatButton)
        contentView.addSubview(configureButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            statusContainerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            statusContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            statusContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            statusContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            statusContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            statusIconLabel.topAnchor.constraint(equalTo: statusContainerView.topAnchor, constant: 16),
            statusIconLabel.centerXAnchor.constraint(equalTo: statusContainerView.centerXAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: statusIconLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: statusContainerView.leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: statusContainerView.trailingAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(equalTo: statusContainerView.bottomAnchor, constant: -16),
            
            chatButton.topAnchor.constraint(equalTo: statusContainerView.bottomAnchor, constant: 32),
            chatButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            chatButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            chatButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            chatButton.heightAnchor.constraint(equalToConstant: 56),
            
            configureButton.topAnchor.constraint(equalTo: chatButton.bottomAnchor, constant: 16),
            configureButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            configureButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            configureButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            configureButton.heightAnchor.constraint(equalToConstant: 48),
            configureButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func updateAPIStatus() {
        if APIConfiguration.isConfigured {
            statusIconLabel.text = "✨"
            statusLabel.text = "API Key Configured\n✓ Premium Account Active"
            statusLabel.textColor = .systemGreen
            
            // Add gradient to status container
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor.systemGreen.withAlphaComponent(0.15).cgColor,
                UIColor.systemTeal.withAlphaComponent(0.1).cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.cornerRadius = 16
            gradientLayer.frame = statusContainerView.bounds
            
            statusContainerView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            statusContainerView.layer.insertSublayer(gradientLayer, at: 0)
            
            statusContainerView.layer.borderWidth = 2
            statusContainerView.layer.borderColor = UIColor.systemGreen.withAlphaComponent(0.3).cgColor
        } else {
            statusIconLabel.text = "🔑"
            statusLabel.text = "API Key Required\nConfigure your NUPI Premium key"
            statusLabel.textColor = .systemOrange
            
            // Add gradient to status container
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor.systemOrange.withAlphaComponent(0.15).cgColor,
                UIColor.systemYellow.withAlphaComponent(0.1).cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.cornerRadius = 16
            gradientLayer.frame = statusContainerView.bounds
            
            statusContainerView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            statusContainerView.layer.insertSublayer(gradientLayer, at: 0)
            
            statusContainerView.layer.borderWidth = 2
            statusContainerView.layer.borderColor = UIColor.systemOrange.withAlphaComponent(0.3).cgColor
        }
    }
    
    @objc private func openChat() {
        let chatVC = ChatViewController()
        let navController = UINavigationController(rootViewController: chatVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    @objc private func configureAPIKey() {
        let alert = UIAlertController(title: "Configure API Key", message: "Enter your NUPI Premium API key:", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "API Key"
            textField.text = APIConfiguration.apiKey == "YOUR_API_KEY_HERE" ? "" : APIConfiguration.apiKey
            textField.isSecureTextEntry = true
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let apiKey = alert.textFields?.first?.text, !apiKey.isEmpty {
                APIConfiguration.setAPIKey(apiKey)
                self?.updateAPIStatus()
                
                // Show success feedback
                let successAlert = UIAlertController(title: "Success", message: "API key configured successfully!", preferredStyle: .alert)
                successAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(successAlert, animated: true)
            }
        })
        present(alert, animated: true)
    }
    
    #else
    // macOS implementation
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        
        let label = NSTextField(labelWithString: "NUPI AI Assistant\n\nFull macOS interface coming soon!\nFor now, please use the iOS version.")
        label.alignment = .center
        label.font = NSFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    #endif
}
