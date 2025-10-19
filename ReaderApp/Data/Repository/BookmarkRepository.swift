//
//  BookmarkRepository.swift
//  ReaderApp
//
//  Created by Prashanth on 20/10/25.
//

import Foundation

final class BookmarkRepository: BookmarkRepositoryProtocol {
    
    static var shared: BookmarkRepositoryProtocol = BookmarkRepository()
    
    // MARK: - Constants
    private let userDefaultsKey = "bookmarked_articles"
    
    // MARK: - Save
    func save(_ article: Article) {
        var existing = fetchAll()
        
        if let url = article.url,
           !existing.contains(where: { $0.url == url }) {
            existing.append(article)
            saveToUserDefaults(existing)
        }
    }
    
    // MARK: - Remove
    func remove(_ article: Article) {
        guard let url = article.url else { return }
        var existing = fetchAll()
        existing.removeAll { $0.url == url }
        saveToUserDefaults(existing)
    }
    
    // MARK: - Fetch
    func fetchAll() -> Articles {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let decoded = try? JSONDecoder().decode(Articles.self, from: data) else {
            return []
        }
        return decoded
    }
    
    // MARK: - Check Bookmark
    func isBookmarked(_ article: Article) -> Bool {
        guard let url = article.url else { return false }
        return fetchAll().contains(where: { $0.url == url })
    }
}

private extension BookmarkRepository {
    func saveToUserDefaults(_ articles: Articles) {
        if let data = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
}
