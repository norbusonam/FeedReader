//
//  Feeds.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/29/24.
//

import SwiftUI

struct Feeds: View {
    var body: some View {
        NavigationSplitView {
            List { }
                .navigationTitle("Feeds")
        } detail: {
        }
    }
}

#Preview {
    ContentView(page: Page.feeds)
}
