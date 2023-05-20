//
//  MessagesView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/18/23.
//

import SwiftUI

struct MessagesView: View {
    @ObservedObject var chatViewModel: ChatViewModel
    
    @State var clipboard = UIPasteboard.general
    @Binding var isTextCopied: Bool // Toggle to show Toast alert on ChatAI/ImageAI views
    
    @Namespace private var bottomID // ID of bottom anchor Spacer of ScrollView for auto-scrolling
    
    var body: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(chatViewModel.messages) { message in
                        MessageView(message: message)
                            // Tap message to copy to clipboard
                            .onTapGesture {
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
                .onReceive(chatViewModel.$messageCount) { _ in
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
            chatViewModel: ChatViewModel(openAIService: MockOpenAIManager()),
            isTextCopied: .constant(false)
        )
    }
}
