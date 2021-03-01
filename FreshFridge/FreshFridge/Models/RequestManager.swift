//
//  RequestManager.swift
//  FreshFridge
//
//  Created by changae choi on 2021/02/23.
//

import Foundation
import UIKit

func getRequestManager() -> RequestManager
{
    return RequestManager.shared
}

class RequestManager
{
    static let shared = RequestManager()
    
    let requestToServer: RequestToServer = RequestToServer()
    let requestToLocal: RequestToLocal = RequestToLocal()
    
    // update controllers
    var groceryListViewController: GroceryListTableViewController!
    var purchaseRecordViewController: PurchaseRecordTableViewController!
    var shopingCartViewController: ShopingCartTableViewController!
    
    var isUpdateGroceryList: Bool = false
    var isUpdatePurchaseRecord: Bool = false
    var isUpdateShopingCart: Bool = false
    
    func getRequestInterface() -> RequestInterface
    {
        if( ShareManager.shared.isShared() )
        {
            return requestToServer
        }
        else
        {
            return requestToLocal
        }
    }
    
    func updateGroceryListViewController(updateTableView: Bool)
    {
        print("start_function")
        
        guard groceryListViewController != nil else { return }
        
        DispatchQueue.main.async()
        {
            if(updateTableView)
            {
                self.groceryListViewController.updateTableView()
            }
            print("start_reload")
            self.groceryListViewController.tableView.reloadData()
            print("end reload")
        }
        
        print("end_function")
    }
    
    func updatePurchaseRecordViewController(updateTableView: Bool)
    {
        guard purchaseRecordViewController != nil else { return }
        
        DispatchQueue.main.async()
        {
            if(updateTableView)
            {
                self.purchaseRecordViewController.updateTableView()
            }
            self.purchaseRecordViewController.tableView.reloadData()
        }
    }
    
    func updateShopingCartViewController(updateTableView: Bool)
    {
        guard shopingCartViewController != nil else { return }
        
        DispatchQueue.main.async()
        {
            if(updateTableView)
            {
                self.shopingCartViewController.updateTableView()
            }
            self.shopingCartViewController.tableView.reloadData()
        }
    }
    
    func animateBadge(tabBarIndex: TabBarIndex)
    {
        guard groceryListViewController != nil else { return }
        
        DispatchQueue.main.async()
        {
            self.groceryListViewController.fridgeTabBarController.animateBadge(tabBarIndex: tabBarIndex)
        }
    }
    
    func removeAlarm(grocery: Grocery)
    {
        for n in -2...2
        {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [grocery.id.string + "_\(n)"])
        }
    }
    
    func setAlarm(grocery : Grocery)
    {
        let expiration = grocery.dueDate.getExpiration()
       
        if(expiration <= -2)
        {
            let n = -2
            let content = UNMutableNotificationContent()
            content.title = "기간 만료 알림".localized()
            content.body = "%@의 보관 기간이 %d일 남았습니다.".localized(with: [grocery.info.title, -n])//"\(grocery.info.title)의 보관 기간이 \(-n)일 남았습니다."
            //print(content.body+grocery.id.uuidString+"_\(n)")
            content.categoryIdentifier = "alarm"
            content.userInfo = ["customData": "fizzbuzz"]
            content.sound = .default
            
            let nextTriggerDate = Calendar.current.date(byAdding: .day, value: n, to: grocery.dueDate.date)!
            //print(nextTriggerDate)
            let comps = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: nextTriggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
            
            let request = UNNotificationRequest(identifier: grocery.id.string + "_\(n)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
        
        if(expiration <= -1)
        {
            let n = -1
            let content = UNMutableNotificationContent()
            content.title = "기간 만료 알림".localized()
            content.body = "%@의 보관 기간이 %d일 남았습니다.".localized(with: [grocery.info.title, -n])//"\(grocery.info.title)의 보관 기간이 \(-n)일 남았습니다."
            //print(content.body+grocery.id.uuidString + "_\(n)")
            content.categoryIdentifier = "alarm"
            content.userInfo = ["customData": "fizzbuzz"]
            content.sound = .default
            
            let nextTriggerDate = Calendar.current.date(byAdding: .day, value: n, to: grocery.dueDate.date)!
            //print(nextTriggerDate)
            let comps = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: nextTriggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
            
            let request = UNNotificationRequest(identifier: grocery.id.string + "_\(n)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
        
        if(expiration < 3)
        {
            let content = UNMutableNotificationContent()
            content.title = "기간 만료 알림".localized()
            //content.body = "\(grocery.info.title)의 보관 기간이 만료되었습니다.."
            content.body = "%@의 보관 기간이 만료되었습니다.".localized(with: [grocery.info.title])//"\(grocery.info.title)의 보관 기간이 \(-n)일 남았습니다."
            
            content.categoryIdentifier = "alarm"
            content.userInfo = ["customData": "fizzbuzz"]
            content.sound = .default
            
            for n in 0...2
            {
                //print(content.body+grocery.id.uuidString + "_\(n)")
                
                let nextTriggerDate = Calendar.current.date(byAdding: .day, value: n, to: grocery.dueDate.date)!
                //sprint(nextTriggerDate)
                let comps = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: nextTriggerDate)
                let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                
                let request = UNNotificationRequest(identifier: grocery.id.string + "_\(n)", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
    func resetAllAlarms()
    {
        //guard  self.grantedAuthorization == true else { return }
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        for grocery in DataManager.shared.getGroceries()
        {
            setAlarm(grocery: grocery)
        }
    }
    
    func resetAlarm(grocery: Grocery)
    {
        removeAlarm(grocery: grocery)
        setAlarm(grocery: grocery)
    }
}

//-----------------------------------------------------------------------------

class RequestInterface
{
    //
    func addGrocery(title: String, category: GroceryHistory.Category, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Grocery.Storage, fridgeName: String, notes: String, image: GroceryImage?) {}
    func removeGrocery(id: AutoIncreasedID) {}
    func updateGrocery(id: AutoIncreasedID, count: Int) {}
    func updateGrocery(id: AutoIncreasedID, isPercentageCount: Bool) {}
    func updateGrocery(id: AutoIncreasedID, dueDate: DueDate) {}
    func updateGrocery(id: AutoIncreasedID, storage: Grocery.Storage) {}
    func updateGrocery(id: AutoIncreasedID, fridgeName: String) {}
    func updateGrocery(id: AutoIncreasedID, notes:String?) {}
    func updateGrocery(id: AutoIncreasedID, title: String) {}

    //
    func addCartGrocery(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, count: Int = 1, isPercentageCount: Bool = false, isPurchased: Bool = false) {}
    func removeCartGrocery(id: AutoIncreasedID) {}
    func updateCartGrocery(id: AutoIncreasedID, isPurchased: Bool) {}
    func updateCartGrocery(id: AutoIncreasedID, count: Int) {}
    func updateCartGrocery(id: AutoIncreasedID, isPercentage: Bool) {}
    
    //
    func removeGroceryHistory(id: AutoIncreasedID) {}
    func updateGroceryHistory(id: AutoIncreasedID, title: String) {}
    func updateGroceryHistory(id: AutoIncreasedID, category: GroceryHistory.Category) {}
    func updateGroceryHistory(id: AutoIncreasedID, image: GroceryImage?) {}
    func updateGroceryHistory(id: AutoIncreasedID, favorite: Bool) {}
}

//-----------------------------------------------------------------------------

class RequestToServer : RequestInterface
{
    override func addGrocery(title: String, category: GroceryHistory.Category, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Grocery.Storage, fridgeName: String, notes: String, image: GroceryImage?)
    {
        guard ShareManager.shared.isShared() else { return }
        
        var productID = -1
        if let groceryHistory = DataManager.shared.getGroceryHistory(title: title, category: category)
        {
            productID = groceryHistory.id.id
            
            if let image = image,
               let uiImage = image.image()
            {
                groceryHistory.image = image
                ShareManager.shared.uploadImage(image: uiImage, filename: image.filename)
                {
                    (imageName: String) in
                    image.resetFilename(name: imageName)
                    ShareManager.shared.updateGroceryHistory(id: groceryHistory.id, image: image)
                    {
                    }
                }
            }
            
            ShareManager.shared.updateGroceryHistory(id: groceryHistory.id, lastPurchaseDate: Date())
            {
                DataManager.shared.moveToTheFrontGroceryHistory(groceryHistory: groceryHistory)
                
                ShareManager.shared.createGrocery(productID: productID, count: count, isPercentageCount: isPercentageCount, dueDate: dueDate, storage: storage, fridgeName: fridgeName, notes: notes, image: image)
                {
                    (refriItem: ShareManager.RefrigeratorItem) in
                    DataManager.shared.insertGrocery(id: refriItem.id, title: refriItem.product!.title,
                                                     category: GroceryHistory.Category(rawValue: refriItem.product!.category) ?? GroceryHistory.Category.ETC,
                                              count: refriItem.count,
                                              isPercentageCount: refriItem.isPercentageCount,
                                              dueDate: DueDate(timeIntervalSince1970MS: Int(refriItem.dueDate) ?? 0),
                                              storage: Grocery.Storage(rawValue: refriItem.storage) ?? Grocery.Storage.Refrigeration,
                                              fridgeName: refriItem.fridgeName,
                                              notes: refriItem.notes,
                                              image: nil)
                    
                    getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
                    getRequestManager().updateGroceryListViewController(updateTableView: true)
                    
                    getRequestManager().animateBadge(tabBarIndex: .fridgeTabBar)
                }
            }
        }
        else
        {
            // 없으면 서버에 product를 추가한다.
            ShareManager.shared.createGroceryHistoryForRefri(title: title, category: category, image: image, count: count, isPercentageCount: isPercentageCount, dueDate: dueDate, storage: storage, fridgeName: fridgeName, notes: notes)
            { (refriItem: ShareManager.RefrigeratorItem) in
                DataManager.shared.insertGrocery(id: refriItem.id, title: refriItem.product!.title,
                                                 category: GroceryHistory.Category(rawValue: refriItem.product!.category) ?? GroceryHistory.Category.ETC,
                                          count: refriItem.count,
                                          isPercentageCount: refriItem.isPercentageCount,
                                          dueDate: DueDate(timeIntervalSince1970MS: Int(refriItem.dueDate) ?? 0),
                                          storage: Grocery.Storage(rawValue: refriItem.storage) ?? Grocery.Storage.Refrigeration,
                                          fridgeName: refriItem.fridgeName,
                                          notes: refriItem.notes,
                                          image: nil)
                
                getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
                getRequestManager().updateGroceryListViewController(updateTableView: true)
                
                getRequestManager().animateBadge(tabBarIndex: .fridgeTabBar)
            }
        }
    }
    
    override func removeGrocery(id: AutoIncreasedID)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.deleteGrocery(id: id)
        {
            getRequestManager().updateGroceryListViewController(updateTableView: true)
        }
    }
    
    override func updateGrocery(id: AutoIncreasedID, count: Int)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateGrocery(id: id, count: count)
        {
            getRequestManager().updateGroceryListViewController(updateTableView: false)
        }
    }
    override func updateGrocery(id: AutoIncreasedID, isPercentageCount: Bool)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateGrocery(id: id, isPercentageCount: isPercentageCount)
        {
            getRequestManager().updateGroceryListViewController(updateTableView: false)
        }
    }
    override func updateGrocery(id: AutoIncreasedID, dueDate: DueDate)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateGrocery(id: id, dueDate: dueDate)
        {
            getRequestManager().updateGroceryListViewController(updateTableView: false)
        }
    }
    override func updateGrocery(id: AutoIncreasedID, storage: Grocery.Storage)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateGrocery(id: id, storage: storage)
        {
            getRequestManager().updateGroceryListViewController(updateTableView: false)
        }
    }
    override func updateGrocery(id: AutoIncreasedID, fridgeName: String)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateGrocery(id: id, fridgeName: fridgeName)
        {
            getRequestManager().updateGroceryListViewController(updateTableView: false)
        }
    }
    override func updateGrocery(id: AutoIncreasedID, notes:String?)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateGrocery(id: id, notes: notes)
        {
            getRequestManager().updateGroceryListViewController(updateTableView: false)
        }
    }
    
    // 알람 설정을 위해 updateGroceryHistory대신 사용
    override func updateGrocery(id: AutoIncreasedID, title: String)
    {
        guard ShareManager.shared.isShared() else { return }
        
        if let grocery = DataManager.shared.findGrocery(id: id)
        {
            ShareManager.shared.updateGrocery(id: grocery.id, title: title)
            {
                getRequestManager().updateGroceryListViewController(updateTableView: false)
            }
        }
    }
    
    override func addCartGrocery(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, count: Int = 1, isPercentageCount: Bool = false, isPurchased: Bool = false)
    {
        guard ShareManager.shared.isShared() else { return }
        
        // product가 있는지 찾아본다.
        var productID = -1
        if let groceryHistory = DataManager.shared.getGroceryHistory(title: title, category: category)
        {
            productID = groceryHistory.id.id
            // processing image
            if let image = image,
               let uiImage = image.image()
            {
                ShareManager.shared.uploadImage(image: uiImage, filename: image.filename)
                {
                    (imageName: String) in
                    image.resetFilename(name: imageName)
                    ShareManager.shared.updateGroceryHistory(id: groceryHistory.id, image: image)
                    {
                    }
                }
            }
            
            ShareManager.shared.updateGroceryHistory(id: groceryHistory.id, lastPurchaseDate: Date())
            {
                DataManager.shared.moveToTheFrontGroceryHistory(groceryHistory: groceryHistory)
                
                ShareManager.shared.createCartGrocery(productID: productID, count: count, isPercentageCount: isPercentageCount, isPurchased: isPurchased)
                { (cartItem: ShareManager.CartItem) in
                    
                    DataManager.shared.insertCartGrocery(title: cartItem.product!.title, category: GroceryHistory.Category(rawValue: cartItem.product!.category) ?? GroceryHistory.Category.ETC, image: nil,
                                                                   id: cartItem.id, count: cartItem.count, isPercentageCount: cartItem.isPercentageCount, isPurchased: cartItem.isPurchased)
                    getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
                    getRequestManager().updateShopingCartViewController(updateTableView: true)
                    
                    getRequestManager().animateBadge(tabBarIndex: .shopingCartTabBar)
                }
            }
        }
        else
        {
            // 없으면 서버에 product를 추가한다.
            ShareManager.shared.createGroceryHistoryForCart(title: title, category: category, image: image, count: count, isPercentageCount: isPercentageCount, isPurchased: isPurchased )
            {
                (cartItem: ShareManager.CartItem) in
                
                DataManager.shared.insertCartGrocery(title: cartItem.product!.title, category: GroceryHistory.Category(rawValue: cartItem.product!.category) ?? GroceryHistory.Category.ETC, image: image,
                                                               id: cartItem.id, count: cartItem.count, isPercentageCount: cartItem.isPercentageCount, isPurchased: cartItem.isPurchased)
                
                getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
                getRequestManager().updateShopingCartViewController(updateTableView: true)
                
                getRequestManager().animateBadge(tabBarIndex: .shopingCartTabBar)
            }
        }
    }
    
    override func removeCartGrocery(id: AutoIncreasedID)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.deleteCartGrocery(id: id)
        {
            getRequestManager().updateShopingCartViewController(updateTableView: true)
        }
    }
    
    override func updateCartGrocery(id: AutoIncreasedID, isPurchased: Bool)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateCartGrocery(id: id, isPurchased: isPurchased)
        {
            getRequestManager().updateShopingCartViewController(updateTableView: false)
        }
    }
    
    override func updateCartGrocery(id: AutoIncreasedID, count: Int)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateCartGrocery(id: id, count: count)
        {
            getRequestManager().updateShopingCartViewController(updateTableView: false)
        }
    }
    
    override func updateCartGrocery(id: AutoIncreasedID, isPercentage: Bool)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateCartGrocery(id: id, isPercentage: isPercentage)
        {
            getRequestManager().updateShopingCartViewController(updateTableView: false)
        }
    }
    
    override func removeGroceryHistory(id: AutoIncreasedID)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.deleteGroceryHistory(id: id)
        {
            getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
        }
    }
    
    override func updateGroceryHistory(id: AutoIncreasedID, title: String)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateGroceryHistory(id: id, title: title)
        {
            getRequestManager().updatePurchaseRecordViewController(updateTableView: false)
            getRequestManager().updateShopingCartViewController(updateTableView: false)
            getRequestManager().updateGroceryListViewController(updateTableView: false)
        }
    }
    
    override func updateGroceryHistory(id: AutoIncreasedID, category: GroceryHistory.Category)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateGroceryHistory(id: id, category: category)
        {
            getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
            getRequestManager().updateShopingCartViewController(updateTableView: true)
            getRequestManager().updateGroceryListViewController(updateTableView: true)
        }
    }
    
    override func updateGroceryHistory(id: AutoIncreasedID, image: GroceryImage?)
    {
        guard ShareManager.shared.isShared() else { return }
        
        if let image = image,
            let uiImage = image.image()
        {
            ShareManager.shared.uploadImage(image: uiImage, filename: image.filename)
            {
                (imageName: String) in
                
                image.resetFilename(name: imageName)
                ShareManager.shared.updateGroceryHistory(id: id, image: image)
                {
                    getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
                    getRequestManager().updateShopingCartViewController(updateTableView: true)
                    getRequestManager().updateGroceryListViewController(updateTableView: true)
                }
            }
        }
        
        
    }
    
    override func updateGroceryHistory(id: AutoIncreasedID, favorite: Bool)
    {
        guard ShareManager.shared.isShared() else { return }
        
        ShareManager.shared.updateGroceryHistory(id: id, favorite: favorite)
        {
            getRequestManager().updatePurchaseRecordViewController(updateTableView: false)
        }
    }
}

//-----------------------------------------------------------------------------

class RequestToLocal : RequestInterface
{
    override func addGrocery(title: String, category: GroceryHistory.Category, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Grocery.Storage, fridgeName: String, notes: String, image: GroceryImage?)
    {
        if let groceryHistory = DataManager.shared.getGroceryHistory(title: title, category: category)
        {
            DataManager.shared.moveToTheFrontGroceryHistory(groceryHistory: groceryHistory)
        }
        else
        {
            DataManager.shared.insertGroceryHistory(id: -1, title: title, category: category, image: image, updateDate: true)
            
            if let image = image
            {
                GroceryImage.saveImage(image: image.image(), filename: image.filename)
            }
        }
        
        DataManager.shared.insertGrocery(id: -1, title: title, category: category, count: count, isPercentageCount: isPercentageCount, dueDate: dueDate, storage: storage, fridgeName: fridgeName, notes: notes, image: image)
        
        getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
        getRequestManager().updateGroceryListViewController(updateTableView: true)
        getRequestManager().animateBadge(tabBarIndex: .fridgeTabBar)
    }
    
    override func removeGrocery(id: AutoIncreasedID)
    {
        DataManager.shared.removeGrocery(id: id)
        getRequestManager().updateGroceryListViewController(updateTableView: true)
    }
    
    override func updateGrocery(id: AutoIncreasedID, count: Int)
    {
        DataManager.shared.updateGrocery(id: id, count: count)
        getRequestManager().updateGroceryListViewController(updateTableView: false)
    }
    
    override func updateGrocery(id: AutoIncreasedID, isPercentageCount: Bool)
    {
        DataManager.shared.updateGrocery(id: id, isPercentageCount: isPercentageCount)
        getRequestManager().updateGroceryListViewController(updateTableView: false)
    }
    
    override func updateGrocery(id: AutoIncreasedID, dueDate: DueDate)
    {
        if DataManager.shared.findGrocery(id: id) != nil
        {
            DataManager.shared.updateGrocery(id: id, dueDate: dueDate)
            getRequestManager().updateGroceryListViewController(updateTableView: false)
        }
    }
    
    override func updateGrocery(id: AutoIncreasedID, storage: Grocery.Storage)
    {
        DataManager.shared.updateGrocery(id: id, storage: storage)
        getRequestManager().updateGroceryListViewController(updateTableView: false)
    }
    
    override func updateGrocery(id: AutoIncreasedID, fridgeName: String)
    {
        DataManager.shared.updateGrocery(id: id, fridgeName: fridgeName)
        getRequestManager().updateGroceryListViewController(updateTableView: false)
    }
    
    override func updateGrocery(id: AutoIncreasedID, notes: String?)
    {
        DataManager.shared.updateGrocery(id: id, notes: notes)
        getRequestManager().updateGroceryListViewController(updateTableView: false)
    }
    
    // 알람 설정을 위해 updateGroceryHistory대신 사용
    override func updateGrocery(id: AutoIncreasedID, title: String)
    {
        if let grocery = DataManager.shared.findGrocery(id: id)
        {
            DataManager.shared.updateGrocery(id: grocery.id, title: title)
            getRequestManager().updateGroceryListViewController(updateTableView: false)
        }
    }
    
    //
    override func addCartGrocery(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, count: Int = 1, isPercentageCount: Bool = false, isPurchased: Bool = false)
    {
        if let groceryHistory = DataManager.shared.getGroceryHistory(title: title, category: category)
        {
            DataManager.shared.moveToTheFrontGroceryHistory(groceryHistory: groceryHistory)
        }
        else
        {
            DataManager.shared.insertGroceryHistory(id: -1, title: title, category: category, image: image, updateDate: true)
            if let image = image
            {
                GroceryImage.saveImage(image: image.image(), filename: image.filename)
            }
        }
        
        DataManager.shared.insertCartGrocery(title: title, category: category, image: image,
                                                       id: -1, count: count, isPercentageCount: isPercentageCount, isPurchased: isPurchased)
        
        getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
        getRequestManager().updateShopingCartViewController(updateTableView: true)
        getRequestManager().animateBadge(tabBarIndex: .shopingCartTabBar)
    }
    
    override func removeCartGrocery(id: AutoIncreasedID)
    {
        DataManager.shared.removeCartGrocery(id: id)
        getRequestManager().updateShopingCartViewController(updateTableView: true)
    }
    
    override func updateCartGrocery(id: AutoIncreasedID, isPurchased: Bool)
    {
        DataManager.shared.updateCartGrocery(id: id, isPurchased: isPurchased)
        getRequestManager().updateShopingCartViewController(updateTableView: false)
    }
    
    override func updateCartGrocery(id: AutoIncreasedID, count: Int)
    {
        DataManager.shared.updateCartGrocery(id: id, count: count)
        getRequestManager().updateShopingCartViewController(updateTableView: false)
    }
    
    override func updateCartGrocery(id: AutoIncreasedID, isPercentage: Bool)
    {
        DataManager.shared.updateCartGrocery(id: id, isPercentage: isPercentage)
        getRequestManager().updateShopingCartViewController(updateTableView: false)
    }
    
    override func removeGroceryHistory(id: AutoIncreasedID)
    {
        DataManager.shared.removeGroceryHistory(id: id)
        getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
    }
    
    override func updateGroceryHistory(id: AutoIncreasedID, title: String)
    {
        DataManager.shared.updateGroceryHistory(id: id, title: title)
        getRequestManager().updatePurchaseRecordViewController(updateTableView: false)
        getRequestManager().updateShopingCartViewController(updateTableView: false)
        getRequestManager().updateGroceryListViewController(updateTableView: false)
    }
    
    override func updateGroceryHistory(id: AutoIncreasedID, category: GroceryHistory.Category)
    {
        DataManager.shared.updateGroceryHistory(id: id, category: category)
        getRequestManager().updatePurchaseRecordViewController(updateTableView: true)
        getRequestManager().updateShopingCartViewController(updateTableView: true)
        getRequestManager().updateGroceryListViewController(updateTableView: true)
    }
    
    override func updateGroceryHistory(id: AutoIncreasedID, image: GroceryImage?)
    {
        DataManager.shared.updateGroceryHistory(id: id, image: image)
        if let image = image
        {
            GroceryImage.saveImage(image: image.image(), filename: image.filename)
        }
        getRequestManager().updatePurchaseRecordViewController(updateTableView: false)
        getRequestManager().updateShopingCartViewController(updateTableView: false)
        getRequestManager().updateGroceryListViewController(updateTableView: false)
    }
    
    override func updateGroceryHistory(id: AutoIncreasedID, favorite: Bool)
    {
        DataManager.shared.updateGroceryHistory(id: id, favorite: favorite)
        
        getRequestManager().updatePurchaseRecordViewController(updateTableView: false)
    }
}
