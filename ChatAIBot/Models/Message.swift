//
//  Message.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation

enum MessageType {
    case text
    case image
    case indicator
}

struct Message: Equatable, Identifiable {
    let id: Identifier<Message> = Identifier(stringLiteral: UUID().uuidString)
    var content: String
    var type: MessageType
    var isUserMessage: Bool
}
