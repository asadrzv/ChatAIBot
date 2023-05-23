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
        NavigationStack {
            let openAISwiftURL = "https://github.com/adamrushy/OpenAISwift"
            let alertToastURL = "https://github.com/elai950/AlertToast"
            
            Form {
                Section {
                    Link("OpenAISwift",
                         destination: URL(string: openAISwiftURL)!
                    )
                    
                    Link("AlertToast",
                         destination: URL(string: alertToastURL)!
                    )
                }
            }
            .navigationTitle("Open Source Packages")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(shareURL: Constants.sampleImageURL)
    }
}
