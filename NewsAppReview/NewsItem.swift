//
//  NewsItem.swift
//  NewsAppReview
//
//  Created by Jungjin Park on 2024-06-23.
//

import Foundation

struct NewsItem: Codable, Identifiable {
    let id = UUID()
    // from Naver API response
    let title: String
    let originallink: String
    let link: String
    let description: String
    let pubDate: String
    
    enum CodingKeys: String, CodingKey {
        case title, originallink, link, description, pubDate
    }
}

struct NewsResponse: Codable {
    let items: [NewsItem]
}
