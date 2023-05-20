//
//  View+Extensions.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/19/23.
//

import SwiftUI

extension View {
    
    // Dismiss keyboard when user taps outside
    func dismissKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
    
    // Return view with rounded corners
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
