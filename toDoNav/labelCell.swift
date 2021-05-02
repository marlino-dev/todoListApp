//
//  labelCell.swift
//  toDoNav
//
//  Created by Marlon Orellana on 4/28/21.
//

import UIKit

class labelCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "labelCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "labelCell", bundle: nil)
    }
    
    @IBOutlet var itemText: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        itemText.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemText.resignFirstResponder()
        todoItem.title = textField.text ?? ""
        print("\(todoItem.title ?? "")")
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
