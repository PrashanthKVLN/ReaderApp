//
//  FetchArticlesUseCase.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

// MARK: - UseCase Implementation
final class FetchArticlesUseCase: FetchArticlesUseCaseProtocol {
    
    // MARK: - Properties
    private let repository: RepositoryProtocol
    
    // MARK: - Initializer
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
    }
    
    // MARK: - Protocol Methods
    func execute() async throws -> News {
        let endpoint = "?country=us"
        
        guard let urlString = AppConfig.shared.fullURL(for: endpoint) else {
            throw NetworkServiceError.invalidURL(url: endpoint)
        }
        return try await repository.fetch(endpoint: urlString)
    }
}
