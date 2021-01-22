//
//  PurchaseRecordTableViewCell.swift
//  FreshFridge
//
//  Created by iM27 on 2021/01/19.
//

import UIKit

protocol PurchaseRecordCellDelegate: class {
    func fovoriteCheckMarkTapped(sender: PurchaseRecordTableViewCell)
}

class PurchaseRecordTableViewCell: UITableViewCell {
   
    weak var delegate: PurchaseRecordCellDelegate?
    
    @IBOutlet weak var FavoriteCheckButton: UIView!
    @IBOutlet weak var ListTextLabel: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func FavoriteButtonTapped(_ sender: UIButton) {
        delegate?.fovoriteCheckMarkTapped(sender: self)
    }
    
}