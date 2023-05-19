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
        let userMessage = Message(content: content, type: .text, isUserMessage: true)
        self.messages.append(userMessage)
        self.messageCount += 1
        messageText = ""
        
        switch type {
        case .text:
            getCompletion(prompt: content)
        case .image:
            getGeneratedImage(prompt: content)
        }
    }
    
    // Add chat message to list of messages
    private func addResponseMessage(content: String, type: Message.MessageType, isUserMessage: Bool) {
        DispatchQueue.main.async {
            let message = Message(content: content, type: type, isUserMessage: isUserMessage)
            self.messages.append(message)
            self.messageCount += 1
        }
    }
    
    // MARK: - Functions to get GPT-3 completion and DALL-E image data
    
    // Get OpenAI GPT-3 response to user message
    private func getCompletion(prompt: String) {
        openAIService.sendCompletion(prompt: prompt) { result in
            switch result {
            case .success(let response):
                print("SUCCESS: Successfully retrieved ChatBot response!")
                var formattedResponse = response.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Send error message as response if response is empty string
                if formattedResponse.isEmpty {
                    formattedResponse = Constants.emptyResponse
                }
                self.addResponseMessage(content: formattedResponse, type: .text, isUserMessage: false)
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
                self.addResponseMessage(content: Constants.errorResponse, type: .text, isUserMessage: false)
            }
        }
    }
    
    // Get OpenAI DALL-E image generated from user prompt
    private func getGeneratedImage(prompt: String) {
        openAIService.sendImages(prompt: prompt) { result in
            switch result {
            case .success(let imageUrl):
                print("SUCCESS: Successfully retrieved DALL-E image url!")
                self.addResponseMessage(content: imageUrl, type: .image, isUserMessage: false)
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
                self.addResponseMessage(content: Constants.errorResponse, type: .text, isUserMessage: false)
            }
        }
    }
}
