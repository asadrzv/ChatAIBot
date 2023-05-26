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
            ChatAIView()
                .tabItem {
                    Label("Chat AI", systemImage: "ellipsis.message")
                }
            ImageAIView()
                .tabItem {
                    Label("Image AI", systemImage: "theatermask.and.paintbrush")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
