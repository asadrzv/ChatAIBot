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
        content: sampleUserPrompt,
        type: .text,
        isUserMessage: true
    )
    
    // Sample image message
    static let sampleImageMessage = Message(
        content: sampleImageUrl,
        type: .image,
        isUserMessage: true
    )
    
    // Intro messages to be shown on app launch
    static let introMessages = [
        Message(content: "What exactly is Chat AI?", type: .text, isUserMessage: true),
        Message(content: "Chat AI 💬 is the next-gen tool here to skyrocket 🚀 your productivity 📈 and keep you on track for success 😃", type: .text, isUserMessage: false),
        Message(content: "But what does it actually do?", type: .text, isUserMessage: true),
        Message(content: "Chat AI 😎 can do almost anything, from writing those pesky work emails ✉️ to helping you out with HW 📚", type: .text, isUserMessage: false),
        Message(content: "Really?! That's so cool! Let me try...", type: .text, isUserMessage: true),
    ]
    
    // Sample user text message
    static let sampleUserPrompt = "SAMPLE USER MESSAGE"
    
    // Sample OpenAI GPT-3 completion response
    static let sampleChatBotResponse = "SAMPLE CHATBOT COMPLETION RESPONSE"

    // Sample OpenAI DALL-E generated image url
    static let sampleImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png"
}
