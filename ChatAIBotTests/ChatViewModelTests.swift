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
    
    // Test initial state of ChatViewModel
    func testInitialValues() {
        // Assert no messages saved yet
        XCTAssert(mockChatViewModel.messages.count == 0)
    }
    
    // Test trimmedMessageText field in remove leading/trailing whitespace
    func testTrimmedMessageText() {
        // Simulate user inputting message with leading/trailing whitespace
        mockChatViewModel.messageText = "           " + Constants.sampleUserPrompt + "      "
        
        // Assert whitespace properly removed
        XCTAssert(mockChatViewModel.trimmedMessageText == Constants.sampleUserPrompt)
    }
    
    // Test clearChat function in ChatViewModel
    func testClearChat() {
        // Sample chat message list
        let testData = [
            Message(content: Constants.sampleUserPrompt, type: .text, isUserMessage: true),
            Message(content: Constants.sampleAIResponse, type: .text, isUserMessage: false),
            Message(content: Constants.sampleUserPrompt, type: .text, isUserMessage: true),
            Message(content: Constants.sampleImageURL, type: .image, isUserMessage: false)
        ]
        
        // Add test data to message list
        mockChatViewModel.messages.append(contentsOf: testData)
        
        // Simulate user tapping clear button
        mockChatViewModel.clearChat()
        
        // Assert all message data cleared and count reset
        XCTAssert(mockChatViewModel.messages.count == 0)
    }
}
