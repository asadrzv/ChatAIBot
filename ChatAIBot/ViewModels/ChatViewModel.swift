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
    @Published var messageCount = 0
    
    init(openAIService: OpenAIService) {
        self.openAIService = openAIService
    }
        
    // Send message through OpenAI client and append it to the list of models
    func sendMessage(messageText: String) {
        let formattedMessageText = messageText.trimmingCharacters(in: .whitespacesAndNewlines)

        // Do not send message if text empty
        guard !formattedMessageText.isEmpty else {
            print("ERROR: Message text empty!")
            return
        }
        
        // Add new message sent by user to list of messages
        let userMessage = Message(text: messageText, isUserMessage: true)
        self.messages.append(userMessage)
        self.messageCount += 1 // Separately increment message count for auto-scroll animation
        
        // Get OpenAI Chat Bot response to user message
        getResponse(messageText: messageText)
    }
    
    // Get OpenAI Chat Bot response to user message
    private func getResponse(messageText: String) {
        openAIService.sendCompletion(text: messageText) { result in
            switch result {
            case .success(let response):
                print("SUCCESS: Successfully retrieved ChatBot response!")
                let formattedResponse = response.trimmingCharacters(in: .whitespacesAndNewlines)
                let chatBotMessage = Message(text: formattedResponse, isUserMessage: false)
                
                // Add response to list of messages
                DispatchQueue.main.async {
                    self.messages.append(chatBotMessage)
                    self.messageCount += 1
                    //self.messageText = ""
                }
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
}
