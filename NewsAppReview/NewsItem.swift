//
//  NewsItem.swift
//  NewsAppReview
//
//  Created by Jungjin Park on 2024-06-23.
//

import Foundation

struct NewsItem: Codable {
    // from Naver API response
    var title: String
    var originallink: String
    var link: String
    var description: String
    var pubDate: String
}

struct NewsResponse: Codable {
    var items: [NewsItem]
}
