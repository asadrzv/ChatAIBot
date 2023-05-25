//
//  SettingsView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/23/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    @State private var isShowingTOSSheet = false
    @State private var isShowingPPSheet = false
    @State private var isShowingLicensesSheet = false
    
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
                            isShowingTOSSheet.toggle()
                        }
                        Button("Privacy Policy") {
                            isShowingPPSheet.toggle()
                        }
                        Button("Licenses") {
                            isShowingLicensesSheet.toggle()
                        }
                    }
                    .listRowBackground(Color.gray.opacity(0.1))

                    // License form links
                    Section {
                        // App version
                        Text("Chat AI v" + settingsViewModel.appVersion)
                            //.font(.footnote)
                        /*NavigationLink(destination: LicensesView) {
                            Text("Licenses")
                        }*/
                    }
                    .listRowBackground(Color.gray.opacity(0.1))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        // Display Terms of Service sheet on button press
        .sheet(isPresented: $isShowingTOSSheet) {
            TermsOfServiceView
                .presentationDetents([.medium, .large])
        }
        // Display Privacy Policy sheet on button press
        .sheet(isPresented: $isShowingPPSheet) {
            PrivacyPolicyView
                .presentationDetents([.medium, .large])
        }
        // Display Licenses sheet on button press
        .sheet(isPresented: $isShowingLicensesSheet) {
            LicensesView
                .presentationDetents([.medium, .large])
        }
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
        }
    }
    
    // Terms of Service view
    private var TermsOfServiceView: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Terms of Service")
                }
                .listRowBackground(Color.gray.opacity(0.1))
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Terms of Service")
        }
    }
    
    // Privacy Policy view
    private var PrivacyPolicyView: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Privacy Policy")
                }
                .listRowBackground(Color.gray.opacity(0.1))
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Privacy Policy")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
