//
//  WatchManager.swift
//  FreshFridge
//
//  Created by changae choi on 2021/03/24.
//
//
import Foundation
import UIKit
import WatchConnectivity

struct WatchCartItem
{
    let id: Int
    let title: String
    let isChecked: Bool
    let count: String
    let rowIndex: Int
}

class WatchManager : NSObject, WCSessionDelegate
{
    static let shared = WatchManager()
    override private init()
    {
        super.init()
        
        if WCSession.isSupported()
        {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func Init()
    {
        
    }
    
    var activate = true
    func isActivate() -> Bool
    {
        return activate
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
    {
        if let error = error
        {
            NSLog("WC Session activation failed with error: \(error.localizedDescription)")
            return
        }
        NSLog("Phone activated with state: \(activationState.rawValue)")

        if !session.isWatchAppInstalled
       {
          NSLog("Watch app is not installed!")
       }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func sendCartItemToWatch(item : WatchCartItem)
    {
        // send information to watch
        if WCSession.isSupported()
        {
            let session = WCSession.default
            if session.activationState == .activated
            {
                let userInfo = ["id" : item.id,
                                "title" : item.title,
                                "isChecked" : item.isChecked,
                                "count" : item.count,
                                "rowIndex" : item.rowIndex
                ] as [String : Any]
            
                session.transferUserInfo(userInfo)
            }
        }
    }
    
    func sendAllCartItemToWatch()
    {
        // 로컬 데이터를 보내지 않고 watch도 서버로부터 직접 데이터를 받는다.
        return
        
        // send information to watch
        if WCSession.isSupported()
        {
            let session = WCSession.default
            if session.activationState == .activated
            {
                var watchGroceries: [WatchCartItem] = []
                var rowIndex = 0
                for cartGrocery in DataManager.shared.getCartGroceries()
                {
                    let count : String = cartGrocery.isPercentageCount ? "\(cartGrocery.count)%" : "\(cartGrocery.count)"
                    let item = WatchCartItem(id: cartGrocery.id.id, title: cartGrocery.info.title, isChecked: cartGrocery.isPurchased, count: count, rowIndex: rowIndex)
                    watchGroceries.append(item)
                    rowIndex += 1
                }
                
                let userInfo = ["numberOfRows" : watchGroceries.count] as [String : Any]
                session.transferUserInfo(userInfo)
                
                for item in watchGroceries
                {
                    let userInfo = ["id" : item.id,
                                    "title" : item.title,
                                    "isChecked" : item.isChecked,
                                    "count" : item.count,
                                    "rowIndex" : item.rowIndex
                    ] as [String : Any]
                
                    session.transferUserInfo(userInfo)
                }
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo:[String : Any] = [:])
    {
        if let command = userInfo["request"] as? String
        {
            switch command {
            case "allCartItem":
                sendAllCartItemToWatch()
            default:
               print("Not Implemented.")
            }
        }
    }
    
    //-----------------------------------------------------------------
    func addCartGrocery(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, count: Int = 1, isPercentageCount: Bool = false, isPurchased: Bool = false)
    {
        
    }
    func removeCartGrocery(id: AutoIncreasedID)
    {
        
    }
    func updateCartGrocery(id: AutoIncreasedID, isPurchased: Bool)
    {
        
    }
    func updateCartGrocery(id: AutoIncreasedID, count: Int)
    {
        
    }
    func updateCartGrocery(id: AutoIncreasedID, isPercentage: Bool)
    {
        
    }
    
}
