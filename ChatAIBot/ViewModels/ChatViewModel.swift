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
    
    // Trim leading whitespace/newlines from messageText
    var trimmedMessageText: String {
        return messageText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init(openAIService: OpenAIService) {
        self.openAIService = openAIService
    }
        
    // Clear all chat messages
    func clearChat() {
        messages = [Message]()
        messageText = ""
    }

    // MARK: - Functions to get OpenAI response and store in message list
    
    // Send message through OpenAI client and append it to the list of messages
    // type: .text -> Send message to get GPT-3 completion
    // type: .image -> Send message to get DALL-E image data
    func sendMessage(forType type: Message.MessageType) {
        sendMessage(withContent: trimmedMessageText, forType: type)
    }
        
    // Send message through OpenAI client and append it to the list of messages
    func sendMessage(withContent content: String, forType messageType: Message.MessageType) {
        let userMessage = Message(content: content, type: .text, isUserMessage: true)
        self.messages.append(userMessage)
        messageText = ""
        
        switch messageType {
        case .text:
            getCompletion(prompt: content)
        case .image:
            getGeneratedImage(prompt: content)
        }
    }
    
    // Add chat message to list of messages
    private func addResponseMessage(withContent content: String, ofType type: Message.MessageType, isUserMessage: Bool) {
        DispatchQueue.main.async {
            let message = Message(content: content, type: type, isUserMessage: isUserMessage)
            self.messages.append(message)
        }
    }
    
    // MARK: - Functions to get GPT-3 completion and DALL-E image data
    
    // Get OpenAI GPT-3 response to user message
    private func getCompletion(prompt: String) {
        openAIService.sendCompletion(with: prompt) { result in
            switch result {
            case .success(let response):
                print("SUCCESS: Successfully retrieved ChatBot response!")
                var formattedResponse = response.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Send error message as response if response is empty string
                if formattedResponse.isEmpty {
                    formattedResponse = Constants.emptyResponse
                }
                self.addResponseMessage(withContent: formattedResponse, ofType: .text, isUserMessage: false)
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
                self.addResponseMessage(withContent: Constants.errorResponse, ofType: .text, isUserMessage: false)
            }
        }
    }
    
    // Get OpenAI DALL-E image generated from user prompt
    private func getGeneratedImage(prompt: String) {
        openAIService.sendImages(with: prompt) { result in
            switch result {
            case .success(let imageURL):
                print("SUCCESS: Successfully retrieved DALL-E image url!")
                self.addResponseMessage(withContent: imageURL, ofType: .image, isUserMessage: false)
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
                self.addResponseMessage(withContent: Constants.errorResponse, ofType: .text, isUserMessage: false)
            }
        }
    }
}
