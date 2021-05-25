//
//  AddViewController.swift
//  toDoNav
//
//  Created by Marlon Orellana on 4/28/21.
//

import RealmSwift
import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var isDismissed: (() -> Void)?
    let realm = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!
    
    // Dismiss modal view
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        let todoItem: ToDoItem = ToDoItem()
        todoItem.title = labelCellManager.shared.labelText
        todoItem.date = datePickerManager.shared.vc.datePicker.date
        print(todoItem.title!, todoItem.date!)
        try! self.realm.write {
            self.realm.add(todoItem)
        }
        ReloadManager.shared.HomeVC.refresh()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(labelCell.nib(), forCellReuseIdentifier: labelCell.identifier)
        tableView.register(DateTableViewCell.nib(), forCellReuseIdentifier: DateTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "To-do Item Title"
        } else {
            return "Schedule a Day/Time"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Every section will have only 1 row
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let fieldCell = tableView.dequeueReusableCell(withIdentifier: labelCell.identifier, for: indexPath) as! labelCell
        let dateCell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
        
        
        if (indexPath.section == 0) {
            return fieldCell
        } else  {
            print(dateCell.datePicker.date)
            return dateCell
        }
    }
}
