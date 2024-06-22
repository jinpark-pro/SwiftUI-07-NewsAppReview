//
//  ContentView.swift
//  NewsAppReview
//
//  Created by Jungjin Park on 2024-06-23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.newsItems) { item in
                Text(item.title)
                    .font(.headline)
                Text(item.pubDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("News (total: \(viewModel.newsItems.count))")
            .searchable(text: $viewModel.searchQuery, prompt: "Search news")
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
