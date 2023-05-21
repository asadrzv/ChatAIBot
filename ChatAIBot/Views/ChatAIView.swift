//
//  ChatAIView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import SwiftUI
import AlertToast

struct ChatAIView: View {
    @StateObject private var chatViewModel = ChatViewModel(openAIService: OpenAIManager())
    
    @State private var isTextCopied = false
    @State private var isFirstLaunch = true
        
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    if !chatViewModel.messages.isEmpty {
                        // Chat messsage bubbles with auto scroll to latest message
                        MessagesView(
                            chatViewModel: chatViewModel,
                            isTextCopied: $isTextCopied
                        )
                    } else {
                        if isFirstLaunch {
                            // Intro view shown on first launch
                            IntroView
                        } else {
                            // Empty chat view message/image
                            EmptyChatView(
                                systemImageName: "ellipsis.message",
                                placeholderText: "Ask me anything..."
                            )
                        }
                    }
                }
                // When dismissed, the new view stays on top
                .zIndex(1)
                .onTapGesture {
                    // Dismiss keyboard when user taps outside textfield
                    dismissKeyboard()
                }
                // FIX CLEAR CHAT ANIMATION TO LOOK CLEANER THEN UNCOMMENT
                // Animation to slide down from top of view upon clearing chat
                //.transition(.move(edge: .bottom))
                
                // Botoom tool bar view to type/send new message
                BottomToolBarView(chatViewModel: chatViewModel)
            }
            .toolbar {
                // Clear chat button
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        // FIX CLEAR CHAT ANIMATION TO LOOK CLEANER THEN UNCOMMENT
                        //withAnimation {
                        chatViewModel.clearChat()
                        isFirstLaunch = false
                        //}
                        // Haptic feedback for clearing chat
                        hapticImpactFeedback(style: .light)
                    }) {
                        Text("Clear")
                            .foregroundColor(.black)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 5)
                            .background(.thickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
            .padding(.top, 1)
            .navigationTitle("Chat AI")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toast(isPresenting: $isTextCopied) {
            // Alert indicates if message is copied to clipboard
            AlertToast(
                displayMode: .hud,
                type: .regular,
                title: "Message Copied"
            )
        }
    }
    
    // MARK: - Custom Views
    
    // Introductory text explaining Chat AI to user
    private var IntroView: some View {
        ScrollView {
            ForEach(Constants.introMessages[0...1]) { message in
                MessageView(message: message)
            }
            .padding(.horizontal)
            
            VStack {
                Image(systemName: "ellipsis.message")
                    .font(.largeTitle)
                    .padding(.top, 10)
                Text("Ask me anything...")
                    .font(.subheadline)
                    .padding(10)
            }
            
            ForEach(Constants.introMessages[2...4]) { message in
                MessageView(message: message)
            }
            .padding(.horizontal)
        }
    }
}

struct ChatAIView_Previews: PreviewProvider {
    static var previews: some View {
        ChatAIView()
    }
}
