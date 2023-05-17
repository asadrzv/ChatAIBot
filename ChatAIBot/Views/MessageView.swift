//
//  MessageView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    private let width: CGFloat = 500
    
    var body: some View {
        HStack {
            ZStack {
                VStack {
                    switch message.type {
                    // Message text content
                    case .text:
                        Text(message.content)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            // Set message bubble color to blue (received) or gray (sent)
                            .background(message.isUserMessage ? .red.opacity(0.7) : .gray.opacity(0.3))
                            // Set message text to white (received) or black (sent)
                            .foregroundColor(message.isUserMessage ? .white : .black)
                    // Message image content
                    case .image:
                        ImageView(imageUrl: message.content, dimensions: 300)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                    }
                }
                .cornerRadius(10)
            }
            .frame(width: width * 0.7, alignment: message.isUserMessage ? .trailing : .leading)
            .padding(.vertical, 5)
        }
        // Align message to left (received) or right (sent)
        .frame(maxWidth: .infinity, alignment: message.isUserMessage ? .trailing : .leading)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Constants.sampleTextMessage)
        
        MessageView(message: Constants.sampleImageMessage)
    }
}
