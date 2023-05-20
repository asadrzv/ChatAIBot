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
    
    // Returns view with haptic feedback for when user performs an impact action (i.e. touch buttons)
    // FeedbackSytle
    // .light -> Light interaction (i.e. tapping button or scrolling to end of list)
    // .medium -> Medium interaction (i.e. pulling down refresh control or sliding switch)
    // .heavy -> Heavy interaction (i.e. force pressing button)
    func hapticImpactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let feedback = UIImpactFeedbackGenerator(style: style)
        feedback.impactOccurred()
    }
    
    // Returns view with haptic feedback for when user receives a notification or alert
    // FeedbackType
    // .success -> Success notification (i.e. successfully submitted form)
    // .warning -> Warning notification (i.e. unpermitted action or internet error)
    // .error -> Error notification (i.e. invalid input or app problem)
    func hapticNotificationFeedback(type: UINotificationFeedbackGenerator.FeedbackType) {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(type)
    }
}
