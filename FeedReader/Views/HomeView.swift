//
//  HomeView.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/29/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query var rssItems: [RSSItem]
    
    var body: some View {
        NavigationView {
            FeedView(rssItems: rssItems)
                .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: RSSFeed.self)
}
