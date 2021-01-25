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

extension UITextField
{
    func updatePieChart(count: Int, isPercentage: Bool)
    {
        if(isPercentage == false)
        {
            self.text = "\(Int(count))"
            if(count > 0)
            {
                self.background = UIImage(named: "gray")
            }
            else
            {
                self.background = UIImage(named: "0percent")
            }
        }
        else
        {
            self.text = "\(Int(count))%"
            let countPercent : Int = (count / 10) * 10
            let imageName: String = "\(countPercent)percent"
            self.background = UIImage(named: imageName)
        }
    }
}
