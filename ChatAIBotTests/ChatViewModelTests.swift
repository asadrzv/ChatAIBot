//
//  ChatViewModelTests.swift
//  ChatAIBotTests
//
//  Created by Asad Rizvi on 5/15/23.
//

import XCTest
@testable import ChatAIBot

final class ChatViewModelTests: XCTestCase {
    // Use protocal-driven development and dependency injection to allow testing
    let mockChatViewModel = ChatViewModel(openAIService: MockOpenAIManager())
    
    // Test ChatViewModel initial state
    func testInitialValues() {
        // Assert no messages saved yet
        XCTAssert(mockChatViewModel.messages.count == 0)
        XCTAssert(mockChatViewModel.messageCount == 0)
    }
    
    // Test clearChat function in ChatViewModel
    func testClearChat() {
        // Sample chat message list
        let testData = [
            Message(content: "1 SAMPLE USER MESSAGE", type: .text, isUserMessage: true),
            Message(content: "2 SAMPLE CHATBOT RESPONSE", type: .text, isUserMessage: false),
            Message(content: "3 SAMPLE USER MESSAGE", type: .text, isUserMessage: true),
            Message(content: "4 SAMPLE CHATBOT RESPONSE", type: .image, isUserMessage: false)
        ]
        
        // Add test data to message list
        mockChatViewModel.messages.append(contentsOf: testData)
        mockChatViewModel.messageCount += 4
        
        // Simulate user tapping clear button
        mockChatViewModel.clearChat()
        
        // Assert all message data cleared and count reset
        XCTAssert(mockChatViewModel.messages.count == 0)
        XCTAssert(mockChatViewModel.messageCount == 0)
    }
    
    // Test getCompletion function in ChatViewModel
    func testSendGPT3Message() {
        // Simulate user sending single message
        mockChatViewModel.sendMessage(content: "SAMPLE USER MESSAGE", type: .text)
        
        // Assert user message added to list of messages
        XCTAssert(mockChatViewModel.messages[0].content == "SAMPLE USER MESSAGE")
        XCTAssert(mockChatViewModel.messageCount == 1)
        
        let asyncExpectation = expectation(description: "Async send message block executed.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            asyncExpectation.fulfill()
            
            // Assert ChatBot response (async) is added to life of messages
            XCTAssert(self.mockChatViewModel.messages[1].content == "SAMPLE CHATBOT COMPLETION RESPONSE")
            XCTAssert(self.mockChatViewModel.messageCount == 2)
        }
        waitForExpectations(timeout: 1)
    }
    
    // Test getGeneratedImage function in ChatViewModel
    func testSendDALLEMessage() {
        let sampleImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png"
        
        // Simulate user sending single message
        mockChatViewModel.sendMessage(content: "SAMPLE USER MESSAGE", type: .image)
        
        // Assert user message added to list of messages
        XCTAssert(mockChatViewModel.messages[0].content == "SAMPLE USER MESSAGE")
        XCTAssert(mockChatViewModel.messageCount == 1)
        
        let asyncExpectation = expectation(description: "Async send message block executed.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            asyncExpectation.fulfill()
            
            // Assert ChatBot response (async) is added to life of messages
            XCTAssert(self.mockChatViewModel.messages[1].content == sampleImageUrl)
            XCTAssert(self.mockChatViewModel.messageCount == 2)
        }
        waitForExpectations(timeout: 1)
    }
}
