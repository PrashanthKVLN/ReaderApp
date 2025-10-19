//
//  BookmarkViewModelProtocol.swift
//  ReaderApp
//
//  Created by Prashanth on 20/10/25.
//

import Foundation

protocol BookmarkViewModelProtocol {
    
    var bookmarkedArticles: Articles { get }
    var onBookmarksUpdated: ((Articles) -> Void)? { get set }
    
    func loadBookmarks()
    func toggleBookmark(for article: Article)
    func isBookmarked(_ article: Article) -> Bool
}
