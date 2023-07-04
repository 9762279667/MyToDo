//
//  ItemCell.swift
//  MyToDo
//
//  Created by Nitin Kalokhe on 18/06/23.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    lazy var dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
    }
    
    func configCell(with item: ToDoItem, isChecked: Bool = false){
        if isChecked {
            let attributeString = NSAttributedString(string: item.title!, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributeString
            timestampLabel.text = nil
            locationLabel.text = nil
        }else{
            titleLabel.text = item.title
         
            if let timestamp = item.timestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                timestampLabel.text = dateFormatter.string(from: date)
            }
            
            if let location = item.location {
                locationLabel.text = location.name
            }
        }
    }
    
}
