//
//  OpenAIServiceTests.swift
//  ChatAIBotTests
//
//  Created by Asad Rizvi on 5/21/23.
//

import XCTest
@testable import ChatAIBot

final class OpenAIServiceTests: XCTestCase {
    // Use protocal-driven development and dependency injection to allow testing
    let mockChatViewModel = ChatViewModel(openAIService: MockOpenAIManager())
    
    // Test getCompletion function in ChatViewModel
    func testSendGPT3Message() {
        // Simulate user sending single message
        mockChatViewModel.sendMessage(withContent: Constants.sampleUserPrompt, forType: .text)
        
        // Assert user message added to list of messages
        XCTAssert(mockChatViewModel.messages[0].content == "SAMPLE USER PROMPT")
        
        // Assert activity indicator message added to list of messages
        XCTAssert(mockChatViewModel.messages[1].type == .indicator)
        
        let asyncExpectation = expectation(description: "Async send message block executed.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            asyncExpectation.fulfill()
            
            // Assert ChatBot response (async) is added to life of messages and
            // Assert activity indicator message removed from list of messages
            XCTAssert(self.mockChatViewModel.messages[1].content == "SAMPLE AI RESPONSE")
        }
        waitForExpectations(timeout: 1)
    }
    
    // Test getGeneratedImage function in ChatViewModel
    func testSendDALLEMessage() {
        // Simulate user sending single message
        mockChatViewModel.sendMessage(withContent: Constants.sampleUserPrompt, forType: .image)
        
        // Assert user message added to list of messages
        XCTAssert(mockChatViewModel.messages[0].content == "SAMPLE USER PROMPT")
        
        // Assert activity indicator message added to list of messages
        XCTAssert(mockChatViewModel.messages[1].type == .indicator)
        
        let asyncExpectation = expectation(description: "Async send message block executed.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            asyncExpectation.fulfill()
            
            // Assert ChatBot response (async) is added to life of messages and
            // Assert activity indicator message removed from list of messages
            XCTAssert(self.mockChatViewModel.messages[1].content == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")
        }
        waitForExpectations(timeout: 1)
    }
}
