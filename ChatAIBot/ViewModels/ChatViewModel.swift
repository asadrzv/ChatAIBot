//
//  ChatViewModel.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    @Published var messageText = ""
    @Published var messageCount = 0
        
    // Send message through OpenAI client and append it to the list of models
    func sendMessage() {
        // Cancel send message if text empty
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        // Add new message sent by user to list of all messages
        let userMessage = Message(text: messageText, type: .Sent)
        self.messages.append(userMessage)
        self.messageCount += 1 // Separately increment message count for auto-scroll animation
        
        // Add new message sent by OpenAI Chat bot to list of all messages
        OpenAIManager.shared.sendCompletion(text: messageText) { response in
            let formattedResponse = response.trimmingCharacters(in: .whitespaces)
            let chatBotMessage = Message(text: formattedResponse, type: .Received)
            
            DispatchQueue.main.async {
                self.messages.append(chatBotMessage)
                self.messageCount += 1
                self.messageText = ""
            }
        }
    }
}
