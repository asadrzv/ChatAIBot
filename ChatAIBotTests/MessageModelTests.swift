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
        let sampleImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png"

        // Simulate creating new text message
        let textMessage = Message(content: "SAMPLE USER MESSAGE", type: .text, isUserMessage: true)
        // Assert correct text message field values
        XCTAssert(textMessage.content == "SAMPLE USER MESSAGE")
        XCTAssert(textMessage.isUserMessage == true)
        
        // Simulate creating new image message
        let imageMessage = Message(content: sampleImageUrl, type: .text, isUserMessage: true)
        // Assert correct image message field values
        XCTAssert(imageMessage.content == sampleImageUrl)
        XCTAssert(imageMessage.isUserMessage == true)
    }
}
