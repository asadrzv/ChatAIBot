//
//  Constants.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation

struct Constants {
    
    // Sample user text message
    static let sampleUserPrompt = "SAMPLE USER PROMPT"
    
    // Sample OpenAI GPT-3 completion response
    static let sampleAIResponse = "SAMPLE AI RESPONSE"

    // Sample OpenAI DALL-E generated image url
    static let sampleImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png"
    
    // Error response text to OpenAI's API returning an error
    static let errorResponse = "Oh no 😢, I'm having some trouble connecting to the server 🛠️ right now! Try again later, or maybe check out the full version of the app for unlimited 💯 AI access!"
    
    // Reponse for when OpenAI returns an empty string
    static let emptyResponse = "I'm sorry 😅, I couldn't quite understand that. Try rephrasing your request as either a statement or question."
    
    // Sample text message
    static let sampleTextMessage = Message(content: sampleUserPrompt, type: .text, isUserMessage: true)
    
    // Sample image message
    static let sampleImageMessage = Message(content: sampleImageUrl, type: .image, isUserMessage: false)
    
    // Intro messages to be shown on app launch
    static let introMessages = [
        Message(content: "What exactly is Chat AI?", type: .text, isUserMessage: true),
        Message(content: "Chat AI 💬 is the next-gen tool here to skyrocket 🚀 your productivity 📈 and keep you on track for success 😃", type: .text, isUserMessage: false),
        Message(content: "But what does it actually do?", type: .text, isUserMessage: true),
        Message(content: "Chat AI 😎 can do almost anything, from writing those pesky work emails ✉️ to helping you out with HW 📚", type: .text, isUserMessage: false),
        Message(content: "Really?! That's so cool! Let me try...", type: .text, isUserMessage: true),
    ]
}
