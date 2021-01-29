//
//  PurchaseRecordTableViewController.swift
//  FreshFridge
//
//  Created by iM27 on 2021/01/19.
//

import UIKit


class PurchaseRecordTableViewController: UITableViewController, UISearchBarDelegate, PurchaseRecordCellDelegate  {

    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var CategorySortButton: UIButton!
    @IBOutlet weak var FavoriteSortButton: UIButton!
    @IBOutlet weak var RecentSortButton: UIButton!
    
    var fridgeTabBarController: FridgeTabBarController!
    
    var numberOfSections: Int = 0
    var sectionNames: [String] = []
    var numbersOfRowInSection: [Int] = []
        
    
    
    // 서치바를 위한 어레이
    var searchbarGroceries: [GroceryHistory] = groceryHistories
    
    // 최신순 또는 가나다 순으로 정렬된 어레이
    var sortedArray: [GroceryHistory] = []
        
    // 즐겨찾기가 상단에 위치하도록 먼저 걸러거나 아니거나 한 어레이
    var purchaseRecordTableViewArray: [GroceryHistory] = []
    
    // 최종 테이블 뷰는 필터드그로서리즈로 만든다. 카네고리별로 분류 될수 있다.
    var filteredGroceries: [[GroceryHistory]] = []
    

//    var favoriteFirstArray: [GroceryHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchBar.delegate = self
        
        fridgeTabBarController = tabBarController as? FridgeTabBarController
        
        searchbarGroceries = groceryHistories

        updateButtons()
        updateTableView(groceryHistoryArray: groceryHistories)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView(groceryHistoryArray: groceryHistories)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        if searchText == "" {
            searchbarGroceries = groceryHistories
        } else {
            searchbarGroceries = groceryHistories.filter { $0.title.contains(searchText)}
            }
        updateTableView(groceryHistoryArray: searchbarGroceries)
        self.tableView.reloadData()
    }
 
    
    func updateButtons() {
        CategorySortButton.switchOnOff(isOn: isPurchaseRecordCategorySortButtonOn)
        FavoriteSortButton.switchOnOff(isOn: isPurchaseRecordFavoriteSortButtonOn)
        RecentSortButton.switchOnOff(isOn: isPurchaseRecordRecentSortButtonOn)
    }
    
    
    func updateTableView( groceryHistoryArray: [GroceryHistory]) {
        numberOfSections = 0
        numbersOfRowInSection.removeAll()
        sortedArray.removeAll()
        purchaseRecordTableViewArray.removeAll()
        filteredGroceries.removeAll()
        sectionNames.removeAll()
        
        // 최신순 버튼이 켜져 있으면 서치바에서 넘어온 어레이를 그대로 담는다. 기본 어레이는 사용자가 추가한 순서대로 인서트 at:0 되니까 어짜피 최신순 일 것이다.
        if isPurchaseRecordRecentSortButtonOn == true {
            sortedArray = groceryHistoryArray.sorted { $0.lastestPurchaseDate > $1.lastestPurchaseDate }
        }
        // 최신순 버튼이 꺼져 있으면 타이틀의 가나다 순으로 정렬해서 다음 어레이에 담는다.
        else {
            sortedArray = groceryHistoryArray.sorted { $0.title < $1.title }
        }
        
        
        // 즐겨찾기 버튼이 켜져 있으면 어레이 값 중에서 즐겨찾기 값이 참인 것 먼저 상단에 위치하도록 정렬한다.
        if isPurchaseRecordFavoriteSortButtonOn == true {
            let favoriteGroceries = sortedArray.filter { $0.favorite == true }
            purchaseRecordTableViewArray.append(contentsOf: favoriteGroceries)
            let notFavoriteGroceries = sortedArray.filter { $0.favorite == false }
            purchaseRecordTableViewArray.append(contentsOf: notFavoriteGroceries)
        }
        // 즐겨찾기 버튼이 꺼져 있으면 그냥 다음 어레이에 그대로 담는다.
        else {
            purchaseRecordTableViewArray = sortedArray
        }
         
        
        // 분류별 버튼이 켜져 있으면 테이블 뷰를 섹션으로 나누어서 카테고리별로 정렬한다.
        if isPurchaseRecordCategorySortButtonOn == true {
        for category in GroceryHistory.Category.allCases {
            var sectionGroceries: [GroceryHistory] = []
            for grocery in purchaseRecordTableViewArray {
                if grocery.category == category {
                    sectionGroceries.append(grocery)
                }
            }
            if sectionGroceries.count > 0 {
                numbersOfRowInSection.append(sectionGroceries.count) // 몇개 담겨있는지 세서 Row 갯수를 정한다.
                numberOfSections += 1 // 섹션은 0에서 하나씩 추가된다.
                filteredGroceries.append(sectionGroceries) //
                sectionNames.append(category.rawValue) // rawValue 는 enum Category의 case 뒤에 붙은 "스트링" 값을 가져다준다.
                }
            }
        } else {  // 분류별이 아니면 섹션 나누지 않고 그대로 진행한다.
            numbersOfRowInSection.append(purchaseRecordTableViewArray.count)
            numberOfSections = 1
            filteredGroceries.append(purchaseRecordTableViewArray)
            sectionNames.append("")
            }
    }


    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numbersOfRowInSection[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }

    // 테이블뷰 cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseRecordCell", for: indexPath) as! PurchaseRecordTableViewCell
        
        var cell: PurchaseRecordTableViewCell! = nil
        let cellContents = filteredGroceries[indexPath.section][indexPath.row]
         
        if cellContents.image == nil
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseRecordCell", for: indexPath) as? PurchaseRecordTableViewCell
            
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseRecordWithPictureCell", for: indexPath) as? PurchaseRecordWithPictureTableViewCell
            let pictureCell = cell as? PurchaseRecordWithPictureTableViewCell
            pictureCell?.titleImage.image = cellContents.image?.image()
            
        }

        
        cell.updateCell(with: cellContents)
        cell.delegate = self
        
        return cell
    }
    
    
    
    // 셀의 왼쪽에서 오른쪽으로 스와이프 했을 때 카트로 보내는 이밴트
    override func tableView(_ tableView: UITableView,
                    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let toCartAction = UIContextualAction(style: .destructive, title:  "Cart", handler:
        { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let selectedGrocery = filteredGroceries[indexPath.section][indexPath.row]
            let cartGrocery = CartGrocery(info: GroceryHistory.getGroceryHistory(title: selectedGrocery.title, category: selectedGrocery.category, updateDate: true))
            
            cartGroceries.insert(cartGrocery, at: 0)
            CartGrocery.saveCartGrocery(cartGroceries)
            fridgeTabBarController.animateBadge(tabBarIndex: .shopingCartTabBar)
            
            success(true)
        })
        
        toCartAction.image = UIImage(systemName: "cart")
        toCartAction.backgroundColor = .systemGreen
     
        return UISwipeActionsConfiguration(actions: [toCartAction])
     }
    
    // 셀을 오른쪽에서 왼쪽으로 스와이프 했을 때 냉장고로 보내는 이밴트
    override func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let selectedGrocery = filteredGroceries[indexPath.section][indexPath.row]
        let modifyAction = UIContextualAction(style: .destructive, title:  "Trash", handler:
            { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
                
                
                if let selectedIndex = findGroceryHistoryIndex(groceryHistory: selectedGrocery) {
                    // print(selectedIndex)
                    
                    groceryHistories.remove(at: selectedIndex.offset)
                    updateTableView(groceryHistoryArray: groceryHistories)
                    tableView.reloadData() // cellForRowAt 을 호출
                    GroceryHistory.saveGroceryHistory(groceryHistories) // 로컬에 저장하기
                }
                
                success(true)
         })
        
         modifyAction.image = UIImage(systemName: "trash")
         modifyAction.backgroundColor = .red
        
        
        let toFridgeAction = UIContextualAction(style: .destructive, title:  "Fridge", handler:
            { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                
                
                
                let selectedGrocery = filteredGroceries[indexPath.section][indexPath.row]
                
                print(selectedGrocery)
                
                let groceryHistory = GroceryHistory.getGroceryHistory(title: selectedGrocery.title, category: selectedGrocery.category, updateDate: true)
                let fridgeGrocery = Grocery(info: groceryHistory, count: 1, isPercentageCount: false, dueDate: DueDate(4), storage: Grocery.Storage.Refrigeration, fridgeName:  selectedfrideName, notes: "")
                
                //        GroceryHistory(title: "바나나우유", category: .DrinksAndSnacks, favorite: false, lastestPurchaseDate: Date(), image: GroceryImage(image: UIImage(named: "dumyPicture1")))
                
                
                print(fridgeGrocery)
                
                groceries.insert(fridgeGrocery, at: 0)
                (UIApplication.shared.delegate as! AppDelegate).setAlarm(grocery: fridgeGrocery)
                Grocery.saveGrocery(groceries)
                
                fridgeTabBarController.animateBadge(tabBarIndex: .fridgeTabBar)
                
                success(true)
         })
        
        toFridgeAction.image = UIImage(named: "freshFridge_icon")?.withTintColor( .white)
        toFridgeAction.backgroundColor = .systemBlue
     
        if(isExistGrocery(title: selectedGrocery.title, category: selectedGrocery.category) == false
            && isExistCartGrocery(title: selectedGrocery.title, category: selectedGrocery.category) == false)
        {
            return UISwipeActionsConfiguration(actions: [modifyAction, toFridgeAction])
        }
        else
        {
            return UISwipeActionsConfiguration(actions: [toFridgeAction])
        }
     }
   
    // 즐겨찾기 별표 버튼을 누르면 반응
    func fovoriteCheckMarkTapped(sender: PurchaseRecordTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            let thisGrocery = filteredGroceries[indexPath.section][indexPath.row]
            thisGrocery.favorite = !thisGrocery.favorite
            filteredGroceries[indexPath.section][indexPath.row] = thisGrocery
        }
        updateTableView(groceryHistoryArray: groceryHistories)
        tableView.reloadData()
        
        GroceryHistory.saveGroceryHistory(groceryHistories)
    }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func CategorySortButtonTapped(_ sender: UIButton) {
        isPurchaseRecordCategorySortButtonOn = !isPurchaseRecordCategorySortButtonOn
        UserDefaults.standard.set(isPurchaseRecordCategorySortButtonOn, forKey: "isPurchaseRecordCategorySortButtonOn")
        
        updateButtons()
        updateTableView(groceryHistoryArray: groceryHistories)
        tableView.reloadData()
    }
    
    @IBAction func FavoriteSortButtonTapped(_ sender: UIButton) {
        isPurchaseRecordFavoriteSortButtonOn = !isPurchaseRecordFavoriteSortButtonOn
        UserDefaults.standard.set(isPurchaseRecordFavoriteSortButtonOn, forKey: "isPurchaseRecordFavoriteSortButtonOn")
        
        updateButtons()
        updateTableView(groceryHistoryArray: groceryHistories)
        tableView.reloadData()
    }
    
    @IBAction func RecentSortButtonTapped(_ sender: UIButton) {
        isPurchaseRecordRecentSortButtonOn = !isPurchaseRecordRecentSortButtonOn
        UserDefaults.standard.set(isPurchaseRecordRecentSortButtonOn, forKey: "isPurchaseRecordRecentSortButtonOn")
        
        updateButtons()
        updateTableView(groceryHistoryArray: groceryHistories)
        tableView.reloadData()
    }
    
    
    
    
}
