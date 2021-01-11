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
    
    func updatePieChart(count: Double, isPercentage: Bool) {
        if(isPercentage == false)
        {
            self.setTitle("\(Int(count))", for: .normal)
            self.setBackgroundImage(UIImage(named: "gray"), for: .normal)
        }
        else
        {
            self.setTitle("\(Int(count*100))%", for: .normal)
            self.setTitleColor(.white, for: .normal)
            if(count >= 0.9)
            {
                self.setBackgroundImage(UIImage(named: "100percent"), for: .normal)
            }
            else if(count >= 0.8)
            {
                self.setBackgroundImage(UIImage(named: "90percent"), for: .normal)
            }
            else if(count >= 0.7)
            {
                self.setBackgroundImage(UIImage(named: "80percent"), for: .normal)
            }
            else if(count >= 0.6)
            {
                self.setBackgroundImage(UIImage(named: "70percent"), for: .normal)
            }
            else if(count >= 0.5)
            {
                self.setBackgroundImage(UIImage(named: "60percent"), for: .normal)
            }
            else if(count >= 0.4)
            {
                self.setBackgroundImage(UIImage(named: "50percent"), for: .normal)
            }
            else if(count >= 0.3)
            {
                self.setBackgroundImage(UIImage(named: "40percent"), for: .normal)
            }
            else if(count >= 0.2)
            {
                self.setBackgroundImage(UIImage(named: "30percent"), for: .normal)
            }
            else if(count >= 0.1)
            {
                self.setBackgroundImage(UIImage(named: "20percent"), for: .normal)
            }
            else if(count > 0.0)
            {
                self.setBackgroundImage(UIImage(named: "10percent"), for: .normal)
            }
            else
            {
                self.setBackgroundImage(UIImage(named: "0percent"), for: .normal)
                self.setTitleColor(.systemGray, for: .normal)
            }
        }
    }
}
