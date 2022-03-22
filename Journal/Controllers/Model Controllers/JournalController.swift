//
//  JournalController.swift
//  Journal
//
//  Created by Andrew Elliott on 3/22/22.
//

import Foundation

class JournalController {
    static let shared = JournalController()
    
    var journals: [Journal] = []
    
    func createJournal(title: String) {
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        saveToPersistentStorage()
    }
    
    func delete(journal: Journal) {
        guard let index = self.journals.firstIndex(of: journal) else { return }
        
        self.journals.remove(at: index)
        saveToPersistentStorage()
    }
    
    func add(entry: Entry, to journal: Journal) {
        journal.entries.append(entry)
        saveToPersistentStorage()
    }
    
    func remove(entry: Entry, from journal: Journal) {
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        
        journal.entries.remove(at: index)
        saveToPersistentStorage()
    }
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        let je = JSONEncoder()
        
        do {
            let data = try je.encode(self.journals)
            try data.write(to: self.fileURL())
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: self.fileURL())
            let jd = JSONDecoder()
            
            let journals = try jd.decode([Journal].self, from: data)
            self.journals = journals
        } catch {
            print(error)
        }
    }
}
