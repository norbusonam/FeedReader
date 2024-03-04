//
//  NewFeedSheetView.swift
//  FeedReader
//
//  Created by Norbu Sonam on 3/1/24.
//

import SwiftUI

struct NewFeedSheetView: View {
    private let rssParser = RSSParser()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var url: String = ""
    @State private var rssFeed: RSSFeed? = nil
    @State private var isParsing = false
    
    @FocusState private var feedLinkFocused
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    TextField("Link to Feed", text: $url)
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
                        .onChange(of: url) {
                            rssFeed = nil
                            isParsing = true
                            rssParser.parseFeed(url: url) { rf in
                                rssFeed = rf
                                isParsing = false
                            }
                        }
                    if !url.isEmpty {
                        Button(action: {
                            url = ""
                        }) {
                            Image(systemName: "x.circle.fill")
                        }
                        .padding()
                    }
                }
            }
            .padding()
            .navigationTitle("New Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isParsing {
                    ProgressView()
                } else {
                    Button("Create", systemImage: "plus") {
                        if let rf = rssFeed {
                            modelContext.insert(rf)
                            dismiss()
                        }
                    }
                    .disabled(rssFeed == nil)
                }
            }
        }
    }
}

#Preview {
    ContentView(page: .feeds)
        .modelContainer(for: RSSFeed.self)
}
