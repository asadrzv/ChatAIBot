//
//  OpenAIManager.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/10/23.
//

import Foundation
import OpenAISwift

class OpenAIManager {
    private var openAI: OpenAISwift

    init() {
        // Retreive OpenAI API Key from Info.plist (Secrets.xcconfig) and setup OpenAI client
        let apiKey = Bundle.main.infoDictionary?["OpenAI API Key"] as? String ?? ""
        openAI = OpenAISwift(authToken: apiKey)
    }

    // Send completion text to OpenAI client and retrieve AI generated output
    func sendCompletion(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        openAI.sendCompletion(
            with: text,
            model: .gpt3(.davinci),
            maxTokens: 500,
            temperature: 0.4
        ) { result in
            
            switch result {
            case .success(let model):
                let output = model.choices?.first?.text ?? ""
                completion(.success(output))
            case .failure(let model):
                print(model.localizedDescription)
                completion(.failure(model))
            }
        }
    }
}
