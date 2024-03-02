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
    
    var body: some View {
        TextField("Link to RSS Feed", text: $rssFeed.feedLink)
            .keyboardType(.URL)
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
