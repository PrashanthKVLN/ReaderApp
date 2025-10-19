//
//  NetworkService.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

// MARK: - Network Error
enum NetworkServiceError: LocalizedError {
    case invalidURL(url: String)
    case invalidResponse(code: Int)
    case serverErrorResponse(data: [String: Any])
    case error(message: String)
    case decodeFailed(message: String)
    
    var errorDescription: String? {
        switch self {
        case let .invalidURL(url):
            return "Invalid URL: \(url)"
        case let .invalidResponse(code):
            return "Invalid response code: \(code)"
        case let .serverErrorResponse(data):
            return "Server Error: \(data)"
        case let .error(message):
            return "Error: \(message)"
        case let .decodeFailed(message):
            return "Decode Failed: \(message)"
        }
    }
}

// MARK: - Network Service
final class NetworkService: NetworkServiceProtocol {
    
    func fetchData<T: Decodable>(from url: String) async throws -> T {
        guard let requestURL = URL(string: url) else {
            throw NetworkServiceError.invalidURL(url: url)
        }
        
        print("🌐 Network Request URL: \(requestURL)")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: requestURL)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkServiceError.invalidResponse(code: -1)
            }
            
            // MARK: Handle Non-200 Responses
            if !(200...299).contains(httpResponse.statusCode) {
                throw handleHTTPError(data: data)
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                print("🟢 Successfully decoded response for: \(url) is \(decoded)")
                return decoded
            } catch {
                throw handleDecodingError(error)
            }
            
        } catch {
            throw NetworkServiceError.error(message: error.localizedDescription)
        }
    }
}

// MARK: - Private Helpers
private extension NetworkService {
    
    func handleHTTPError(data: Data) -> NetworkServiceError {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return .serverErrorResponse(data: json)
        }
        let message = String(data: data, encoding: .utf8) ?? "Unknown server error"
        return .error(message: message)
    }
    
    func handleDecodingError(_ error: Error) -> NetworkServiceError {
        if let decodingError = error as? DecodingError {
            switch decodingError {
            case let .typeMismatch(type, context):
                return .decodeFailed(message: "❌ Type mismatch for key '\(context.codingPath.map(\.stringValue).joined(separator: "."))' (expected \(type))")
            case let .valueNotFound(type, context):
                return .decodeFailed(message: "❌ Value not found for key '\(context.codingPath.map(\.stringValue).joined(separator: "."))' (type \(type))")
            case let .keyNotFound(key, context):
                return .decodeFailed(message: "❌ Missing key: \(key.stringValue) – \(context.debugDescription)")
            case let .dataCorrupted(context):
                return .decodeFailed(message: "❌ Data corrupted: \(context.debugDescription)")
            @unknown default:
                return .decodeFailed(message: "Unknown decoding error")
            }
        }
        return .decodeFailed(message: error.localizedDescription)
    }
}
