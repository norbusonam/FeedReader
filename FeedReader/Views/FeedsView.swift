//
//  FeedsView.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/29/24.
//

import SwiftUI
import SwiftData

struct FeedsView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var showNewFeedSheet = false
    
    @Query private var rssFeeds: [RSSFeed]
    
    var body: some View {
        NavigationView {
            List(rssFeeds) { rssFeed in
                NavigationLink {
                    FeedView(rssItems: rssFeed.items)
                        .navigationTitle(rssFeed.title)
                } label: {
                    Text(rssFeed.title)
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(rssFeed)
                    }
                }
            }
            .animation(.default, value: rssFeeds.count)
            .navigationTitle("Feeds")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Feed", systemImage: "plus") {
                        showNewFeedSheet = true
                    }
                }
            }
            .sheet(isPresented: $showNewFeedSheet) {
                NewFeedSheetView()
                    .presentationDetents([.height(120)])
            }
        }
    }
}

#Preview {
    ContentView(page: Page.feeds)
        .modelContainer(for: RSSFeed.self)
}
