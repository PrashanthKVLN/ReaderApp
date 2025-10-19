//
//  ArticlesViewModelProtocol.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

// MARK: - Protocol
protocol ArticlesViewModelProtocol: LoadableViewModel {
    var onFetchUpdated: ((News) -> Void)? { get set }
    var onFailed: ((String) -> Void)? { get set }
    
    func fetchArticles()
}

