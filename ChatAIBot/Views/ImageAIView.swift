//
//  ImageAIView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/16/23.
//

import SwiftUI

struct ImageAIView: View {
    @ObservedObject private var chatViewModel = ChatViewModel(openAIService: OpenAIManager())
    
    @FocusState private var isTextFieldFocused
    
    @Namespace private var bottomID // ID of bottom anchor Spacer of ScrollView for auto-scrolling
    
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
                TextField("Message", text: $chatViewModel.messageText, axis: .vertical)
                    .focused($isTextFieldFocused)
                    .lineLimit(3)
                    .padding(15)
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                // Send messsage button
                Button(action: {
                    chatViewModel.sendDALLEMessage()
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

struct ChatDALLEView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAIView()
    }
}
