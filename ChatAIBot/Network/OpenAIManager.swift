//
//  OpenAIManager.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation
import OpenAISwift

final class OpenAIManager: OpenAIService {
    private var openAI: OpenAISwift

    init() {
        // Retreive OpenAI API Key from Info.plist (Secrets.xcconfig) and setup OpenAI client
        let apiKey = Bundle.main.infoDictionary?["OpenAI API Key"] as? String ?? ""
        openAI = OpenAISwift(authToken: apiKey)
    }

    // Predict completion text for user message using OpenAI's GPT-3
    // Return resulting generated response or an error
    func sendCompletion(with prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        openAI.sendCompletion(
            with: prompt,
            model: .gpt3(.curie),
            maxTokens: 200,
            temperature: 0.4
        ) { result in
            
            switch result {
            case .success(let model):
                let response = model.choices?.first?.text ?? ""
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Generate image url based on input prompt using OpenAI's DALL-E
    // Return resulting generated image URL or an error
    func sendImages(with prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        openAI.sendImages(
            with: prompt,
            numImages: 1,
            size: .size1024
        ) { result in
            
            switch result {
            case .success(let model):
                let imageUrl = model.data?.first?.url ?? ""
                completion(.success(imageUrl))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
