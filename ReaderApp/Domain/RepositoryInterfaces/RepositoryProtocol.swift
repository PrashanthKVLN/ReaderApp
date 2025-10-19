//
//  RepositoryProtocol.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

// MARK: - Protocol
protocol RepositoryProtocol {
    func fetch<T: Decodable>(endpoint: String) async throws -> T
}
