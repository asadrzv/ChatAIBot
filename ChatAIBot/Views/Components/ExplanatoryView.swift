//
//  ExplanatoryView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/21/23.
//

import SwiftUI

struct ExplanatoryView: View {
    
    var body: some View {
        // Introductory text explaining Chat AI App to user
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

struct ExplanatoryView_Previews: PreviewProvider {
    static var previews: some View {
        ExplanatoryView()
    }
}
