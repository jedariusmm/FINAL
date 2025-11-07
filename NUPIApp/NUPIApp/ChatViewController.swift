//
//  ChatViewController.swift
//  NUPIApp
//
//  Created for NUPI AI Assistant
//

#if canImport(UIKit)
import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    private let tableView = UITableView()
    private let inputContainerView = UIView()
    private let inputTextField = UITextField()
    private let sendButton = UIButton(type: .system)
    private var messages: [NUPIAIService.Message] = []
    private var inputBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NUPI"
        
        // Vibrant gradient background - more colorful!
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemBlue.withAlphaComponent(0.15).cgColor,
            UIColor.systemPurple.withAlphaComponent(0.15).cgColor,
            UIColor.systemPink.withAlphaComponent(0.1).cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        setupModernNavigationBar()
        setupUI()
        loadMessages()
        
        // Keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupModernNavigationBar() {
        // Modern navigation bar styling with color
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Gradient-like effect with subtle color
        appearance.backgroundColor = UIColor.systemBackground
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.systemBlue
        ]
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .systemBlue
        
        // Colorful bar button items
        let clearButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.counterclockwise.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(clearChat)
        )
        clearButton.tintColor = .systemPurple
        navigationItem.rightBarButtonItem = clearButton
        
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(dismissChat)
        )
        closeButton.tintColor = .systemPink
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc private func dismissChat() {
        dismiss(animated: true)
    }
    
    private func setupUI() {
        // Table view setup with modern styling
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        view.addSubview(tableView)
        
        // Modern input container with shadow
        inputContainerView.backgroundColor = .systemBackground
        inputContainerView.layer.shadowColor = UIColor.black.cgColor
        inputContainerView.layer.shadowOffset = CGSize(width: 0, height: -2)
        inputContainerView.layer.shadowOpacity = 0.1
        inputContainerView.layer.shadowRadius = 8
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputContainerView)
        
        // Modern text field with custom styling
        inputTextField.placeholder = "Message NUPI..."
        inputTextField.font = UIFont.systemFont(ofSize: 16)
        inputTextField.backgroundColor = .systemGray6
        inputTextField.layer.cornerRadius = 20
        inputTextField.layer.masksToBounds = true
        inputTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 40))
        inputTextField.leftViewMode = .always
        inputTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 40))
        inputTextField.rightViewMode = .always
        inputTextField.delegate = self
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.addSubview(inputTextField)
        
        // Colorful send button with gradient icon
        sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        sendButton.tintColor = .systemPurple
        sendButton.contentVerticalAlignment = .fill
        sendButton.contentHorizontalAlignment = .fill
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.addSubview(sendButton)
        
        // Constraints
        inputBottomConstraint = inputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
            
            inputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBottomConstraint,
            inputContainerView.heightAnchor.constraint(equalToConstant: 70),
            
            inputTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 16),
            inputTextField.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -12),
            inputTextField.heightAnchor.constraint(equalToConstant: 40),
            
            sendButton.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -16),
            sendButton.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 36),
            sendButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func loadMessages() {
        messages = NUPIAIService.shared.getConversationHistory()
        tableView.reloadData()
        scrollToBottom()
    }
    
    @objc private func sendMessage() {
        guard let text = inputTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            return
        }
        
        inputTextField.text = ""
        inputTextField.resignFirstResponder()
        
        // Show thinking message
        let thinkingMessage = NUPIAIService.Message(role: "assistant", content: NUPIPersonality.getThinkingMessage())
        messages.append(thinkingMessage)
        tableView.reloadData()
        scrollToBottom()
        
        NUPIAIService.shared.sendMessage(text) { [weak self] result in
            guard let self = self else { return }
            
            // Remove thinking message
            if self.messages.last?.content == thinkingMessage.content {
                self.messages.removeLast()
            }
            
            switch result {
            case .success(_):
                self.loadMessages()
            case .failure(_):
                let errorMessage = NUPIAIService.Message(role: "assistant", content: NUPIPersonality.getErrorMessage())
                self.messages.append(errorMessage)
                self.tableView.reloadData()
                self.scrollToBottom()
            }
        }
    }
    
    @objc private func clearChat() {
        let alert = UIAlertController(title: "Clear Chat", message: "Are you sure you want to clear the conversation?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive) { [weak self] _ in
            NUPIAIService.shared.clearHistory()
            self?.loadMessages()
        })
        present(alert, animated: true)
    }
    
    private func scrollToBottom() {
        guard messages.count > 0 else { return }
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            inputBottomConstraint.constant = -keyboardHeight
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        inputBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatMessageCell
        let message = messages[indexPath.row]
        cell.configure(with: message)
        return cell
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
}

class ChatMessageCell: UITableViewCell {
    private let bubbleView = UIView()
    private let messageLabel = UILabel()
    private let timeLabel = UILabel()
    private var bubbleLeadingConstraint: NSLayoutConstraint?
    private var bubbleTrailingConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        // Modern bubble with enhanced shadow for depth
        bubbleView.layer.cornerRadius = 20
        bubbleView.layer.shadowColor = UIColor.black.cgColor
        bubbleView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bubbleView.layer.shadowOpacity = 0.2
        bubbleView.layer.shadowRadius = 6
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bubbleView)
        
        // Modern message label
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.addSubview(messageLabel)
        
        // Time label for sophistication
        timeLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        timeLabel.textColor = .secondaryLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 14),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -14),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -16),
            
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            timeLabel.topAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 4),
            timeLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -2)
        ])
    }
    
    func configure(with message: NUPIAIService.Message) {
        messageLabel.text = message.content
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeLabel.text = formatter.string(from: message.timestamp)
        
        // Remove old constraints
        bubbleLeadingConstraint?.isActive = false
        bubbleTrailingConstraint?.isActive = false
        
        if message.role == "user" {
            // Vibrant gradient for user messages
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor.systemBlue.cgColor,
                UIColor.systemPurple.cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.cornerRadius = 20
            
            bubbleView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            bubbleView.layer.insertSublayer(gradientLayer, at: 0)
            
            DispatchQueue.main.async {
                gradientLayer.frame = self.bubbleView.bounds
            }
            
            messageLabel.textColor = .white
            messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            timeLabel.textAlignment = .right
            timeLabel.textColor = .systemBlue
            
            bubbleTrailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            bubbleLeadingConstraint = bubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 80)
            
            timeLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor).isActive = true
        } else {
            // Vibrant gradient for AI messages - much more colorful!
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor.systemTeal.cgColor,
                UIColor.systemCyan.cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.cornerRadius = 20
            
            bubbleView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            bubbleView.layer.insertSublayer(gradientLayer, at: 0)
            
            DispatchQueue.main.async {
                gradientLayer.frame = self.bubbleView.bounds
            }
            
            // White text for high contrast on colorful bubble
            messageLabel.textColor = .white
            messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            timeLabel.textAlignment = .left
            timeLabel.textColor = .systemTeal
            
            bubbleLeadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            bubbleTrailingConstraint = bubbleView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -80)
            
            timeLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor).isActive = true
        }
        
        bubbleLeadingConstraint?.isActive = true
        bubbleTrailingConstraint?.isActive = true
    }
}

#endif
