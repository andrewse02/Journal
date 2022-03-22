//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Andrew Elliott on 3/21/22.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var journal: Journal?
    var entry: Entry?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let titleText = titleTextField.text,
              let bodyText = bodyTextView.text,
              !titleText.isEmpty,
              !bodyText.isEmpty,
              let journal = journal else { return }
        
        if entry != nil {
            guard let entry = entry else { return }
            EntryController.update(entry: entry, title: titleText, body: bodyText)
        } else {
            
            
            EntryController.addEntry(to: journal, title: titleText, body: bodyText)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        self.bodyTextView.text = ""
    }
    
    func updateViews() {
        guard let entry = self.entry else { return }
        
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
}
