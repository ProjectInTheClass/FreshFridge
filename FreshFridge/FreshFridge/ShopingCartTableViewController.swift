//
//  ShopingCartTableViewController.swift
//  FreshFridge
//
//  Created by Park Youngeun on 2021/01/20.
//
// var cartGroceries = [CartGrocery]()


import UIKit

class ShopingCartTableViewController: UITableViewController, ShopingCartCellDelegate{
    
    

    //상품추가 씬으로 전환 코드
    
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var latestButton: UIButton!
    var fridgeTabBarController: FridgeTabBarController!
    
    var numberOfSections: Int = 0
    var sectionNames: [String] = []
    var numbersOfRowInSection: [Int] = []
    
    
    //처음에는 아래 기본값이지만 차후에 사용자가 바꿀수 있고 바뀐 그 값은 저장되어 있어야 한다.
    
    var categoryButtonOn = false
    var latestButtonOn = true
    
    
    // 최신순 또는 가나다 순으로 정렬된 어레이
    var sortedArray: [CartGrocery] = []

    // 최종 테이블 뷰는 필터드그로서리즈로 만든다. 카네고리별로 분류 될수 있다.
    var filteredCartGroceries: [[CartGrocery]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fridgeTabBarController = tabBarController as? FridgeTabBarController
        
        sortedArray = cartGroceries
        updateButtons() 
        updateTableView()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false // for selecting the rows, didSelectRowAtIndex path could not be fired until pressed long.
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView()
        tableView.reloadData()
    }

    func updateButtons() {
        categoryButton.switchOnOff(isOn: categoryButtonOn)
        latestButton.switchOnOff(isOn: latestButtonOn)
    }
    
    
    func updateTableView() {
        numberOfSections = 0
        numbersOfRowInSection.removeAll()
        filteredCartGroceries.removeAll()
        sectionNames.removeAll()
        
        // 최신순 버튼이 켜져 있으면 CartGrocery 어레이를 그대로 담는다. 기본 어레이는 사용자가 추가한 순서대로 어팬드 되니까 어짜피 최신순 일 것이다.
        if latestButtonOn == true {
            sortedArray = cartGroceries
        }
        // 최신순 버튼이 꺼져 있으면 타이틀의 가나다 순으로 정렬해서 다음 어레이에 담는다.
       else {
        sortedArray = cartGroceries.sorted { $0.info.title < $1.info.title }
            
        }
        // 분류별 버튼이 켜져 있으면 테이블 뷰를 섹션으로 나누어서 카테고리별로 정렬한다.
        if categoryButtonOn == true {
        for category in GroceryHistory.Category.allCases {
            var sectionGroceries: [CartGrocery] = []
            for grocery in sortedArray {
                if grocery.info.category == category {
                    sectionGroceries.append(grocery)
                }
            }
            if sectionGroceries.count > 0 {
                numbersOfRowInSection.append(sectionGroceries.count) // 몇개 담겨있는지 세서 Row 갯수를 정한다.
                numberOfSections += 1 // 섹션은 0에서 하나씩 추가된다.
                filteredCartGroceries.append(sectionGroceries) //
                sectionNames.append(category.rawValue) // rawValue 는 enum Category의 case 뒤에 붙은 "스트링" 값을 가져다준다.
            }
        }
    }
        else {  // 분류별이 아니면 섹션 나누지 않고 그대로 진행한다.
        numbersOfRowInSection.append(sortedArray.count)
        numberOfSections = 1
        filteredCartGroceries.append(sortedArray)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cellContents = filteredCartGroceries[indexPath.section][indexPath.row]
        if(cellContents.info.image == nil)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopingCartCell", for: indexPath) as! ShopingCartTableViewCell
            cell.updateCell(with: cellContents)
            cell.delegate = self
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopingCartPictureCell", for: indexPath) as! ShopingCartTableViewPictureCell
            cell.updateCell(with: cellContents)
            cell.delegate = self
            return cell
        }
    }

// 장바구니 체크 박스 누르면 반응
    func checkCartTapped(sender: ShopingCartTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            let checkGrocery = filteredCartGroceries[indexPath.section][indexPath.row]
            checkGrocery.isPurchased = !checkGrocery.isPurchased
        }
        updateTableView()
        tableView.reloadData()
    }
    
    func countButtonTapped(sender: ShopingCartTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender)
        {
            let grocery = filteredCartGroceries[indexPath.section][indexPath.row]
            if var count = Int(sender.countTextField.text ?? "")
            {
                
                
                if(grocery.isPercentageCount)
                {
                    if(count < 0)
                    {
                        count = 0
                    }
                    if(count > 100)
                    {
                        count = 100
                    }
                }
                else
                {
                    if(count < 0)
                    {
                        count = 0
                    }
                }
                
                grocery.count = count
                
            }
         
            sender.countTextField.updatePieChart(count: grocery.count, isPercentage: grocery.isPercentageCount)
        }
    }
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        categoryButtonOn = !categoryButtonOn
        updateButtons()
        updateTableView()
        tableView.reloadData()
    }
    
    
    
    
    
    @IBAction func RecentSortButtonTapped(_ sender: UIButton) {
        latestButtonOn = !latestButtonOn
        updateButtons()
        updateTableView()
        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {
        let modifyAction = UIContextualAction(style: .destructive, title:  "Trash", handler:
            { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             
                print("Trash action ...")
                
                let selectedGrocery = filteredCartGroceries[indexPath.section][indexPath.row]
                
                if let selectedIndex = findGroceryIndex(grocery: selectedGrocery)
                {
                    cartGroceries.remove(at: selectedIndex.offset)
                    updateTableView()
                    tableView.reloadData()
                    
                    CartGrocery.saveCartGrocery(cartGroceries)
                }
            
                success(true)
         })
        
         modifyAction.image = UIImage(systemName: "trash")
         modifyAction.backgroundColor = .red
     
         return UISwipeActionsConfiguration(actions: [modifyAction])
     }
    
    @IBAction func unwindToShopingCart(_ unwindSegue: UIStoryboardSegue)
    {
        
        // Use data from the view controller which initiated the unwind segue
        if(unwindSegue.identifier == "UnwindShopingCartFromAddGrocery")
        {
            if let sourceViewController = unwindSegue.source as? AddGroceryTableViewController
            {
                let title = sourceViewController.nameTextField.text ?? ""
                let category = GroceryHistory.Category(rawValue: sourceViewController.categoryButton.title(for: .normal) ?? "")!
                let count = sourceViewController.count
                let isPercentageCount = sourceViewController.percentageSwitch.isOn
                let image = sourceViewController.groceryImage
                
                // adding
                if(title.isEmpty == false)
                {
                    let newCartGrocery = CartGrocery(info: getGroceryHistory(title: title, category: category, updateDate: true))
                    newCartGrocery.info.image = image
                    newCartGrocery.count = count
                    newCartGrocery.isPercentageCount = isPercentageCount
                    cartGroceries.insert(newCartGrocery, at: 0)
                    
                    updateTableView()
                    tableView.reloadData()
                    
                    GroceryHistory.saveGroceryHistory(groceryHistories)
                    CartGrocery.saveCartGrocery(cartGroceries)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddShoppingCart"
        {
            let navigationController = segue.destination as! UINavigationController
            let addGroceryTableViewController = navigationController.topViewController as! AddGroceryTableViewController
            addGroceryTableViewController.isFromShoppingCart = true
        }
    }
}

