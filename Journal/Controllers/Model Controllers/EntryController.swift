//
//  EntryController.swift
//  Journal
//
//  Created by Andrew Elliott on 3/21/22.
//

import Foundation

class EntryController {
    
    static func addEntry(to journal: Journal, title: String, body: String) {
        let newEntry = Entry(title: title, body: body)
        JournalController.shared.add(entry: newEntry, to: journal)
        JournalController.shared.saveToPersistentStorage()
    }
    
    static func update(entry: Entry, title: String, body: String) {
        entry.title = title
        entry.body = body
        
        JournalController.shared.saveToPersistentStorage()
    }
    
    static func delete(entry: Entry, from journal: Journal) {
        JournalController.shared.remove(entry: entry, from: journal)
        
        JournalController.shared.saveToPersistentStorage()
    }
}
