//
//  NewsDetailView.swift
//  NewsAppReview
//
//  Created by Jungjin Park on 2024-06-23.
//

import SwiftUI

struct NewsDetailView: View {
    let item: NewsItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.description)
                .font(.subheadline)
            Text(item.pubDate)
                .font(.caption)
                .foregroundStyle(.secondary)
            if let url = URL(string: item.link), UIApplication.shared.canOpenURL(url) {
                Link(destination: url) {
                    HStack {
                        Image(systemName: "link")
                        Text("News Link")
                    }
                }
                .font(.caption)
            }
            Spacer()
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}
