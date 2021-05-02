//
//  HomeViewController.swift
//  toDoNav
//
//  Created by Marlon Orellana on 4/27/21.
//

import RealmSwift
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private let realm = try! Realm()
    
    private var data = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(ToDoItem.self).map({ $0 })
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        data = realm.objects(ToDoItem.self).map({ $0 })
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if (data[indexPath.row].important == true) {
            cell.textLabel?.text = "‼️ " + data[indexPath.row].title!
        } else {
            cell.textLabel?.text = data[indexPath.row].title!
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = data[indexPath.row]
        
        // Action sheet
        let actionsheet = UIAlertController(title: item.title, message: "Edit this item", preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Mark as Important", style: .default, handler: {action in
                    let result = self.realm.objects(ToDoItem.self).filter("title = '\(item.title!)'").first
            try! self.realm.write {
                        result!.important = true
                    }
            tableView.reloadData()
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
            return
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
            self.deleteToDoItem(item: item)
        }))
        
        present(actionsheet, animated: true, completion: nil)
    }
    
    /// Deletes a ToDoItem object in the realm database.
    ///
    /// - Parameters:
    ///     - item: ToDoItem to be deleted
    func deleteToDoItem(item: ToDoItem) {
        try! realm.write {
            realm.delete(item)
        }
        data = realm.objects(ToDoItem.self).map({ $0 })
        tableView.reloadData()
    }

    func refresh() {
        data = realm.objects(ToDoItem.self).map({ $0 })
        tableView.reloadData()
    }
    
}
