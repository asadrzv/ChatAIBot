//
//  ChatView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatViewModel = ChatViewModel()
    
    @FocusState private var isTextFieldFocused // Checks if user is typing to bring up keyboard
    @Namespace var bottomID // ID of bottom anchor Spacer of ScrollView for auto-scrolling
    
    var body: some View {
        NavigationStack {
            VStack {
                if !chatViewModel.messages.isEmpty {
                    // Chat messsage bubbles with auto scroll to latest messge
                    ScrollView {
                        ScrollViewReader { scrollViewProxy in
                            VStack {
                                ForEach(chatViewModel.messages) { message in
                                    MessageView(message: message)
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
                } else {
                    // Empty chat view message/image
                    VStack {
                        Image(systemName: "ellipses.bubble")
                            .font(.largeTitle)
                        Text("Ask me anything...")
                            .font(.subheadline)
                            .padding(10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                // Botoom tool bar view to type/send new message
                BottomToolBarView
            }
            .padding(.top, 1)
            .navigationTitle("Chat Bot")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Custom Views
    
    private var BottomToolBarView: some View {
        VStack {
            HStack {
                // Text field to get user message to send
                TextField("Message", text: $chatViewModel.messageText)
                    .focused($isTextFieldFocused)
                    .lineLimit(4)
                    .padding(.horizontal)
                    .frame(height: 40)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
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
