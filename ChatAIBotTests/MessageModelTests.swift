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
        let message = Message(content: "SAMPLE USER MESSAGE", type: .text, isUserMessage: true)
        
        // Assert correct message field values
        XCTAssert(message.content == "SAMPLE USER MESSAGE")
        XCTAssert(message.isUserMessage == true)
    }
}
