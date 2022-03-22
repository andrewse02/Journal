//
//  Journal.swift
//  Journal
//
//  Created by Andrew Elliott on 3/22/22.
//

import Foundation

class Journal: Codable {
    let title: String
    var entries: [Entry]
    
    init(title: String, entries: [Entry] = []) {
        self.title = title
        self.entries = entries
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        guard lhs.title == rhs.title,
              lhs.entries == rhs.entries else { return false }
        return true
    }
}
