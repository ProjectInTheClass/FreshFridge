//
//  LoadingHUD.swift
//  LoadingExample
//
//  Created by Fury on 31/05/2019.
//  Copyright © 2019 Fury. All rights reserved.
//
import Foundation
import UIKit

class LoadingHUD {
    private static let sharedInstance = LoadingHUD()
    
    private var backgroundView: UIView?
    private var popupView: UIImageView?
    private var loadingLabel: UILabel?
    
    private var loadingIndicator: ProgressView?
    
    class func showProgressAnimation() {
        let backgroundView = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        let popupView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        popupView.animationImages = LoadingHUD.getAnimationImageArray()
        popupView.animationDuration = 0.8
        popupView.animationRepeatCount = 0
        
        let loadingLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        loadingLabel.text = "Loading ..."
        loadingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        loadingLabel.textColor = .black
        
        //if let window = UIApplication.shared.keyWindow {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        {
            window.addSubview(backgroundView)
            window.addSubview(popupView)
            window.addSubview(loadingLabel)
            
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            
            popupView.center = window.center
            popupView.startAnimating()
            
            loadingLabel.layer.position = CGPoint(x: window.frame.midX, y: popupView.frame.maxY + 10)
            
            sharedInstance.backgroundView?.removeFromSuperview()
            sharedInstance.popupView?.removeFromSuperview()
            sharedInstance.loadingLabel?.removeFromSuperview()
            sharedInstance.backgroundView = backgroundView
            sharedInstance.popupView = popupView
            sharedInstance.loadingLabel = loadingLabel
        }
    }
    
    
    
    class func hideProgressAnimation() {
        if let popupView = sharedInstance.popupView,
            let loadingLabel = sharedInstance.loadingLabel,
            let backgroundView = sharedInstance.backgroundView{
            popupView.stopAnimating()
            backgroundView.removeFromSuperview()
            popupView.removeFromSuperview()
            loadingLabel.removeFromSuperview()
        }
    }
    
    class func showProgressCircle() {
        let backgroundView = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        // MARK: - Properties
        let loadingIndicator: ProgressView = {
            let progress = ProgressView(colors: [/*.red, .systemGreen, */.systemBlue], lineWidth: 5)
            progress.translatesAutoresizingMaskIntoConstraints = false
            return progress
        }()
        
        //if let window = UIApplication.shared.keyWindow { // deprecated
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        {
            
            window.addSubview(backgroundView)
            window.addSubview(loadingIndicator)
            
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            
            sharedInstance.backgroundView?.removeFromSuperview()
            sharedInstance.loadingIndicator?.removeFromSuperview()
            sharedInstance.backgroundView = backgroundView
            sharedInstance.loadingIndicator = loadingIndicator
            
            NSLayoutConstraint.activate([
                       loadingIndicator.centerXAnchor
                        .constraint(equalTo: window.centerXAnchor),
                       loadingIndicator.centerYAnchor
                           .constraint(equalTo: window.centerYAnchor),
                       loadingIndicator.widthAnchor
                           .constraint(equalToConstant: 50),
                       loadingIndicator.heightAnchor
                        .constraint(equalTo: sharedInstance.loadingIndicator!.widthAnchor)
                   ])
        }
        
        loadingIndicator.isAnimating = true
    }
    
    
    
    class func hideProgressCircle()
    {
        if let backgroundView = sharedInstance.backgroundView,
           let loadingIndicator = sharedInstance.loadingIndicator {
            loadingIndicator.isAnimating = false
            backgroundView.removeFromSuperview()
            loadingIndicator.removeFromSuperview()
        }
    }

    private class func getAnimationImageArray() -> [UIImage] {
        var animationArray: [UIImage] = []
        animationArray.append(UIImage(named: "frame_loading_01")!)
        animationArray.append(UIImage(named: "frame_loading_02")!)
        animationArray.append(UIImage(named: "frame_loading_03")!)
        animationArray.append(UIImage(named: "frame_loading_04")!)
        animationArray.append(UIImage(named: "frame_loading_05")!)
        animationArray.append(UIImage(named: "frame_loading_06")!)
        animationArray.append(UIImage(named: "frame_loading_07")!)
        animationArray.append(UIImage(named: "frame_loading_08")!)
        animationArray.append(UIImage(named: "frame_loading_09")!)
        animationArray.append(UIImage(named: "frame_loading_10")!)
        animationArray.append(UIImage(named: "frame_loading_11")!)
        animationArray.append(UIImage(named: "frame_loading_12")!)
        animationArray.append(UIImage(named: "frame_loading_13")!)
        animationArray.append(UIImage(named: "frame_loading_14")!)
        animationArray.append(UIImage(named: "frame_loading_15")!)
        animationArray.append(UIImage(named: "frame_loading_16")!)
        animationArray.append(UIImage(named: "frame_loading_17")!)
        animationArray.append(UIImage(named: "frame_loading_18")!)
        animationArray.append(UIImage(named: "frame_loading_19")!)
        animationArray.append(UIImage(named: "frame_loading_20")!)
        animationArray.append(UIImage(named: "frame_loading_21")!)
        animationArray.append(UIImage(named: "frame_loading_22")!)
        animationArray.append(UIImage(named: "frame_loading_23")!)
        animationArray.append(UIImage(named: "frame_loading_24")!)
        animationArray.append(UIImage(named: "frame_loading_25")!)
        animationArray.append(UIImage(named: "frame_loading_26")!)
        animationArray.append(UIImage(named: "frame_loading_27")!)
        return animationArray
    }
    
    
    
}
