//
//  MockOpenAIServiceTests.swift
//  ChatAIBotTests
//
//  Created by Asad Rizvi on 5/15/23.
//

import XCTest
@testable import ChatAIBot

final class MockOpenAIServiceTests: XCTestCase {
    // Use protocal-driven development and dependency injection to allow testing
    let mockChatViewModel = ChatViewModel(openAIService: MockOpenAIManager())
    
    // Test ChatViewModel initial state
    func testInitialValues() {
        // Assert no messages saved yet
        XCTAssert(mockChatViewModel.messages.count == 0)
        XCTAssert(mockChatViewModel.messageCount == 0)
        XCTAssert(mockChatViewModel.messageText == "")
    }
    
    // Test sendMessage function in ChatViewModel
    func testSendMessage() {
        // Simulate user sending single message
        mockChatViewModel.messageText = "SAMPLE USER MESSAGE"
        mockChatViewModel.sendMessage()
        
        // Assert user message added to list of messages
        XCTAssert(mockChatViewModel.messages[0].text == "SAMPLE USER MESSAGE")
        XCTAssert(mockChatViewModel.messageCount == 1)
        
        let asyncExpectation = expectation(description: "Async send message block executed.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            asyncExpectation.fulfill()
            
            // Assert ChatBot response (async) is added to life of messages
            XCTAssert(self.mockChatViewModel.messages[1].text == "SAMPLE CHATBOT COMPLETION RESPONSE")
            XCTAssert(self.mockChatViewModel.messageCount == 2)
        }
        waitForExpectations(timeout: 1)
    }
}
