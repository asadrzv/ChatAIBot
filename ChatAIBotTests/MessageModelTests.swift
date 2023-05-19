//
//  MessageModelTests.swift
//  ChatAIBotTests
//
//  Created by Asad Rizvi on 5/15/23.
//

import XCTest
@testable import ChatAIBot

final class MessageModelTests: XCTestCase {

    // Test initial message values
    func testInitialValues() {
        // Simulate creating new text message
        let textMessage = Message(id: "id1", content: Constants.sampleUserPrompt, type: .text, isUserMessage: true)
        
        // Assert correct text message field values
        XCTAssert(textMessage.content == "SAMPLE USER PROMPT")
        XCTAssert(textMessage.isUserMessage == true)
        
        // Simulate creating new image message
        let imageMessage = Message(id: "id2", content: Constants.sampleImageURL, type: .text, isUserMessage: true)
        
        // Assert correct image message field values
        XCTAssert(imageMessage.content == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")
        XCTAssert(imageMessage.isUserMessage == true)
    }
}
