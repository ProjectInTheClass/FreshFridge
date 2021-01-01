//
//  ItemTableViewCell.swift
//  TableViewHW
//
//  Created by iM27 on 2021/01/01.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var memoLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func contentUpdate(with itemIn: ItemStruct) {
        symbolLabel.text = itemIn.symbol
        nameLabel.text = itemIn.name
        memoLabel.text = itemIn.memo
        quantityLabel.text = "\(itemIn.quantity)"
//        quantityLabel.text = "\(itemIn.quantity)"
    }

}
