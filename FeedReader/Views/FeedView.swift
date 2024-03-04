//
//  FeedView.swift
//  FeedReader
//
//  Created by Norbu Sonam on 3/2/24.
//

import SwiftUI

struct FeedView: View {
    let rssItems: [RSSItem]
    
    var body: some View {
        List(rssItems, id: \.self) { rssItem in
            NavigationLink {
                Text(rssItem.title)
            } label: {
                Text(rssItem.title)
            }
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: RSSFeed.self)
}
