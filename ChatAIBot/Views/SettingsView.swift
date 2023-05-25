//
//  SettingsView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/23/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    // General form links
                    Section("General") {
                        ShareLink(item: Constants.sampleImageURL) { //REPLACE LINK WITH APP STORE LINK
                            Text("Share")
                        }
                        Button("Rate Us") {
                            // OPEN LINK TO RATE APP ON APPSTORE
                        }
                    }
                    
                    .listRowBackground(Color.gray.opacity(0.1))
                    // Legal form links
                    Section("Legal") {
                        Button("Terms of Service") {
                            // DISPLAY TOS VIEW
                        }
                        Button("Privacy Policy") {
                            // DISPLAY PP VIEW
                        }
                    }
                    .listRowBackground(Color.gray.opacity(0.1))

                    // License form links
                    Section {
                        // App version
                        Text("Chat AI v" + settingsViewModel.appVersion)
                            //.font(.footnote)
                        NavigationLink(destination: LicensesView) {
                            Text("Licenses")
                        }
                    }
                    .listRowBackground(Color.gray.opacity(0.1))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        //.toolbar(.hidden, for: .tabBar)
    }
    
    // Licenses used in creation of app
    private var LicensesView: some View {
        NavigationStack {
            Form {
                Section {
                    Text(settingsViewModel.licensesText)
                }
                .listRowBackground(Color.gray.opacity(0.1))
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Licenses")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
