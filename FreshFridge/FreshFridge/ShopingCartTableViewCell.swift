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
    //awakeFromNib : 인터페이스 빌더에서 만든 객체의 인스턴스 변수를 사용할려고 할때 사용

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //setSelected : 버튼 눌림 효과 

    func updateCell(with inCell:CartGrocery)
    {
        if(inCell.isPurchased)
        {
            CheckCartButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
        else
        {
            CheckCartButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        titleLabel.text = inCell.info.title
    }
    @IBAction func CheckCartButtonTapped(_ sender: UIButton) {
        delegate?.checkCartTapped(sender: self)
    }
}

class ShopingCartTableViewPictureCell : ShopingCartTableViewCell
{
    @IBOutlet weak var titleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleImage.contentMode = .scaleAspectFit
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func updateCell(with inCell:CartGrocery)
    {
        super.updateCell(with: inCell)
        
        if((inCell.info.image) != nil)
        {
            titleImage.image = inCell.info.image?.image()
        }
    }
}

