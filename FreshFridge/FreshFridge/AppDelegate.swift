//
//  AppDelegate.swift
//  FreshFridge
//
//  Created by changae choi on 2021/01/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var grantedAuthorization: Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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
        
        // 테스트용 sample date loading
        /*
        groceryHistories = GroceryHistory.loadSampleGroceryHistory()
        groceries = Grocery.loadSampleGrocery()
        cartGroceries = CartGrocery.loadSampleCartGrocery()
        */
        
        let langStr = Locale.current.languageCode
        if let savedGroceryHistories = GroceryHistory.loadGroceryHistory()
        {
            groceryHistories = savedGroceryHistories
        }
        else
        {
            if(langStr == "ko")
            {
                groceryHistories = GroceryHistory.loadSampleGroceryHistory()
            }
        }
        
        if let savedGroceries = Grocery.loadGrocery()
        {
            groceries = savedGroceries
        }
        else
        {
            if(langStr == "ko")
            {
                groceries = Grocery.loadSampleGrocery()
            }
        }
         
         if let savedCartGroceries = CartGrocery.loadCartGrocery()
         {
             cartGroceries = savedCartGroceries
         }
         else
         {
            if(langStr == "ko")
            {
                cartGroceries = CartGrocery.loadSampleCartGrocery()
            }
         }
         
        
        // link groceries and groceryHistories
        for grocery in groceries.reversed()
        {
            grocery.info = GroceryHistory.getGroceryHistory(title: grocery.info.title, category: grocery.info.category, updateDate: false)
        }
        
        // link cartGroceries and groceryHistories
        for cartGrocery in cartGroceries.reversed()
        {
            cartGrocery.info = GroceryHistory.getGroceryHistory(title: cartGrocery.info.title, category: cartGrocery.info.category, updateDate: false)
        }
        
        
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        center.delegate = self // Don't forgot to set delegate

        //To get permissions from user:
        let options: UNAuthorizationOptions = [.alert, .sound, .badge];
        center.requestAuthorization(options: options)
        {
            (granted, error) in
            if granted
            {
                self.grantedAuthorization = granted
//
//                {
//                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//
//
//                }
            }
        }
        
        return true
    }
    
    func setAlarm(grocery : Grocery)
    {
        let expiration = grocery.dueDate.getExpiration()
       
        if(expiration <= -2)
        {
            let n = -2
            let content = UNMutableNotificationContent()
            content.title = "기간 만료 알림".localized()
            content.body = "%@의 보관 기간이 %@일 남았습니다.".localized(with: [grocery.info.title, -n])//"\(grocery.info.title)의 보관 기간이 \(-n)일 남았습니다."
            content.categoryIdentifier = "alarm"
            content.sound = .default
            
            let nextTriggerDate = Calendar.current.date(byAdding: .day, value: n, to: grocery.dueDate.date)!
            let comps = Calendar.current.dateComponents([.year, .month, .day], from: nextTriggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
        
        if(expiration <= -1)
        {
            let n = -1
            let content = UNMutableNotificationContent()
            content.title = "기간 만료 알림".localized()
            content.body = "%@의 보관 기간이 %@일 남았습니다.".localized(with: [grocery.info.title, -n])//"\(grocery.info.title)의 보관 기간이 \(-n)일 남았습니다."
            content.categoryIdentifier = "alarm"
            content.sound = .default
            
            let nextTriggerDate = Calendar.current.date(byAdding: .day, value: n, to: grocery.dueDate.date)!
            let comps = Calendar.current.dateComponents([.year, .month, .day], from: nextTriggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
        
        if(expiration < 3)
        {
            //let n = -1
            let content = UNMutableNotificationContent()
            content.title = "기간 만료 알림".localized()
            //content.body = "\(grocery.info.title)의 보관 기간이 만료되었습니다.."
            content.body = "%@의 보관 기간이 만료되었습니다.".localized(with: [grocery.info.title])//"\(grocery.info.title)의 보관 기간이 \(-n)일 남았습니다."
            content.categoryIdentifier = "alarm"
            content.sound = .default
            
            for n in 0...2
            {
                let nextTriggerDate = Calendar.current.date(byAdding: .day, value: n, to: grocery.dueDate.date)!
                let comps = Calendar.current.dateComponents([.year, .month, .day], from: nextTriggerDate)
                let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
    func resetAllAlarms()
    {
        guard  self.grantedAuthorization == true else { return }
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        for grocery in groceries
        {
            setAlarm(grocery: grocery)
        }
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
