//
//  LicensesView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/26/23.
//

import SwiftUI
import FirebaseAnalytics

struct LicensesView: View {
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(Bundle.main.load(file: "Licenses"))
                }
                .listRowBackground(Color.gray.opacity(0.1))
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Licenses")
        }
        // Firebase Analytics: log user visting LicensesView
        .onAppear {
            Analytics.logEvent("licenses_screen_viewed", parameters: [
                AnalyticsParameterScreenName: "LicensesView"
            ])
        }
    }
}

struct LicensesView_Previews: PreviewProvider {
    static var previews: some View {
        LicensesView()
    }
}
