//
//  MessageView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import SwiftUI
import ActivityIndicatorView

struct MessageView: View {
    let message: Message
        
    var body: some View {
        HStack {
            ZStack {
                VStack {
                    switch message.type {
                    // Message text content
                    case .text:
                        Text(message.content)
                            .padding(15)
                            // Set message bubble color to blue (received) or gray (sent)
                            .background(message.isUserMessage ? .red.opacity(0.7) : .gray.opacity(0.2))
                            // Set message text to white (received) or black (sent)
                            .foregroundColor(message.isUserMessage ? .white : .black)
                    // Message image content
                    case .image:
                        ImageView(imageURL: message.content, dimensions: 300)
                            .padding(15)
                            .background(.gray.opacity(0.2))
                    // Message activity indicator
                    case .indicator:
                        ActivityIndicatorView(isVisible: .constant(true), type: .opacityDots(count: 3, inset: 4))
                            .frame(width: 35, height: 35)
                            .padding(15)
                            .background(.gray.opacity(0.2))
                    }
                }
                .roundedCorner(10, corners: message.isUserMessage ? [.bottomLeft, .topLeft, .topRight] : [.bottomRight, .topLeft, .topRight])
            }
            .padding(.vertical, 5)
        }
        .padding(message.isUserMessage ? .leading : .trailing, 5)
        // Align message to left (received) or right (sent)
        .frame(maxWidth: .infinity, alignment: message.isUserMessage ? .trailing : .leading)
    }
}

// RoundedCorner shape allows creation of view with specified rounded corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        // Text Message
        MessageView(message: Constants.sampleTextMessage)
        // Image Message
        MessageView(message: Constants.sampleImageMessage)
    }
}
