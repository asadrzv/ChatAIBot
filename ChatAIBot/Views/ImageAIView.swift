//
//  ImageAIView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/16/23.
//

import SwiftUI
import AlertToast

struct ImageAIView: View {
    @StateObject private var chatViewModel = ChatViewModel(openAIService: OpenAIManager())
    
    @FocusState private var isTextFieldFocused
    @State private var isTextCopied = false
        
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    if !chatViewModel.messages.isEmpty {
                        // Chat message bubbles with auto scroll to latest message
                        MessagesView(
                            chatViewModel: chatViewModel,
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
                .onTapGesture {
                    // Dismiss keyboard when user taps outside textfield
                    dismissKeyboard()
                }
                // FIX CLEAR CHAT ANIMATION TO LOOK CLEANER THEN UNCOMMENT
                // Animation to slide down from top of view upon clearing chat
                //.transition(.move(edge: .bottom))
                
                // Botoom tool bar view to type/send new message
                BottomToolBarView
            }
            .toolbar {
                // Clear chat button
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        // FIX CLEAR CHAT ANIMATION TO LOOK CLEANER THEN UNCOMMENT
                        //withAnimation {
                        chatViewModel.clearChat()
                        //}
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
    }
    
    // MARK: - Custom Views
    
    // Botoom tool bar view to type/send new message
    private var BottomToolBarView: some View {
        VStack {
            HStack {
                // Text field to get user message to send
                TextField("Message", text: $chatViewModel.messageText, axis: .vertical)
                    .focused($isTextFieldFocused)
                    .lineLimit(3)
                    .padding(15)
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                // Send messsage button
                Button(action: {
                    // FIX CLEAR CHAT ANIMATION TO LOOK CLEANER THEN UNCOMMENT
                    //withAnimation {
                        chatViewModel.sendDALLEMessage()
                    //}
                    isTextFieldFocused.toggle()
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Circle()
                            // Set send message button to gray (nothing to send) or red (text to send)
                            .foregroundColor(chatViewModel.formattedMessageText.isEmpty ? .gray : .red.opacity(0.9))
                        )
                }
                .disabled(chatViewModel.formattedMessageText.isEmpty)
            }
        }
        .padding()
    }
}

struct ImageAIView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAIView()
    }
}
