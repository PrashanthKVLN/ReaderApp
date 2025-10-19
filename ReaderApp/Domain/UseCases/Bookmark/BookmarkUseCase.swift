//
//  BookmarkUseCase.swift
//  ReaderApp
//
//  Created by Prashanth on 20/10/25.
//

import Foundation

final class BookmarkUseCase: BookmarkUseCaseProtocol {
    
    private let repository: BookmarkRepositoryProtocol
    
    init(repository: BookmarkRepositoryProtocol = BookmarkRepository.shared) {
        self.repository = repository
    }
    
    func saveArticle(_ article: Article) {
        repository.save(article)
    }
    
    func removeArticle(_ article: Article) {
        repository.remove(article)
    }
    
    func fetchBookmarkedArticles() -> Articles {
        return repository.fetchAll()
    }
    
    func isBookmarked(_ article: Article) -> Bool {
        return repository.isBookmarked(article)
    }
}
