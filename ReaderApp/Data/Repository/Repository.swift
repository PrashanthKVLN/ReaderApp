//
//  Repository.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

// MARK: - Repository Implementation
final class Repository: RepositoryProtocol {
    
    // MARK: - Properties
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initializer
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Protocol Methods
    func fetch<T>(endpoint: String) async throws -> T where T : Decodable {
        return try await networkService.fetchData(from: endpoint)
    }
}
