//
//  GroceryListTableViewCell.swift
//  GroceryListTableView
//
//  Created by changae choi on 2020/12/26.
//

import UIKit

protocol GroceryListCellDelegate: class {
    func countButtonTapped(sender: GroceryListTableViewCell)
}

class GroceryListTableViewCell: UITableViewCell {
    
    weak var delegate: GroceryListCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expirationLabel.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func countButtonTapped(_ sender: Any) {
        
        print("countButtonTapped")
        
        delegate?.countButtonTapped(sender: self)
    }
    
    
    
    
}
