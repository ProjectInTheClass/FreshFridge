//
//  ImageTableViewCell.swift
//  FreshFridge
//
//  Created by changae choi on 2021/03/02.
//

import Foundation
import UIKit

protocol ImageTableViewCellDelegate: AnyObject {
    func selectedCell(cell: ImageTableViewCell)
}

class ImageTableViewCell: UITableViewCell
{
    weak var delegate: ImageTableViewCellDelegate?
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //titleImage.contentMode = .scaleAspectFit
        titleImage.layer.cornerRadius = 8
        titleImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        delegate?.selectedCell(cell: self)
    }
}
