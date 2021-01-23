//  ShopingCartTableViewCell.swift
//  FreshFridge

//  Created by Park Youngeun on 2021/01/20.
//
// var cartGroceries = [CartGrocery]()
// class CartGrocery


import UIKit

protocol ShopingCartCellDelegate: class {
    func checkCartTapped(sender: ShopingCartTableViewCell)
}

class ShopingCartTableViewCell : UITableViewCell
{
    weak var delegate: ShopingCartCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var CheckCartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func updateCell(with inCell:CartGrocery) {
    CheckCartButton.isSelected = inCell.isPurchased
        titleLabel.text = inCell
    }
    
    
    @IBAction func CheckCartButtonTapped(_ sender: UIButton) {
        delegate?.checkCartTapped(sender: self)
    }
    

}

class ShopingCartTableViewPictureCell : ShopingCartTableViewCell
{
    @IBOutlet weak var titleImage: UIImageView!
}
