//
//  FeedView.swift
//  FeedReader
//
//  Created by Norbu Sonam on 3/2/24.
//

import SwiftUI

struct FeedView: View {
    let feedItems: [String]
    
    var body: some View {
        List(feedItems, id: \.self) { feedItem in
            NavigationLink {
                Text(feedItem)
            } label: {
                
                Text(feedItem)
            }
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Feed.self)
}
