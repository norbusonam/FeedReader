//
//  Feed.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/29/24.
//

import Foundation
import SwiftData
import FeedKit

@Model
class Feed {
    // feed state
    @Attribute(.unique) var feedLink: String = ""
    var isFetching: Bool = false
    var lastSuccessfullyFetchedAt: Date? = nil
    var isValid: Bool {
        !feedLink.isEmpty &&
        !title.isEmpty &&
        !image.isEmpty
    }
    
    // feed properties
    var title: String = ""
    var image: String = ""
    
    init(feedLink: String) {
        self.feedLink = feedLink
    }
    
    public func fetch() {
        isFetching = true
        guard let feedLinkUrl = URL(string: feedLink)
        else {
            isFetching = false
            return
        }
        let parser = FeedParser(URL: feedLinkUrl)
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            switch result {
            case .success(let feed):
                switch feed {
                case let .atom(feed):
                    self.title = feed.title ?? ""
                    self.image = feed.icon ?? ""
                case let .rss(feed):
                    self.title = feed.title ?? ""
                    self.image = feed.image?.url ?? ""
                case let .json(feed):
                    self.title = feed.title ?? ""
                    self.image = feed.icon ?? ""
                }
                if self.isValid {
                    self.lastSuccessfullyFetchedAt = Date.now
                }
            case .failure(_):
                break
            }
            self.isFetching = false
        }
    }
    
    public func resetFeedProperties() {
        title = ""
    }
}
