//
//  MockNetworkService.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

final class MockNetworkService: NetworkServiceProtocol {
    
    var result: Result<Data, NetworkServiceError>?
    
    func fetchData<T>(from url: String) async throws -> T where T : Decodable {
        
        guard let result = result else {
            throw NetworkServiceError.error(message: "Mock result not set")
        }
        
        switch result {
        case .success(let data):
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                throw NetworkServiceError.decodeFailed(message: error.localizedDescription)
            }
        case .failure(let error):
            throw NetworkServiceError.error(message: error.localizedDescription)
        }
    }
}
