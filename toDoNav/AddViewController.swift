//
//  AddViewController.swift
//  toDoNav
//
//  Created by Marlon Orellana on 4/28/21.
//

import RealmSwift
import UIKit

var todoItem: ToDoItem = ToDoItem()

class AddViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!
    
    // Dismiss modal view
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        try! realm.write {
            realm.add(todoItem)
        }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Todo Item"
        } else if (section == 1) {
            return "Schedule a Time"
        } else {
            return " "
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Every section will have only 1 row
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let fieldCell = tableView.dequeueReusableCell(withIdentifier: labelCell.identifier, for: indexPath) as! labelCell
        let dateCell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
        
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(didToggleSwitch(_:) ), for: .valueChanged)
        cell.accessoryView = mySwitch
        
        if (indexPath.section == 0) {
            todoItem.title = fieldCell.textLabel?.text
            return fieldCell
        } else if (indexPath.section == 1) {
            print(dateCell.datePicker.date)
            return dateCell
        } else {
            cell.textLabel?.text = "Important"
        }
        return cell
    }
    
    @objc func didToggleSwitch(_ sender: UISwitch) {
        if sender.isOn {
            todoItem.important = true
        } else {
            todoItem.important = false
        }
    }

}
