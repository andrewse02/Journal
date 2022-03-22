//
//  JournalListViewController.swift
//  Journal
//
//  Created by Andrew Elliott on 3/22/22.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalListTableView.delegate = self
        journalListTableView.dataSource = self
        JournalController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalListTableView.reloadData()
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let titleText = journalTitleTextField.text,
              !titleText.isEmpty else { return }
        
        JournalController.shared.createJournal(title: titleText)
        journalListTableView.reloadData()
        journalTitleTextField.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        cell.textLabel?.text = JournalController.shared.journals[indexPath.row].title
        cell.detailTextLabel?.text = "Entries: \(JournalController.shared.journals[indexPath.row].entries.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            JournalController.shared.delete(journal: JournalController.shared.journals[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toEntryList",
              let indexPath = journalListTableView.indexPathForSelectedRow,
              let destination = segue.destination as? EntryListTableViewController else { return }
        
        let journalToSend = JournalController.shared.journals[indexPath.row]
        destination.journal = journalToSend
    }
}
