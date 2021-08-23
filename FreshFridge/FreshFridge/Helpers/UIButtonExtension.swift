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
    
    func hideButton(isOn: Bool) {
        if(isOn)
        {
            setTitleColor(.white, for: .normal)
            //let image = UIImage(named: "radio-off")!
            let image = UIImage(named: "radio-off")!.withAlignmentRectInsets(UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
            setBackgroundImage(image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            tintColor = .link
            layoutIfNeeded()
            subviews.first?.contentMode = .scaleAspectFit
        }
        else
        {
            setTitleColor(.link, for: .normal)
            setBackgroundImage(nil, for: .normal)
//            setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0), for: .normal)
//            tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }
    
    func updatePieChart(count: Int, isPercentage: Bool)
    {
        if(isPercentage == false)
        {
            self.setTitle("\(Int(count))", for: .normal)
            if(count > 0)
            {
                self.setBackgroundImage(UIImage(named: "gray-stroke"), for: .normal)
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
                self.background = UIImage(named: "gray-stroke")
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
