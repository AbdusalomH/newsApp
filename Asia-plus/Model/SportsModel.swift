//
//  SportsModel.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/8/22.
//

import Foundation


struct SportsData: Codable {
    let status: String
    let totalResults: Int
    let results: [Results]
    let nextPage: Int
}

// MARK: - Result
struct Results: Codable {
    let title: String
    let content: String?
    let imageUrl: String?
}
