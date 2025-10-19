//
//  BookmarkViewModel.swift
//  ReaderApp
//
//  Created by Prashanth on 20/10/25.
//

import Foundation

final class BookmarkViewModel: BookmarkViewModelProtocol {
    
    private let useCase: BookmarkUseCaseProtocol
    
    init(useCase: BookmarkUseCaseProtocol = BookmarkUseCase()) {
        self.useCase = useCase
    }
    
    var bookmarkedArticles: Articles = []
    var onBookmarksUpdated: ((Articles) -> Void)?
    
    func loadBookmarks() {
        bookmarkedArticles = useCase.fetchBookmarkedArticles()
        onBookmarksUpdated?(bookmarkedArticles)
    }
    
    func toggleBookmark(for article: Article) {
        if useCase.isBookmarked(article) {
            useCase.removeArticle(article)
        } else {
            useCase.saveArticle(article)
        }
        loadBookmarks()
    }
    
    func isBookmarked(_ article: Article) -> Bool {
        return useCase.isBookmarked(article)
    }
}
