//
//  SettingsView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/23/23.
//

import SwiftUI
import FirebaseAnalytics

struct SettingsView: View {
    //@StateObject private var settingsViewModel = SettingsViewModel()
    
    @State private var isShowingTOSSheet = false
    @State private var isShowingPPSheet = false
    @State private var isShowingLicensesSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    // General form links
                    Section {
                        // Share app button
                        ShareLink(item: Constants.sampleImageURL) { //REPLACE LINK WITH APP STORE LINK
                            Text("Share")
                                // FIX: DOESN"T WORK WITH SHARELINK
                                /*.onTapGesture {
                                    // Firebase Analytics: log user sharing app to others
                                    Analytics.logEvent("share_button_pressed", parameters: [
                                        AnalyticsParameterScreenName: "SettingsView"
                                    ])
                                }*/
                        }
                        // Rate app on AppStore button
                        Button("Rate Us") {
                            // OPEN LINK TO RATE APP ON APPSTORE
                        }
                    } header: {
                        Text("General")
                    } footer: {
                        Text("We would greatly appreciate any feedback you have that could help us improve your experience!")
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
                    
                    // App version
                    Section {
                        //Spacer()
                    } footer: {
                        Text("Chat AI v" + Bundle.main.getAppVersion())
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        // Display Terms of Service sheet on button press
        .sheet(isPresented: $isShowingTOSSheet) {
            TermsOfServiceView()
                .presentationDetents([.medium, .large])
        }
        // Display Privacy Policy sheet on button press
        .sheet(isPresented: $isShowingPPSheet) {
            PrivacyPolicyView()
                .presentationDetents([.medium, .large])
        }
        // Display Licenses sheet on button press
        .sheet(isPresented: $isShowingLicensesSheet) {
            LicensesView()
                .presentationDetents([.medium, .large])
        }
        // Firebase Analytics: log user visting SettingsView
        .onAppear {
            Analytics.logEvent("settings_screen_viewed", parameters: [
                AnalyticsParameterScreenName: "SettingsView"
            ])
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
