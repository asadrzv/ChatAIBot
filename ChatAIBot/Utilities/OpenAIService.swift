//
//  OpenAIService.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/15/23.
//

import Foundation

// Interface for implementing OpenAI functions from OpenAISwift Library
// Use protocal-driven development and dependency injection to allow testing
protocol OpenAIService {
    
    // Predict completion text for input text
    func sendCompletion(text: String, completion: @escaping (Result<String, Error>) -> Void)
}
