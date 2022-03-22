//
//  Entry.swift
//  Journal
//
//  Created by Andrew Elliott on 3/21/22.
//

import Foundation

class Entry: Codable {
    var title: String
    var body: String
    let timestamp: Date
    
    init(title: String, body: String, timestamp: Date = Date.now) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

extension Entry: Equatable {
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        guard lhs.title == rhs.title,
              lhs.body == rhs.body,
              lhs.timestamp == rhs.timestamp else { return false }
        return true
    }
}
