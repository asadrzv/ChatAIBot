//
//  EmptyChatView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/18/23.
//

import SwiftUI

struct EmptyChatView: View {
    let systemImageName: String
    let placeholderText: String
    
    var body: some View {
        VStack {
            Image(systemName: systemImageName)
                .font(.largeTitle)
            Text(placeholderText)
                .font(.subheadline)
                .padding(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct EmptyChatView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyChatView(
            systemImageName: "theatermask.and.paintbrush",
            placeholderText: "Sample text"
        )
    }
}
