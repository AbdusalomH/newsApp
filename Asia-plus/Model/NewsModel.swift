//
//  NewsModel.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 12/16/21.
//

import Foundation


// MARK: - Welcome
struct NewsModel: Codable, Hashable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Hashable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case articleDescription
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

// MARK: - Source
struct Source: Codable, Hashable {
    let id: String?
    let name: String
}






