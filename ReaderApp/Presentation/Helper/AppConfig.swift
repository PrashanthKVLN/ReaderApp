//
//  AppConfig.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

final class AppConfig {
    
    // MARK: - Singleton
    static let shared = AppConfig()
    private init() {}
    
    // MARK: - Public Computed Properties
    var apiBaseURL: String? {
        return config?["API_BASE_URL"] as? String
    }
    
    var apiKey: String? {
        return config?["API_KEY"] as? String
    }
    
    // MARK: - Helpers
    func fullURL(for endpoint: String) -> String? {
        guard let baseURL = apiBaseURL,
              let key = apiKey else {
            return nil
        }
        return "\(baseURL)\(endpoint)&apiKey=\(key)"
    }
}

// MARK: - Private Extension
private extension AppConfig {
    var config: [String: Any]? {
        guard let url = Bundle.main.url(forResource: "Target", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            return nil
        }
        return plist
    }
}
