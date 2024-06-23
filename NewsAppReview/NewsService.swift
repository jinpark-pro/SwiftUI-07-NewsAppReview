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
        
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            // Error handling
            .mapError { error -> Error in
                return APIError.transportError(error)
            }
            .tryMap { (data, response) -> (data: Data, response: URLResponse) in
                print("Received response from server, now checking status code")
                
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                
                if (200..<300) ~= urlResponse.statusCode { }
                else {
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(APIErrorMessage.self, from: data)
                    
                    if urlResponse.statusCode == 400 {
                        throw APIError.validationError(apiError.reason)
                    }
                }
                return (data, response)
            }
            // data parsing
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
