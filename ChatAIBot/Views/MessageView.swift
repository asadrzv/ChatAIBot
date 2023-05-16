//
//  MessageView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    var body: some View {
        HStack {
            ZStack {
                // Message text content
                Text(message.text)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    // Set message bubble color to blue (received) or gray (sent)
                    .background(message.isUserMessage ? .blue.opacity(0.9) : .gray.opacity(0.3))
                    // Set message text to white (received) or black (sent)
                    .foregroundColor(message.isUserMessage ? .white : .black)
                    .cornerRadius(10)
            }
            .frame(width: 500 * 0.7, alignment: message.isUserMessage ? .trailing : .leading)
            .padding(.vertical, 15)
        }
        // Align message to left (received) or right (sent)
        .frame(maxWidth: .infinity, alignment: message.isUserMessage ? .trailing : .leading)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Constants.sampleMessage)
    }
}
