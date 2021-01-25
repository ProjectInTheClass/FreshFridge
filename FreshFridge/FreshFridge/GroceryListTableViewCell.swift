//
//  GroceryListTableViewCell.swift
//  GroceryListTableView
//
//  Created by changae choi on 2020/12/26.
//

import UIKit

protocol GroceryListCellDelegate: class {
    func countButtonTapped(sender: GroceryListTableViewCell)
    func selectedCell()
}

class GroceryListTableViewCell: UITableViewCell {
    
    weak var delegate: GroceryListCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expirationLabel.layer.cornerRadius = 3
        expirationLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if(selected)
        {
            delegate?.selectedCell()
        }
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
        /*
        titleImage.contentMode = .scaleAspectFill
        titleImage.layer.cornerRadius = 3
        titleImage.clipsToBounds = true
        */
        // cornerRadius와 scaleAspectFit이 동시에 안됨
        titleImage.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
}
