//
//  RssFeed.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/29/24.
//

import SwiftData

@Model
class RSSFeed {
    var feedLink: String;
    
    init(feedLink: String) {
        self.feedLink = feedLink
    }
}
