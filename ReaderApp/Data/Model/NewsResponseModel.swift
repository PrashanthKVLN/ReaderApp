//
//  NewsResponseModel.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import Foundation

// MARK: - News
struct NewsResponseModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: Articles
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    var isBookmarked: Bool? = false
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

typealias News = NewsResponseModel
typealias Articles = [Article]
