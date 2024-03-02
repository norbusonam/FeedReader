//
//  ContentView.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/28/24.
//

import SwiftUI

enum Page {
    case home, feeds
}

struct ContentView: View {
    @State var page: Page = .home
    
    var body: some View {
        TabView(selection: $page) {
            HomeView()
                .tag(Page.home)
                .tabItem {
                    Image(systemName: "house")
                }
            FeedsView()
                .tag(Page.feeds)
                .tabItem {
                    Image(systemName: "list.bullet")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Feed.self)
}
