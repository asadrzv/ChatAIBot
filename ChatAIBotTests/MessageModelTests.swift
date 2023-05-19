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
        let sampleImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png"

        // Simulate creating new text message
        let textMessage = Message(id: "id1", content: "SAMPLE USER MESSAGE", type: .text, isUserMessage: true)
        // Assert correct text message field values
        XCTAssert(textMessage.content == "SAMPLE USER MESSAGE")
        XCTAssert(textMessage.isUserMessage == true)
        
        // Simulate creating new image message
        let imageMessage = Message(id: "id2", content: sampleImageURL, type: .text, isUserMessage: true)
        // Assert correct image message field values
        XCTAssert(imageMessage.content == sampleImageURL)
        XCTAssert(imageMessage.isUserMessage == true)
    }
}
