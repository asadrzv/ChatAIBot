//
//  ChatViewModel.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    private let openAIService: OpenAIService
    
    @Published var messages = [Message]()
    @Published var messageText = ""
    @Published var messageCount = 0
    
    // Remove leading whitespace/newlines from messageText
    var formattedMessageText: String {
        return messageText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init(openAIService: OpenAIService) {
        self.openAIService = openAIService
    }
    
    // MARK: - Action Handlers
    
    // Clear all chat messages
    func clearChat() {
        messages = [Message]()
        messageCount = 0
        messageText = ""
    }
    
    // Send message to get GPT-3 completion
    func sendGPT3Message() {
        sendMessage(content: formattedMessageText, type: .text)
    }
    
    // Send message to get DALL-E image data
    func sendDALLEMessage() {
        sendMessage(content: formattedMessageText, type: .image)
    }
    
    // MARK: - Functions to get OpenAI response and store in message list
        
    // Send message through OpenAI client and append it to the list of messages
    func sendMessage(content: String, type: Message.MessageType) {
        addUserMessage(text: content)
        messageText = ""
        
        switch type {
        case .text:
            getCompletion(prompt: content)
        case .image:
            getGeneratedImage(prompt: content)
        }
    }
    
    // Add user inputted message to list of messages
    private func addUserMessage(text: String) {
        let userMessage = Message(content: text, type: .text, isUserMessage: true)
        self.messages.append(userMessage)
        // Separately increment message count for auto-scroll
        self.messageCount += 1
    }
    
    // MARK: - Functions to get GPT-3 completion and DALL-E image data
    
    // Get OpenAI Chat Bot response to user message
    private func getCompletion(prompt: String) {
        openAIService.sendCompletion(prompt: prompt) { result in
            switch result {
            case .success(let response):
                print("SUCCESS: Successfully retrieved ChatBot response!")
                var formattedResponse = response.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Send error message as response if response is empty string
                if formattedResponse.isEmpty {
                    formattedResponse = "I'm sorry 😢, I couldn't quite understand that. Try rephrasing your request as either a statement or question."
                }
                
                let chatBotMessage = Message(content: formattedResponse, type: .text, isUserMessage: false)
                
                // Add response to list of messages
                DispatchQueue.main.async {
                    self.messages.append(chatBotMessage)
                    self.messageCount += 1
                }
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    // Get OpenAI DALL-E image generated from user prompt
    private func getGeneratedImage(prompt: String) {
        openAIService.sendImages(prompt: prompt) { result in
            switch result {
            case .success(let imageUrl):
                print("SUCCESS: Successfully retrieved DALL-E image url!")
                let chatBotMessage = Message(content: imageUrl, type: .image, isUserMessage: false)
                
                // Add image to list of messages
                DispatchQueue.main.async {
                    self.messages.append(chatBotMessage)
                    self.messageCount += 1
                }
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
}
