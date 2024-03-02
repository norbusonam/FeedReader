//
//  HomeView.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/29/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            FeedView(feedItems: ["Story 1", "Story 2", "Story 3"])
                .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Feed.self)
}
