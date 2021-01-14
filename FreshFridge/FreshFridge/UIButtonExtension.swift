//
//  UIButtonExtension.swift
//  GroceryListTableView
//
//  Created by changae choi on 2021/01/11.
//

import Foundation
import UIKit

extension UIButton
{
    func switchOnOff(isOn: Bool)
    {
        if(isOn)
        {   
            setTitleColor(.systemBlue, for: .normal)
        }
        else
        {
            setTitleColor(.systemGray, for: .normal)
        }
    }
    
    func updatePieChart(count: Int, isPercentage: Bool)
    {
        if(isPercentage == false)
        {
            self.setTitle("\(Int(count))", for: .normal)
            if(count > 0)
            {
                self.setBackgroundImage(UIImage(named: "gray"), for: .normal)
            }
            else
            {
                self.setBackgroundImage(UIImage(named: "0percent"), for: .normal)
            }
        }
        else
        {
            self.setTitle("\(Int(count))%", for: .normal)
            let imageName: String = "\(count)percent"
            self.setBackgroundImage(UIImage(named: imageName), for: .normal)
        }
    }
}
