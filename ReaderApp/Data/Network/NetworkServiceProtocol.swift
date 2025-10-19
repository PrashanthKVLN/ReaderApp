//
//  NetworkServiceProtocol.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

// MARK: - Protocol
protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from url: String) async throws -> T
}
