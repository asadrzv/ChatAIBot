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
        // Determines if the message is received or sent by user
        let isReceived = message.type == .Received

        HStack {
            ZStack {
                // Message text content
                Text(message.text)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    // Set message bubble color to gray (received) or blue (sent)
                    .background(isReceived ? .gray.opacity(0.3) : .blue.opacity(0.9))
                    // Set message text to gray (received) or blue (sent)
                    .foregroundColor(isReceived ? .black : .white)
                    .cornerRadius(10)
            }
            .frame(width: 400 * 0.7, alignment: isReceived ? .leading : .trailing)
            .padding(.vertical)
        }
        // Align message to left (received) or right (sent)
        .frame(maxWidth: .infinity, alignment: isReceived ? .leading : .trailing)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Constants.sampleMessage)
    }
}
