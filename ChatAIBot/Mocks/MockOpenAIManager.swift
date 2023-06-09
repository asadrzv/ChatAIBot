//
//  MockOpenAIManager.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/15/23.
//

import Foundation

final class MockOpenAIManager: OpenAIService {
    
    // Completion returns test data for testing ChatViewModel sendMessage function
    func sendCompletion(with prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let testData = Constants.sampleAIResponse
        completion(.success(testData))
    }
    
    // Completion returns test url for testing
    func sendImages(with prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let testData = Constants.sampleImageURL
        completion(.success(testData))
    }
}
