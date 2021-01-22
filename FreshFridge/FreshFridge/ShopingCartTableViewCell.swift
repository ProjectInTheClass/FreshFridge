//
//  ShopingCartTableViewCell.swift
//  FreshFridge
//
//  Created by Park Youngeun on 2021/01/20.
//

import Foundation
import UIKit

//protocol GroceryListCellDelegate: class {
//    func countButtonTapped(sender: GroceryListTableViewCell)}
protocol ShopingCartCellDelegate: class {
    func countButtonTapped(sender: ShopingCartTableViewCell)
    
    
}

class ShopingCartTableViewCell : UITableViewCell
{
    @IBOutlet weak var titleLabel: UIView!
}

class ShopingCartTableViewPictureCell : ShopingCartTableViewCell
{
    @IBOutlet weak var titleImage: UIImageView!
    
    
    
    
}
