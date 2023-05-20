//
//  Message.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation

struct Message: Equatable, Identifiable {
    enum MessageType {
        case text
        case image
    }
    
    let id: Identifier<Message> = Identifier(stringLiteral: UUID().uuidString)
    var content: String
    var type: MessageType
    var isUserMessage: Bool
}
