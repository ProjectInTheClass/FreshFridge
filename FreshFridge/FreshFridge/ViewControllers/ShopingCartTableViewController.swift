//
//  ShopingCartTableViewController.swift
//  FreshFridge
//
//  Created by Park Youngeun on 2021/01/20.
//



import UIKit

class ShopingCartTableViewController: UITableViewController, ShopingCartCellDelegate{
    
    

    //상품추가 씬으로 전환 코드
    
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var latestButton: UIButton!
    @IBOutlet weak var toFridgeButton: UIButton!
    @IBOutlet weak var allCheckMarkButton: UIButton!
    
    var numberOfSections: Int = 0
    var sectionNames: [String] = []
    var numbersOfRowInSection: [Int] = []
    
    var isAllCheckMarkButtonOn = false
    
    // 최신순 또는 가나다 순으로 정렬된 어레이
    var sortedArray: [CartGrocery] = []

    // 최종 테이블 뷰는 필터드그로서리즈로 만든다. 카네고리별로 분류 될수 있다.
    var filteredCartGroceries: [[CartGrocery]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRequestManager().shopingCartViewController = self
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        sortedArray = DataManager.shared.getCartGroceries()
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
        categoryButton.switchOnOff(isOn: isShopingCartCategoryButtonOn)
        latestButton.switchOnOff(isOn: isShopingCartLatestButtonOn)
    }
    
    
    func updateTableView() {
        numberOfSections = 0
        numbersOfRowInSection.removeAll()
        filteredCartGroceries.removeAll()
        sectionNames.removeAll()
        
        // 최신순 버튼이 켜져 있으면 CartGrocery 어레이를 그대로 담는다. 기본 어레이는 사용자가 추가한 순서대로 어팬드 되니까 어짜피 최신순 일 것이다.
        if isShopingCartLatestButtonOn == true {
            sortedArray = DataManager.shared.getCartGroceries()
        }
        // 최신순 버튼이 꺼져 있으면 타이틀의 가나다 순으로 정렬해서 다음 어레이에 담는다.
       else {
        sortedArray = DataManager.shared.getCartGroceries().sorted { $0.info.title < $1.info.title }
            
        }
        // 분류별 버튼이 켜져 있으면 테이블 뷰를 섹션으로 나누어서 카테고리별로 정렬한다.
        if isShopingCartCategoryButtonOn == true {
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
                sectionNames.append(category.description) 
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
            
            RequestManager.shared.getRequestInterface().updateCartGrocery(id: checkGrocery.id, isPurchased: !checkGrocery.isPurchased)
        }
       
        //tableView.reloadData()
        
        
        //
        if(isAllCheckMarkButtonOn)
        {
            isAllCheckMarkButtonOn.toggle()
            updateAllCheckMarkButton()
        }
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
                
                //grocery.count = count
                RequestManager.shared.getRequestInterface().updateCartGrocery(id: grocery.id, count: count)
            }
         
            sender.countTextField.updatePieChart(count: grocery.count, isPercentage: grocery.isPercentageCount)
        }
    }
    
    func updateAllCheckMarkButton()
    {
        if(isAllCheckMarkButtonOn)
        {
            //allCheckMarkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            allCheckMarkButton.setImage(UIImage(named: "check_fill"), for: .normal)
        }
        else
        {
            //allCheckMarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            allCheckMarkButton.setImage(UIImage(named: "check"), for: .normal)
        }
    }
    
    @IBAction func allCheckButtonTapped(_ sender: Any)
    {
        isAllCheckMarkButtonOn.toggle()
        updateAllCheckMarkButton()
        
        for cartGrocery in DataManager.shared.getCartGroceries()
        {
            RequestManager.shared.getRequestInterface().updateCartGrocery(id: cartGrocery.id, isPurchased: isAllCheckMarkButtonOn)
        }
        
        //tableView.reloadData()
    }
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        isShopingCartCategoryButtonOn = !isShopingCartCategoryButtonOn
        UserDefaults.standard.set(isShopingCartCategoryButtonOn, forKey: "isShopingCartCategoryButtonOn")
        
        updateButtons()
        updateTableView()
        tableView.reloadData()
    }
    
    @IBAction func RecentSortButtonTapped(_ sender: UIButton) {
        isShopingCartLatestButtonOn = !isShopingCartLatestButtonOn
        UserDefaults.standard.set(isShopingCartLatestButtonOn, forKey: "isShopingCartLatestButtonOn")
        
        updateButtons()
        updateTableView()
        tableView.reloadData()
    }
  
    @IBAction func ToFridgeButtonTapped(_ sender: UIButton) {
        
        //var isMoved = false
        for cartGrocery in DataManager.shared.getCartGroceries().reversed()
        {
            if(cartGrocery.isPurchased)
            {
                //isMoved = true
                
                //DataManager.shared.insertGrocery(title: cartGrocery.info.title, category: cartGrocery.info.category, count: 1, isPercentageCount: false, dueDate: DueDate(4), storage: Grocery.Storage.Refrigeration, fridgeName: selectedfrideName, notes: "", image: nil)
                RequestManager.shared.getRequestInterface().addGrocery(title: cartGrocery.info.title, category: cartGrocery.info.category, count: 1, isPercentageCount: false, dueDate: DueDate(4), storage: Grocery.Storage.Refrigeration, fridgeName: selectedfrideName, notes: "", image: nil)
                
                RequestManager.shared.getRequestInterface().removeCartGrocery(id: cartGrocery.id)
                
                
            }
        }
        
//        if(isMoved)
//        {
//            updateTableView()
//            tableView.reloadData()
//            getRequestManager().animateBadge(tabBarIndex: .fridgeTabBar)
//        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {
        let modifyAction = UIContextualAction(style: .destructive, title:  "Trash", handler:
            { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             
                print("Trash action ...")
                
                let cartGrocery = filteredCartGroceries[indexPath.section][indexPath.row]
                RequestManager.shared.getRequestInterface().removeCartGrocery(id: cartGrocery.id)
                
//                updateTableView()
//                tableView.reloadData()
            
                success(true)
         })
        
         modifyAction.image = UIImage(systemName: "trash")
         modifyAction.backgroundColor = .red
     
         return UISwipeActionsConfiguration(actions: [modifyAction])
     }
    
    func selectedCell()
    {
        performSegue(withIdentifier: "EditShoppingCart", sender: self)
    }
    
    @IBAction func unwindToShopingCart(_ unwindSegue: UIStoryboardSegue)
    {
        
        // Use data from the view controller which initiated the unwind segue
        if(unwindSegue.identifier == "UnwindShopingCartFromAddGrocery")
        {
            if let sourceViewController = unwindSegue.source as? AddGroceryTableViewController
            {
                
                // 장바구니에 추가하는 경우
                let title = sourceViewController.nameTextField.text ?? ""
                var category : GroceryHistory.Category
                if(sourceViewController.category == nil)
                {
                    category = GroceryHistory.Category.ETC
                }
                else
                {
                    category = sourceViewController.category!
                }
                
                let count = sourceViewController.count
                let isPercentageCount = sourceViewController.percentageSwitch.isOn
                let image = sourceViewController.groceryImage
                
                //var bUpdateTableView = false
                if(sourceViewController.cartGrocery == nil)
                {
                    // adding
                    if(title.isEmpty == false)
                    {
                        RequestManager.shared.getRequestInterface().addCartGrocery(title: title, category: category, image: image, count: count, isPercentageCount: isPercentageCount)
                        
                        //bUpdateTableView = true
                    }
                }
                else
                {
                    // 장바구니 상세 페이지에서 수정한 경우
                    if let cartGrocery = sourceViewController.cartGrocery
                    {
                        if(cartGrocery.info.title != title)
                        {
                            RequestManager.shared.getRequestInterface().updateGroceryHistory(id: cartGrocery.info.id, title: title)
                        }
                        if(cartGrocery.info.category != category)
                        {
                            //cartGrocery.info.category = category
                            RequestManager.shared.getRequestInterface().updateGroceryHistory(id: cartGrocery.info.id, category: category)
                            //bUpdateTableView = true
                        }
                        if(cartGrocery.count != count)
                        {
                            RequestManager.shared.getRequestInterface().updateCartGrocery(id: cartGrocery.id, count: count)
                        }
                        if(cartGrocery.isPercentageCount != isPercentageCount)
                        {
                            RequestManager.shared.getRequestInterface().updateCartGrocery(id: cartGrocery.id, isPercentage: isPercentageCount)
                        }
                        if((cartGrocery.info.image === image) == false && image != nil)
                        {
                            RequestManager.shared.getRequestInterface().updateGroceryHistory(id: cartGrocery.info.id, image: image!)
                        }
                    }
                }
                
//                if(bUpdateTableView)
//                {
//                    updateTableView()
//                }
//                tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddShoppingCart" || segue.identifier == "EditShoppingCart"
        {
            let navigationController = segue.destination as! UINavigationController
            let addGroceryTableViewController = navigationController.topViewController as! AddGroceryTableViewController
            addGroceryTableViewController.isFromShoppingCart = true
            
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let cartGrocery = filteredCartGroceries[indexPath.section][indexPath.row]
                addGroceryTableViewController.cartGrocery = cartGrocery
            }
        }
    }
}

