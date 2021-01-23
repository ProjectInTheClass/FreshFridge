//
//  ShopingCartTableViewCell.swift
//  FreshFridge
//
//  Created by Park Youngeun on 2021/01/20.
//

import UIKit

//protocol GroceryListCellDelegate: class {
//    func countButtonTapped(sender: GroceryListTableViewCell)}
protocol ShopingCartCellDelegate: class {
    func countButtonTapped(sender: ShopingCartTableViewCell)
    
    
}

class ShopingCartTableViewCell : UITableViewCell
{
    weak var delegate: ShopingCartCellDelegate?
    
    @IBOutlet weak var titleLabel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
/*
 override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
}

func updateCell(with inCell: GroceryHistory) {
    FavoriteMarkButton.isSelected = inCell.favorite
    PurchaseRecordListLabel.text = inCell.title
}
*/


class ShopingCartTableViewPictureCell : ShopingCartTableViewCell
{
    @IBOutlet weak var titleImage: UIImageView!
}
