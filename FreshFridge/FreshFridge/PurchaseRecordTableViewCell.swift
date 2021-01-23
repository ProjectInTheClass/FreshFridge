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
    
   
    @IBOutlet weak var FavoriteMarkButton: UIButton!
    @IBOutlet weak var PurchaseRecordListLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
            
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(with inCell: GroceryHistory) {
//        FavoriteMarkButton.isSelected = inCell.favorite
        PurchaseRecordListLabel.text = inCell.title
        
        if inCell.favorite == true {
            FavoriteMarkButton.setImage(UIImage(named: "favorite-Icon.fill"), for: .normal)
        } else {
            FavoriteMarkButton.setImage(UIImage(named: "favorite-Icon"), for: .normal)
        }
    }
    
    
    
    @IBAction func FavoriteButtonTapped(_ sender: UIButton) {
        delegate?.fovoriteCheckMarkTapped(sender: self)
    }
    
}
