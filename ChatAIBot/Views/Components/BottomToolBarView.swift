//
//  BottomToolBarView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/21/23.
//

import SwiftUI

struct BottomToolBarView: View {
    @ObservedObject var chatViewModel: ChatViewModel
    
    let messageType: MessageType
    
    @FocusState private var isTextFieldFocused

    var body: some View {
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
                    // Animation for message to slide up from bottom of view upon creation
                    withAnimation {
                        chatViewModel.sendMessage(forType: messageType)
                    }
                    isTextFieldFocused.toggle()
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Circle()
                            // Set send message button to gray (nothing to send) or red (text to send)
                            .foregroundColor(chatViewModel.trimmedMessageText.isEmpty ? .gray : .red.opacity(0.9))
                        )
                }
                .disabled(chatViewModel.trimmedMessageText.isEmpty)
            }
        }
        .padding()
    }
}

struct BottomToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolBarView(
            chatViewModel: ChatViewModel(openAIService: OpenAIManager()),
            messageType: .text
        )
    }
}
