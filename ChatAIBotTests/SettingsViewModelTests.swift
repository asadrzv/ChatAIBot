//
//  SettingsViewModelTests.swift
//  ChatAIBotTests
//
//  Created by Asad Rizvi on 5/23/23.
//

import XCTest
@testable import ChatAIBot

final class SettingsViewModelTests: XCTestCase {

    let settingsViewModel = SettingsViewModel()
    
    // Test initial state of SettingsViewModel
    func testInitialValues() {
        let appVersion = Bundle.main.getAppVersion()
        XCTAssert(settingsViewModel.appVersion == appVersion)
        
        let licensesText = Bundle.main.load(file: "Licenses")
        XCTAssert(settingsViewModel.licensesText == licensesText)
    }
}
