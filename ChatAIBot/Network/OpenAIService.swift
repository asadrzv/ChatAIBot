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
    func sendCompletion(with prompt: String, completion: @escaping (Result<String, Error>) -> Void)
    
    // Generate image url based on input prompt
    func sendImages(with prompt: String, completion: @escaping (Result<String, Error>) -> Void)
}
