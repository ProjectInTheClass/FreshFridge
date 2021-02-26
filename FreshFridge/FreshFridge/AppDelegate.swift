//
//  AppDelegate.swift
//  FreshFridge
//
//  Created by changae choi on 2021/01/12.
//

import UIKit

//func getAppDelegate() -> AppDelegate
//{
//    return (UIApplication.shared.delegate as! AppDelegate)
//}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    //var grantedAuthorization: Bool = false
    var timer = Timer()
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        scheduledTimerWithTimeInterval()
        
        if( ShareManager.shared.publicCode.isEmpty == false && ShareManager.shared.getServerURL().isEmpty == false )
        {
            ShareManager.shared.initShareManager()
        }
        else
        {
            DataManager.shared.loadGroceryHistory()
            DataManager.shared.loadGrocery()
            DataManager.shared.loadCartGrocery()
             
            // link groceries and groceryHistories
            for grocery in DataManager.shared.getGroceries().reversed()
            {
                if let info = DataManager.shared.getGroceryHistory(title: grocery.info.title, category: grocery.info.category)
                {
                    grocery.info = info
                }
                else
                {
                    grocery.info = DataManager.nilGroceryHistory
                }
            }
            
            // link cartGroceries and groceryHistories
            for cartGrocery in DataManager.shared.getCartGroceries().reversed()
            {
                if let info = DataManager.shared.getGroceryHistory(title: cartGrocery.info.title, category: cartGrocery.info.category)
                {
                    cartGrocery.info = info
                }
                else
                {
                    cartGrocery.info = DataManager.nilGroceryHistory
                }
            }
        }
        
        defaultNames = getDefaultNames()
        
        if(UserDefaults.isFirstLaunch())
        {
            UserDefaults.standard.set(isFridgeCategoryButtonOn, forKey: "isFridgeCategoryButtonOn")
            UserDefaults.standard.set(isFridgeFrigerationButtonOn, forKey: "isFridgeFrigerationButtonOn")
            UserDefaults.standard.set(isFridgeFreezingButtonOn, forKey: "isFridgeFreezingButtonOn")
            UserDefaults.standard.set(isFridgeOutdoorButtonOn, forKey: "isFridgeOutdoorButtonOn")
            UserDefaults.standard.set(isFridgeAlarmButtonOn, forKey: "isFridgeAlarmButtonOn")
            
            UserDefaults.standard.set(isPurchaseRecordCategorySortButtonOn, forKey: "isPurchaseRecordCategorySortButtonOn")
            UserDefaults.standard.set(isPurchaseRecordFavoriteSortButtonOn, forKey: "isPurchaseRecordFavoriteSortButtonOn")
            UserDefaults.standard.set(isPurchaseRecordRecentSortButtonOn, forKey: "isPurchaseRecordRecentSortButtonOn")
            
            UserDefaults.standard.set(isShopingCartCategoryButtonOn, forKey: "isShopingCartCategoryButtonOn")
            UserDefaults.standard.set(isShopingCartLatestButtonOn, forKey: "isShopingCartLatestButtonOn")
            
            UserDefaults.standard.set(selectedFridgeIndex, forKey: "selectedFridgeIndex")
        }
        else
        {
            isFridgeCategoryButtonOn = UserDefaults.standard.bool(forKey: "isFridgeCategoryButtonOn")
            isFridgeFrigerationButtonOn = UserDefaults.standard.bool(forKey: "isFridgeFrigerationButtonOn")
            isFridgeFreezingButtonOn = UserDefaults.standard.bool(forKey: "isFridgeFreezingButtonOn")
            isFridgeOutdoorButtonOn = UserDefaults.standard.bool(forKey: "isFridgeOutdoorButtonOn")
            isFridgeAlarmButtonOn = UserDefaults.standard.bool(forKey: "isFridgeAlarmButtonOn")
            
            isPurchaseRecordCategorySortButtonOn = UserDefaults.standard.bool(forKey: "isPurchaseRecordCategorySortButtonOn")
            isPurchaseRecordFavoriteSortButtonOn = UserDefaults.standard.bool(forKey: "isPurchaseRecordFavoriteSortButtonOn")
            isPurchaseRecordRecentSortButtonOn = UserDefaults.standard.bool(forKey: "isPurchaseRecordRecentSortButtonOn")
            
            isShopingCartCategoryButtonOn = UserDefaults.standard.bool(forKey: "isShopingCartCategoryButtonOn")
            isShopingCartLatestButtonOn = UserDefaults.standard.bool(forKey: "isShopingCartLatestButtonOn")
            selectedFridgeIndex = UserDefaults.standard.array(forKey: "selectedFridgeIndex") as? [Int] ?? [0,1,2,3]
        }
        
        
        
        // read barcode data
        let filename = "BarcodeData"
        if let fileURL = Bundle.main.url(forResource: filename, withExtension: "csv")
        {
            //print(fileURL)
            
            let rows = NSArray(contentsOfCSVURL: fileURL, options: CHCSVParserOptions.sanitizesFields)!

            for row in rows
            {
                   
               let rowArray = row as! NSArray
               var barcode1 = rowArray[0] as! String
               var barcode2 = rowArray[1] as! String
               var name = rowArray[2] as! String
               var image1 = rowArray[3] as! String
               var image2 = rowArray[4] as! String
               var image3 = rowArray[5] as! String
               var image4 = rowArray[6] as! String
               
               
               barcode1 = String(barcode1.utf8)
               //print(barcode1)
               barcode2 = String(barcode2.utf8)
               //print(barcode2)
               name = String(name.utf8)
               //print(name)
               image1 = String(image1.utf8)
               //print(image1)
               image2 = String(image2.utf8)
               //print(image2)
               image3 = String(image3.utf8)
               //print(image3)
               image4 = String(image4.utf8)
               //print(image4)
               
               let newBarcodeData = BarcodeData(barcode1, barcode2, name, image1, image2, image3, image4)
               barcodeData.insert(newBarcodeData, at: barcodeData.count)
            }
        }
        
        
        
        
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        center.delegate = self // Don't forgot to set delegate

        //To get permissions from user:
        let options: UNAuthorizationOptions = [.alert, .sound, .badge];
        center.requestAuthorization(options: options)
        {
            (granted, error) in
//            if granted
//            {
//                self.grantedAuthorization = granted
////
////                {
////                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
////
////
////                }
//            }
        }
        
        return true
    }
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // EZAlertController.alert("you have new meeting ")

        completionHandler( [.badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }

    @objc func updateCounting()
    {
        guard ShareManager.shared.startUpdateCounting == true else { return }
        NSLog("counting..")
        
        // 일정초마다.. 서버로부터 전부 받아서 update
        ShareManager.shared.updateAllProduct()
        {
            getRequestManager().updatePurchaseRecordViewController(updateTableView: getRequestManager().isUpdatePurchaseRecord)
            getRequestManager().updateShopingCartViewController(updateTableView: getRequestManager().isUpdateShopingCart)
            getRequestManager().updateGroceryListViewController(updateTableView: getRequestManager().isUpdateGroceryList)
        }
        ShareManager.shared.updateAllCartItem()
        {
            getRequestManager().updateShopingCartViewController(updateTableView: getRequestManager().isUpdateShopingCart)
        }
        ShareManager.shared.updateAllRefrigeratorItem()
        {
            getRequestManager().updateGroceryListViewController(updateTableView: getRequestManager().isUpdateGroceryList)
        }
    }
    
    

}

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
