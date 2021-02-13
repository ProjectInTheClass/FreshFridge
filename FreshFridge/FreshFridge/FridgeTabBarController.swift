//
//  FridgeTabBarController.swift
//  FreshFridge
//
//  Created by changae choi on 2021/01/27.
//

import UIKit

enum TabBarIndex : Int {
    case fridgeTabBar = 0
    case purchaseTabBar = 1
    case shopingCartTabBar = 2
    case familyShareTabBar = 3
}

class FridgeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func animateBadge(tabBarIndex: TabBarIndex)
    {
        UIView.animate(withDuration: 1.2, animations: {
            let tabBarItem: UITabBarItem = (self.viewControllers?[tabBarIndex.rawValue].tabBarItem)!
            
            
            switch tabBarIndex
            {
            case .fridgeTabBar:
                tabBarItem.badgeColor = UIColor.systemBlue
                tabBarItem.badgeValue = "+\(groceries.count)"
            case .purchaseTabBar:
                tabBarItem.badgeColor = UIColor.systemGray5
                tabBarItem.badgeValue = "+\(groceryHistories.count)"
            case .shopingCartTabBar:
                tabBarItem.badgeColor = UIColor.systemGreen
                tabBarItem.badgeValue = "+\(cartGroceries.count)"
            case .familyShareTabBar:
                tabBarItem.badgeColor = UIColor.systemGray5
            }
            
        })
        {_ in
            let tabBarItem: UITabBarItem = (self.viewControllers?[tabBarIndex.rawValue].tabBarItem)!
            tabBarItem.badgeValue = nil
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
