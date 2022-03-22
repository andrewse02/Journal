//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Andrew Elliott on 3/21/22.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    var journal: Journal?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        guard let journal = journal else { return UITableViewCell() }
        
        cell.textLabel?.text = journal.entries[indexPath.row].title

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else { return }
            
            JournalController.shared.remove(entry: journal.entries[indexPath.row], from: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryDetailViewController,
                  let journal = journal else { return }
                    
            let entryToSend = journal.entries[indexPath.row]
            destination.journal = journal
            destination.entry = entryToSend
        } else if segue.identifier == "createNewEntry" {
            guard let destination = segue.destination as? EntryDetailViewController,
                  let journal = journal else { return }
            
            destination.journal = journal
        }
    }
}
