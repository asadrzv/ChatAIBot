//
//  ChatGPT3View.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import SwiftUI
import AlertToast

struct ChatGPT3View: View {
    @ObservedObject var chatViewModel = ChatViewModel(openAIService: OpenAIManager())
    
    @FocusState private var isTextFieldFocused
    @State private var isTextCopied = false
    @State private var isFirstLaunch = true
    
    @Namespace var bottomID // ID of bottom anchor Spacer of ScrollView for auto-scrolling
    
    var body: some View {
        NavigationStack {
            VStack {
                if !chatViewModel.messages.isEmpty {
                    // Chat messsage bubbles with auto scroll to latest message
                    MessagesView
                } else {
                    if isFirstLaunch {
                        // Intro view shown on first launch
                        IntroView
                    } else {
                        // Empty chat view message/image
                        PlaceholderView
                    }
                }
                // Botoom tool bar view to type/send new message
                BottomToolBarView
            }
            .toolbar {
                // Clear chat button
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        chatViewModel.clearChat()
                        isFirstLaunch = false
                    }) {
                        Text("Clear")
                            .foregroundColor(.black)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
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
    
    // Chat messsage bubbles with auto scroll to latest messge
    private var MessagesView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(chatViewModel.messages) { message in
                        MessageView(message: message)
                            // Double tap message to copy to clipboard
                            .onTapGesture(count: 2) {
                                let clipboard = UIPasteboard.general
                                clipboard.string = message.content
                                isTextCopied.toggle()
                            }
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
    
    // Empty chat placeholder message/image
    private var PlaceholderView: some View {
        VStack {
            Image(systemName: "ellipsis.message")
                .font(.largeTitle)
            Text("Ask me anything...")
                .font(.subheadline)
                .padding(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
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
    
    // Botoom tool bar view to type/send new message
    private var BottomToolBarView: some View {
        VStack {
            HStack {
                // Text field to get user message to send
                TextField("Message", text: $chatViewModel.messageText, axis: .vertical)
                    .focused($isTextFieldFocused)
                    .lineLimit(3)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                // Send messsage button
                Button(action: {
                    chatViewModel.sendGPT3Message()
                    isTextFieldFocused.toggle()
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Circle()
                            // Set send message button to gray (nothing to send) or red (text to send)
                            .foregroundColor(chatViewModel.formattedMessageText.isEmpty ? .gray : .red.opacity(0.9))
                        )
                }
                .disabled(chatViewModel.formattedMessageText.isEmpty)
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPT3View()
    }
}
