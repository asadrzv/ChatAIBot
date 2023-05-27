//
//  TermsOfServiceView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/26/23.
//

import SwiftUI
import FirebaseAnalytics

struct TermsOfServiceView: View {
    
    var body: some View {
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
        // Firebase Analytics: log user visting TermsOfServiceView
        .onAppear {
            Analytics.logEvent("terms_of_service_screen_viewed", parameters: [
                AnalyticsParameterScreenName: "TermsOfServiceView"
            ])
        }
    }
}

struct TermsOfServiceView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView()
    }
}
