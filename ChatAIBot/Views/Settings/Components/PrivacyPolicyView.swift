//
//  PrivacyPolicyView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/26/23.
//

import SwiftUI
import FirebaseAnalytics

struct PrivacyPolicyView: View {
    
    var body: some View {
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
        // Firebase Analytics: log user visting PrivacyPolicyView
        .onAppear {
            Analytics.logEvent("privacy_policy_screen_viewed", parameters: [
                AnalyticsParameterScreenName: "PrivacyPolicyView"
            ])
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
