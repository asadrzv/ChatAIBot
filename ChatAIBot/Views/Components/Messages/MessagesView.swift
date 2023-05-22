//
//  MessagesView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/18/23.
//

import SwiftUI

struct MessagesView: View {
    let messages: [Message]
    
    @State var clipboard = UIPasteboard.general
    @Binding var isTextCopied: Bool // Toggle to show Toast alert on ChatAI/ImageAI views
    
    @Namespace private var bottomID // ID of bottom anchor Spacer of ScrollView for auto-scrolling
    
    var body: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(messages) { message in
                        MessageView(message: message)
                            // Double tap message to copy to clipboard
                            .onTapGesture(count: 2) {
                                clipboard.string = message.content
                                isTextCopied.toggle()
                                // Haptic impact feedback for copying message
                                hapticImpactFeedback(style: .medium)
                            }
                            // Animation to slide up from bottom of view upon creation
                            .transition(.move(edge: .bottom))
                    }
                    .padding(.horizontal)
                    
                    // Empty spacer at bottom of view to auto scroll to
                    Spacer()
                        .id(bottomID)
                }
                // Auto scroll to latest chat message when message count increases
                .onChange(of: messages.count) { _ in
                    withAnimation(.easeOut(duration: 0.5)) {
                        scrollViewProxy.scrollTo(bottomID, anchor: .bottom)
                    }
                }
            }
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(
            messages: Constants.introMessages,
            isTextCopied: .constant(false)
        )
    }
}
