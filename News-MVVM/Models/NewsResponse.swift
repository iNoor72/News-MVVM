//
//  NewsResponse.swift
//  News-MVVM
//
//  Created by Noor El-Din Walid on 21/04/2024.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let author, title, description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}
