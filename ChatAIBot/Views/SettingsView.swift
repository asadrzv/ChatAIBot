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
                            // OPEN LINK TO RATE APP ON APPSTORE
                        }
                    }
                    // Legal form links
                    Section("Legal") {
                        Button("Terms of Service") {
                            // DISPLAY TOS VIEW
                        }
                        Button("Privacy Policy") {
                            // DISPLAY PP VIEW
                        }
                    }
                    // License form links
                    Section {
                        NavigationLink(destination: LicensesView) {
                            Text("Licenses")
                        }
                    }
                }
                // App version
                Text("Chat AI v" + Bundle.main.getAppVersion())
                    .font(.footnote)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Licenses used in creation of app
    private var LicensesView: some View {
        NavigationStack {
            Form {
                Section {
                    Text(Bundle.main.load(file: "Licenses"))
                }
            }
            .navigationTitle("Licenses")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(shareURL: Constants.sampleImageURL)
    }
}
