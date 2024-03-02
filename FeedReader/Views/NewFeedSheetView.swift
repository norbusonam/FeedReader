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
    
    @State private var feed = Feed(feedLink: "")
    
    @FocusState private var feedLinkFocused
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Link to Feed", text: $feed.feedLink)
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
                    .onChange(of: feed.feedLink) {
                        feed.resetFeedProperties()
                        feed.fetch()
                    }
            }
            .padding()
            .navigationTitle("New Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if feed.isFetching {
                    ProgressView()
                } else {
                    Button("Create", systemImage: "plus") {
                        modelContext.insert(feed)
                        dismiss()
                    }
                    .disabled(!feed.isValid)
                }
            }
        }
    }
}

#Preview {
    ContentView(page: .feeds)
        .modelContainer(for: Feed.self)
}
