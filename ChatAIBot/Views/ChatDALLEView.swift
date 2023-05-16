//
//  ChatDALLEView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/16/23.
//

import SwiftUI

struct ChatDALLEView: View {
    @ObservedObject var chatViewModel = ChatViewModel(openAIService: OpenAIManager())
    
    @FocusState private var isTextFieldFocused // Checks if user is typing to bring up keyboard
    @Namespace var bottomID // ID of bottom anchor Spacer of ScrollView for auto-scrolling
    
    var body: some View {
        NavigationStack {
            VStack {
                if !chatViewModel.messages.isEmpty {
                    // Chat messsage bubbles with auto scroll to latest messge
                    MessagesView
                } else {
                    // Empty chat view message/image
                    PlaceholderView
                }
                // Botoom tool bar view to type/send new message
                BottomToolBarView
            }
            .toolbar {
                // Clear chat button
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: chatViewModel.clearChat) {
                        Text("Clear")
                    }
                }
            }
            .padding(.top, 1)
            .navigationTitle("DALL-E")
            .navigationBarTitleDisplayMode(.inline)
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
            Image(systemName: "theatermask.and.paintbrush")
                .font(.largeTitle)
            Text("Give me a prompt, I'll draw...")
                .font(.subheadline)
                .padding(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // Botoom tool bar view to type/send new message
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
                Button(action: chatViewModel.sendDALLEMessage) {
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

struct ChatDALLEView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDALLEView()
    }
}
