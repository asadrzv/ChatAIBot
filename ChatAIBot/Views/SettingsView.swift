//
//  SettingsView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/23/23.
//

import SwiftUI

struct SettingsView: View {
    let shareURL: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    // General form links
                    Section("General") {
                        ShareLink(item: shareURL) {
                            Text("Share")
                        }
                        Button("Rate Us") {
                            
                        }
                    }
                    // Legal form links
                    Section("Legal") {
                        Button("Terms of Service") {
                            
                        }
                        Button("Privacy Policy") {
                            
                        }
                    }
                    // Open Source Packages links
                    Section {
                        NavigationLink(destination: OpenSourcePackagesView) {
                            Text("Open Source Packages")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var OpenSourcePackagesView: some View {
        Form {
            Section {
                Text("https://github.com/adamrushy/OpenAISwift")
                
                Text("https://github.com/elai950/AlertToast")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(shareURL: Constants.sampleImageURL)
    }
}
