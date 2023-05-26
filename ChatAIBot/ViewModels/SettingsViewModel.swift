//
//  SettingsViewModel.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/23/23.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var appVersion = ""
    @Published var licensesText = ""
    
    init() {
        appVersion = Bundle.main.getAppVersion()
        licensesText = Bundle.main.load(file: "Licenses")
    }
}
