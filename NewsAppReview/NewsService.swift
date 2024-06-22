//
//  NewsService.swift
//  NewsAppReview
//
//  Created by Jungjin Park on 2024-06-23.
//

import Foundation
import Combine

class NewsService {
    private let baseURL = "https://openapi.naver.com/v1/search/news.json"
    private let clientID: String
    private let clientSecret: String
    
    init() {
        guard let clientID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String,
              let clientSecret = Bundle.main.object(forInfoDictionaryKey: "CLIENT_SECRET") as? String else {
            fatalError("CLIENT_ID or CLIENT_SECRET was not set in plist")
        }
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
    
    func searchNews(query: String) -> AnyPublisher<NewsResponse, Error> {
        guard var components = URLComponents(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        components.query = query
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
