//
//  NewFeedSheetView.swift
//  FeedReader
//
//  Created by Norbu Sonam on 3/1/24.
//

import SwiftUI

struct NewFeedSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var rssFeed = RSSFeed(feedLink: "")
    
    var body: some View {
        TextField("Link to RSS Feed", text: $rssFeed.feedLink)
            .keyboardType(.URL)
        Button("add") {
            // TODO: validate feed
            modelContext.insert(rssFeed)
        }
     }
}

#Preview {
    ContentView(page: .feeds)
        .modelContainer(for: RSSFeed.self)
}
