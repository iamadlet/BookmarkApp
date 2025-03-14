//
//  Bookmark_AppApp.swift
//  Bookmark App
//
//  Created by Адлет Жумагалиев on 13.03.2025.
//

import SwiftUI

struct Bookmark: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var link: String
}

class StorageManager {
    static let shared = StorageManager()
    
    private let key = "bookmarks"
    
    func save(_ bookmarks: [Bookmark]) {
        if let encoded = try? JSONEncoder().encode(bookmarks) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func load() -> [Bookmark] {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Bookmark].self, from: savedData) {
            return decoded
        }
        
        return []
    }
}

@main
struct Bookmark_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
