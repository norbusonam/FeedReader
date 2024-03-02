//
//  FeedReaderApp.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/28/24.
//

import SwiftUI
import SwiftData

@main
struct FeedReaderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Feed.self)
    }
}
