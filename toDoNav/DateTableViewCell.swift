//
//  DateTableViewCell.swift
//  toDoNav
//
//  Created by Marlon Orellana on 4/28/21.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    static let identifier = "DateTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DateTableViewCell", bundle: nil)
    }

    @IBOutlet var datePicker: UIDatePicker!
    
    static let dateFormatterGet: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
    static let dateFormatterPrint: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm:ss"
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.setDate(Date(), animated: true)
        datePicker.datePickerMode = .dateAndTime
        let timeZone = TimeZone.init(identifier: "America/New_York")
        guard let newTimeZone = timeZone else {return}
        datePicker.timeZone = newTimeZone
        // Initialization code
    }
    
    @IBAction func didChangeDate() -> Void {
        print(datePicker.date)
        todoItem.date = datePicker.date
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
