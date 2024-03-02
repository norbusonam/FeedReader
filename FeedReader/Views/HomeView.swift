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
            List { }
                .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: RSSFeed.self)
}
