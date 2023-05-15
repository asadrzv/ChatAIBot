//
//  MockOpenAIManager.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/15/23.
//

import Foundation

class MockOpenAIManager: OpenAIService {
    
    // Return test data for testing ChatViewModel sendMessage function
    func sendCompletion(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        let testData = "SAMPLE CHATBOT COMPLETION RESPONSE"
        completion(.success(testData))
    }
}
