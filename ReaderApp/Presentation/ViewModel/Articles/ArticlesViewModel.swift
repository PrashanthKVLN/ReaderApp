//
//  ArticlesViewModel.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

// MARK: - ViewModel Implementation
final class ArticlesViewModel: ArticlesViewModelProtocol {
        
    var onFetchUpdated: ((News) -> Void)?
    var onFailed: ((String) -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    
    // MARK: - Properties
    private let fetchArticleUseCase: FetchArticlesUseCaseProtocol
    
    // MARK: - Initializer
    init(fetchArticleUseCase: FetchArticlesUseCaseProtocol = FetchArticlesUseCase()) {
        self.fetchArticleUseCase = fetchArticleUseCase
    }
    
    // MARK: - Protocol Methods
    func fetchArticles() {
        Task { [weak self] in
            guard let self = self else { return }
            await MainActor.run {
                self.onLoadingStateChanged?(true)
            }
            do {
                let news = try await fetchArticleUseCase.execute()
                await MainActor.run {
                    self.onLoadingStateChanged?(false)
                    self.onFetchUpdated?(news)
                    ArticleCacheManager.shared.saveArticles(news.articles)
                }
            } catch {
                await MainActor.run {
                    self.onLoadingStateChanged?(false)
                    self.onFailed?(error.localizedDescription)
                    print("⚠️ Network failed, loading cached data...")
                    let cached = ArticleCacheManager.shared.fetchCachedArticles()
                    if !cached.isEmpty {
                        let cachedResponse = News(
                            status: nil,
                            totalResults: nil,
                            articles: cached)
                        self.onFetchUpdated?(cachedResponse)
                    }else {
                        self.onFailed?("No internet and no cached data available.")
                    }
                }
            }
        }
    }
}
