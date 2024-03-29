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
                VStack(alignment: .leading) {
                    Text(rssItem.title)
                        .font(.headline)
                        .lineLimit(1)
                    Text(rssItem.desc)
                        .font(.subheadline)
                        .lineLimit(2)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: RSSFeed.self)
}
