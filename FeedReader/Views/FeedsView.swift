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
    
    @Query private var feeds: [Feed]
    
    var body: some View {
        NavigationView {
            List(feeds) { feed in
                NavigationLink {
                    FeedView(feedItems: ["Story 1", "Story 2", "Story 3"])
                        .navigationTitle(feed.title)
                } label: {
                    Text(feed.title)
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(feed)
                    }
                }
            }
            .animation(.default, value: feeds.count)
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
        .modelContainer(for: Feed.self)
}
