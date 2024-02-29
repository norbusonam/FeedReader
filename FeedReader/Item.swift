//
//  Item.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/28/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
