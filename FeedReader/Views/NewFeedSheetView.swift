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
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Link to RSS Feed", text: $rssFeed.feedLink)
                    .keyboardType(.URL)
                    .focused($feedLinkFocused)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.primary)
                            .opacity(0.1)
                    }
                    .onAppear {
                        feedLinkFocused = true
                    }
            }
            .padding()
            .navigationTitle("New Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Create", systemImage: "plus") {
                    modelContext.insert(rssFeed)
                    dismiss()
                }
                .disabled(rssFeed.feedLink.isEmpty)
            }
        }
    }
}

#Preview {
    ContentView(page: .feeds)
        .modelContainer(for: RssFeed.self)
}
