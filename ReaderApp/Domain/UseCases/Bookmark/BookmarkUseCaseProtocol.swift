//
//  BookmarkUseCaseProtocol.swift
//  ReaderApp
//
//  Created by Prashanth on 20/10/25.
//

import Foundation

protocol BookmarkUseCaseProtocol {
    func saveArticle(_ article: Article)
    func removeArticle(_ article: Article)
    func fetchBookmarkedArticles() -> Articles
    func isBookmarked(_ article: Article) -> Bool
}
