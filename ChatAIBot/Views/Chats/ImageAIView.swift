//
//  ImageAIView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/16/23.
//

import SwiftUI
import AlertToast
import FirebaseAnalytics

struct ImageAIView: View {
    @StateObject private var chatViewModel = ChatViewModel(openAIService: OpenAIManager())
    
    @State private var isTextCopied = false
        
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    if !chatViewModel.messages.isEmpty {
                        // Chat message bubbles with auto scroll to latest message
                        MessagesView(
                            messages: chatViewModel.messages,
                            isTextCopied: $isTextCopied
                        )
                    } else {
                        // Empty chat view message/image
                        EmptyChatView(
                            systemImageName: "theatermask.and.paintbrush",
                            placeholderText: "Give me a prompt, I'll draw..."
                        )
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
                BottomToolBarView(
                    chatViewModel: chatViewModel,
                    messageType: .image
                )
            }
            .toolbar {
                // Clear chat button
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        // FIX CLEAR CHAT ANIMATION TO LOOK CLEANER THEN UNCOMMENT
                        //withAnimation {
                        chatViewModel.clearChat()
                        //}
                        // Haptic feedback for clearing chat
                        hapticImpactFeedback(style: .light)
                        
                        // Firebase Analytics: log user clearing chat in ImageAIView
                        Analytics.logEvent("clear_chat_button_pressed", parameters: [
                            AnalyticsParameterScreenName: "ImageAIView"
                        ])
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
            .navigationTitle("Image AI")
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
        // Firebase Analytics: log user visting ImageAIView
        .onAppear {
            Analytics.logEvent("imageai_screen_viewed", parameters: [
                AnalyticsParameterScreenName: "ImageAIView"
            ])
        }
    }
}

struct ImageAIView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAIView()
    }
}
