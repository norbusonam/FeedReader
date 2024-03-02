//
//  NewFeedSheetView.swift
//  FeedReader
//
//  Created by Norbu Sonam on 3/1/24.
//

import SwiftUI

struct NewFeedSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var rssFeed = RssFeed(feedLink: "")
    
    @FocusState private var feedLinkFocused
    
    var body: some View {
        TextField("Link to RSS Feed", text: $rssFeed.feedLink)
            .keyboardType(.URL)
            .focused($feedLinkFocused)
            .onAppear {
                feedLinkFocused = true
            }
        Button("add") {
            // TODO: validate feed
            modelContext.insert(rssFeed)
            dismiss()
        }
     }
}

#Preview {
    ContentView(page: .feeds)
        .modelContainer(for: RssFeed.self)
}
