//
//  BookmarkRepositoryProtocol.swift
//  ReaderApp
//
//  Created by Prashanth on 20/10/25.
//

import Foundation

protocol BookmarkRepositoryProtocol {
    func save(_ article: Article)
    func remove(_ article: Article)
    func fetchAll() -> Articles
    func isBookmarked(_ article: Article) -> Bool
}
