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
        labelCellManager.shared.vc = self
        itemText.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemText.resignFirstResponder()
        labelCellManager.shared.labelText = itemText.text!
        print(textField.text!)
        return true
    }
    
    func getTextFieldText() -> String {
        if let text = itemText.text, !text.isEmpty {
            return text
        } else {
            print("Add something")
            return " "
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
