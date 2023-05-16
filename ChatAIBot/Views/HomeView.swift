//
//  HomeView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/16/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ChatGPT3View()
                .tabItem {
                    Label("Chat Bot", systemImage: "ellipsis.message")
                }
            ChatDALLEView()
                .tabItem {
                    Label("Image Bot", systemImage: "theatermask.and.paintbrush")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
