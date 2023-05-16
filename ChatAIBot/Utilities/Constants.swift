//
//  Constants.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation

struct Constants {
    
    // Sample text message
    static let sampleTextMessage = Message(
        content: samleUserPrompt,
        type: .text,
        isUserMessage: true
    )
    
    // Sample image message
    static let sampleImageMessage = Message(
        content: sampleImageUrl,
        type: .image,
        isUserMessage: true
    )
    
    // Sample user text message
    static let samleUserPrompt = "SAMPLE USER MESSAGE"
    
    // Sample OpenAI GPT-3 completion response
    static let sampleChatBotResponse = "SAMPLE CHATBOT COMPLETION RESPONSE"

    // Sample OpenAI DALL-E generated image url
    static let sampleImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png"
}
