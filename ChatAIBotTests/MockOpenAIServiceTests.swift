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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSendMessage() throws {
        mockChatViewModel.messageText = "SAMPLE USER MESSAGE"
        mockChatViewModel.sendMessage()
        
        // Make sure user message added to list of messages
        XCTAssert(mockChatViewModel.messages[0].text == "SAMPLE USER MESSAGE")
        
        // Make sure ChatBot response (async) is added to life of messages
        let asyncExpectation = expectation(description: "Async send message block executed.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            asyncExpectation.fulfill()
            XCTAssert(self.mockChatViewModel.messages[1].text == "SAMPLE CHATBOT COMPLETION RESPONSE")
        }
        waitForExpectations(timeout: 1)
    }
}
