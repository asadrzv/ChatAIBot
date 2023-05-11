//
//  ChatView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatViewModel = ChatViewModel()
    
    @FocusState private var isFocused
    
    static let scrollToBottomPlaceholder = "" // Share scroll string with all messages
    
    var body: some View {
        NavigationStack {
            VStack {
                // Chat messsage bubbles with auto scroll to latest messge
                ScrollView {
                    ScrollViewReader { scrollViewProxy in
                        VStack {
                            ForEach(chatViewModel.messages) { message in
                                MessageView(message: message)
                            }
                            .padding(.horizontal)
                            
                            // Empty spacer at bottom of view to auto scroll to
                            HStack {
                                Spacer()
                            }
                            .id(Self.scrollToBottomPlaceholder)
                        }
                        // Auto scroll to latest chat message when message count increases
                        .onReceive(chatViewModel.$messageCount) { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                scrollViewProxy.scrollTo(Self.scrollToBottomPlaceholder, anchor: .bottom)
                            }
                        }
                    }
                }
                // Botoom tool bar view to type/send new message
                ToolBarView
            }
            .padding(.top, 1)
            .navigationTitle("ChatBot")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Custom Views
    
    private var ToolBarView: some View {
        VStack {
            HStack {
                // Text field to get user message to send
                TextField("Message", text: $chatViewModel.messageText)
                    .padding(.horizontal)
                    .frame(height: 40)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .focused($isFocused)
                
                // Send messsage button
                Button(action: chatViewModel.sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Circle()
                            // Set send message button to gray (nothing to send) or blue (text to send)
                            .foregroundColor(chatViewModel.messageText.isEmpty ? .gray : .blue)
                        )
                }
                .disabled(chatViewModel.messageText.isEmpty)
            }
            .frame(height: 40)
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.thickMaterial)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
