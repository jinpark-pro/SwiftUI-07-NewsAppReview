//
//  ContentView.swift
//  NewsAppReview
//
//  Created by Jungjin Park on 2024-06-23.
//

import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.newsItems) { item in
                NavigationLink(destination: NewsDetailView(item: item)) {
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.pubDate)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("News Search")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchQuery, prompt: "Search news")
            .overlay(
                Group {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .padding()
                    }
                }
            )
        }
    }
}

#Preview {
    NewsListView()
}
