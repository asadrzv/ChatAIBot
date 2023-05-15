//
//  Message.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUserMessage: Bool
}
