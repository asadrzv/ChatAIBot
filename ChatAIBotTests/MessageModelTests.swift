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
        let message = Message(text: "SAMPLE USER MESSAGE", isUserMessage: true)
        
        // Assert correct message field values
        XCTAssert(message.text == "SAMPLE USER MESSAGE")
        XCTAssert(message.isUserMessage == true)
    }
}
