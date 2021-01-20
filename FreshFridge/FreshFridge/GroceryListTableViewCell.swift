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
        expirationLabel.layer.cornerRadius = 5
        expirationLabel.clipsToBounds = true // 신기하게 이 한줄이 있어야 실제로 코너라운드가 UI에 적용이 되는군요.
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func countButtonTapped(_ sender: Any) {
        
        //print("countButtonTapped")
        
        delegate?.countButtonTapped(sender: self)
        
        Grocery.saveGrocery(groceries)
    }
}


class GroceryListTableViewPictureCell : GroceryListTableViewCell
{
    @IBOutlet weak var titleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleImage.layer.cornerRadius = 5
        titleImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
