//
//  NewsViewModel.swift
//  NewsAppReview
//
//  Created by Jungjin Park on 2024-06-23.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var newsItems: [NewsItem] = []
    @Published var searchQuery: String = ""
    @Published var errorMessage: String?
    private let newsService = NewsService()
    private var cancellables = Set<AnyCancellable>()
    
    private func searchNews() -> AnyPublisher<NewsResponse, Error> {
        $searchQuery
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .flatMap { query -> AnyPublisher<NewsResponse, Error> in
                return self.newsService.searchNews(query: query).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .share()
            .eraseToAnyPublisher()
    }
    
    init() {
        let result = searchNews()
        result
            .catch { _ in Empty() }
            .map(\.items)
            .assign(to: \.newsItems, on: self)
            .store(in: &cancellables)
        
        // for print error message
        result
            .map { _ in nil as String? }
            .catch { error -> AnyPublisher<String?, Never> in
                Just(error.localizedDescription).eraseToAnyPublisher()
            }
            .print("error")
            .assign(to: \.errorMessage, on: self)
            .store(in: &cancellables)
    }
}
