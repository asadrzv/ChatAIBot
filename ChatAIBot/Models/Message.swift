//
//  Message.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation

struct Message: Identifiable {
    enum MessageType {
        case Received
        case Sent
    }
    
    let id = UUID()
    let text: String
    let type: MessageType
}
