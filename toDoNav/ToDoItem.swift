//
//  model.swift
//  toDoNav
//
//  Created by Marlon Orellana on 4/28/21.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    @objc dynamic var title: String?
    @objc dynamic var date: Date?
    dynamic var important: Bool?
}
