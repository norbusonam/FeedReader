//
//  Feed.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/29/24.
//

import Foundation
import SwiftData

@Model
class RSSFeed {
    // feed state
    @Attribute(.unique) var url: URL
    
    // feed properties
    var title: String
    var link: URL
    var desc: String
    var items: [RSSItem]
    
    init(url: URL, title: String, link: URL, desc: String, items: [RSSItem] = []) {
        self.url = url
        self.title = title
        self.link = link
        self.desc = desc
        self.items = items
    }
}

@Model
class RSSItem {
    // feed properties
    var title: String
    var link: URL
    var desc: String
    
    init(title: String, link: URL, desc: String) {
        self.title = title
        self.link = link
        self.desc = desc
    }
}

class RSSParser: NSObject, XMLParserDelegate {
    private var rssFeed: RSSFeed? = nil
    private var rssItems: [RSSItem] = []
    private var isInItem: Bool = false
    private var currentFeedUrl: String = ""
    private var currentElementName: String = ""
    private var currentFeedTitle: String = ""
    private var currentFeedLink: String = ""
    private var currentFeedDesc: String = ""
    private var currentItemTitle: String = ""
    private var currentItemLink: String = ""
    private var currentItemDesc: String = ""
    private var parserError: Error? = nil
    
    private func resetParse() {
        rssFeed = nil
        rssItems = []
        parserError = nil
        isInItem = false
    }
    
    private func resetCurrentItem() {
        currentItemTitle = ""
        currentItemLink = ""
        currentItemDesc = ""
    }
    
    private func resetCurrentFeed() {
        currentFeedTitle = ""
        currentFeedLink = ""
        currentFeedDesc =  ""
    }
    
    func parseFeed(url: String,  completionHandler: ((RSSFeed?) -> Void)? ) {
        guard let feedUrl = URL(string: url) else {
            print("Error: feed url doesnt seem to be valid")
            return
        }
        currentFeedUrl = url
        let task = URLSession.shared.dataTask(with: feedUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completionHandler?(nil)
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            if parser.parse() {
                completionHandler?(self.rssFeed)
            } else {
                print("Error: Unable to parse feed")
                completionHandler?(nil)
            }
        }
        task.resume()
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isInItem {
            switch currentElementName {
            case "title": currentItemTitle += string
            case "link": currentItemLink += string
            case "description": currentItemDesc += string
            default: break
            }
        } else {
            switch currentElementName {
            case "title": currentFeedTitle += string
            case "link": currentFeedLink += string
            case "description": currentFeedDesc += string
            default: break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = elementName
        switch elementName {
        case "item": resetCurrentItem(); isInItem = true;
        case "channel": resetCurrentFeed()
        default: break;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "item":
            isInItem = false;
            guard let link = URL(string: currentItemLink),
                  !currentFeedTitle.isEmpty && !currentItemDesc.isEmpty else {
                print("Error: item doesnt seem to be valid")
                return
            }
            rssItems.append(RSSItem(title: currentItemTitle, link: link, desc: currentItemDesc))
        case "channel":
            guard let link = URL(string: currentFeedLink),
                  let url = URL(string: currentFeedUrl),
                  !currentFeedTitle.isEmpty && !currentFeedDesc.isEmpty else {
                print("Error: feed doesnt seem to be valid")
                return
            }
            rssFeed = RSSFeed(url: url, title: currentFeedTitle, link: link, desc: currentFeedDesc, items: rssItems)
        default: break
            
        }
    }
       
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        parserError = parseError
    }
}
