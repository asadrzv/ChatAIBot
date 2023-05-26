//
//  Bundle+Extensions.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/23/23.
//

import Foundation

extension Bundle {
    
    // Get app version number as String
    func getAppVersion() -> String {
        // Find release version number
        guard let releaseVersionNumber = self.object(forInfoDictionaryKey: "CFBundleShortVersionString") else {
            fatalError("ERROR: Could not get App release version number from Bundle!")
        }
        // Find build version number
        guard let buildVersionNumber = self.object(forInfoDictionaryKey: "CFBundleVersion") else {
            fatalError("ERROR: Could not get App build version number from Bundle!")
        }
        
        return "\(releaseVersionNumber)" + "." + "\(buildVersionNumber)"
    }
    
    // Get OpenAI API Key from Info.plist (Secrets.xcconfig)
    func getOpenAIAPIKey() -> String {
        guard let apiKey = Bundle.main.infoDictionary?["OpenAI API Key"] else {
            fatalError("ERROR: Could not get OpenAI API key from Bundle!")
        }
        
        return "\(apiKey)"
    }
    
    // Load String from static text file
    func load(file: String) -> String {
        // Find file, otherwise throw an error
        guard let path = self.path(forResource: file, ofType: "txt") else {
            fatalError("ERROR: Could not find \(file) from Bundle!")
        }
        // Load String from file
        guard let content = try? String(contentsOfFile: path) else {
            fatalError("ERROR: Could not load \(file) as String from Bundle!")
        }
        
        return content
    }
    
    // Decode data from static JSON file
    func decode<T: Decodable>(file: String) -> T {
        // Find file, otherwise throw an error
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("ERROR: Could not find \(file) in Bundle!")
        }
        // Load data, otherwise throw an error
        guard let data = try? Data(contentsOf: url) else {
            fatalError("ERROR: Could not load \(file) from Bundle!")
        }
        // Decode data, otherwise throw an error
        let decoder = JSONDecoder()
        guard let JSONData = try? decoder.decode(T.self, from: data) else {
            fatalError("ERROR: Could not decode \(file) from Bundle!")
        }
        
        return JSONData
    }
    
    // Fetch and decode JSON data from API
    func fetch<T: Decodable>(url: String, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                // Return any erros that occur
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            // Decode JSON data from server data
            do {
                let JSONData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(JSONData))
            } catch {
                // Return any errors that occur
                completion(.failure(error))
            }
        }.resume()
    }
}
