//
//  ArticleCacheManager.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation
import CoreData

// MARK: - Cache Manager
final class ArticleCacheManager {
    
    static let shared = ArticleCacheManager(repository: BookmarkRepository.shared)
    
    private let repository: BookmarkRepositoryProtocol
    
    private init(repository: BookmarkRepositoryProtocol) {
        self.repository = repository
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ReaderApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("❌ Core Data store failed: \(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Save Articles
    func saveArticles(_ articles: Articles) {
        deleteAllArticles()
        
        let bookmarkedArticles = repository.fetchAll()
        
        for article in articles {
            let cached = CachedArticle(context: context)
            cached.title = article.title
            cached.author = article.author
            cached.url = article.url
            cached.urlToImage = article.urlToImage
            cached.isBookmarked = bookmarkedArticles.contains(where: { $0.url == article.url })
        }
        
        do {
            try context.save()
            print("Cached \(articles.count) articles.")
        } catch {
            print("❌ Failed to save cache: \(error)")
        }
    }
    
    // MARK: - Fetch Cached Articles
    func fetchCachedArticles() -> Articles {
        let fetchRequest: NSFetchRequest<CachedArticle> = CachedArticle.fetchRequest()
        do {
            let cachedArticles = try context.fetch(fetchRequest)
            
            let articles: Articles = cachedArticles.map {
                Article(
                    source: nil,
                    author: $0.author ?? "",
                    title: $0.title ?? "",
                    description: nil,
                    url: $0.url,
                    urlToImage:  $0.urlToImage ?? "",
                    publishedAt: nil,
                    content: nil,
                    isBookmarked: $0.isBookmarked
                )
            }
            return articles
        } catch {
            print("❌ Failed to fetch cached articles: \(error)")
            return []
        }
    }
}

private extension ArticleCacheManager {
    func deleteAllArticles() {
        let fetchRequest: NSFetchRequest<CachedArticle> = CachedArticle.fetchRequest()
        if let existingArticles = try? context.fetch(fetchRequest) {
            for article in existingArticles {
                context.delete(article)
            }
        }
    }
}
