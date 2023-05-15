//
//  ChatViewModel.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    private let openAIManager = OpenAIManager()
    
    @Published var messages = [Message]()
    @Published var messageText = ""
    @Published var messageCount = 0
        
    // Send message through OpenAI client and append it to the list of models
    func sendMessage() {
        // Cancel send message if text empty
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        // Add new message sent by user to list of messages
        let userMessage = Message(text: messageText, type: .Sent)
        self.messages.append(userMessage)
        self.messageCount += 1 // Separately increment message count for auto-scroll animation
        
        // Get OpenAI Chat Bot response to user message
        // Add response to list of messages
        openAIManager.sendCompletion(text: messageText) { result in
            switch result {
            case .success(let response):
                let formattedResponse = response.trimmingCharacters(in: .whitespacesAndNewlines)
                let chatBotMessage = Message(text: formattedResponse, type: .Received)
                
                DispatchQueue.main.async {
                    self.messages.append(chatBotMessage)
                    self.messageCount += 1
                    self.messageText = ""
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
