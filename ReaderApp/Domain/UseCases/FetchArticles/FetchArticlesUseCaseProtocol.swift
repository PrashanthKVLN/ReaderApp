//
//  FetchArticlesUseCaseProtocol.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

// MARK: - Protocol
protocol FetchArticlesUseCaseProtocol {
    func execute() async throws -> News
}
