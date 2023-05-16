//
//  Message.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation

struct Message: Identifiable {
    enum MessageType {
        case text
        case image
    }
    
    let id = UUID()
    let content: String
    let type: MessageType
    let isUserMessage: Bool
}
