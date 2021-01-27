//
//  GroceryListTableViewController.swift
//  GroceryListTableView
//
//  Created by changae choi on 2020/12/26.
//

import UIKit

class GroceryListTableViewController: UITableViewController, GroceryListCellDelegate, UITableViewDragDelegate, UITableViewDropDelegate
{
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var refrigerationButton: UIButton!
    @IBOutlet weak var freezingButton: UIButton!
    @IBOutlet weak var outdoorButton: UIButton!
    var fridgeTabBarController: FridgeTabBarController!
    
    var numberOfSections: Int = 0
    var sectionNames: [String] = []
    var numbersOfRowInSection: [Int] = []
    var filteredGroceries: [[Grocery]] = []
    
    //var filtersInFridgeView: [Bool] = [true, true, true]   // FridgeViewFilter순서
    var categoryButtonOn = false
    var refrigerationButtonOn = true
    var freezingButtonOn = true
    var outdoorButtonOn = true
    
    func isFridgeViewFilterSelected(_ filter: FridgeViewFilter) -> Bool
    {
        switch filter {
        case .Refrigeration:
            return refrigerationButtonOn
        case .Freezing:
            return freezingButtonOn
        case .Outdoor:
            return outdoorButtonOn
        }
    }
    
    func isFridgeViewCategorySelected() -> Bool
    {
        return categoryButtonOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        fridgeTabBarController = tabBarController as? FridgeTabBarController
        
        GroceryImage.viewSize = CGSize(width: view.frame.width, height: view.frame.height)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let savedGroceryHistories = GroceryHistory.loadGroceryHistory()
        {
            groceryHistories = savedGroceryHistories
        }
        else
        {
            groceryHistories = GroceryHistory.loadSampleGroceryHistory()
        }
        
        if let savedGroceries = Grocery.loadGrocery()
        {
            groceries = savedGroceries
        }
        else
        {
            groceries = Grocery.loadSampleGrocery()
        }
        
        // link groceries and groceryHistories
        for grocery in groceries
        {
            grocery.info = getGroceryHistory(title: grocery.info.title, category: grocery.info.category, updateDate: false)
        }
        
        if let savedCartGroceries = CartGrocery.loadCartGrocery()
        {
            cartGroceries = savedCartGroceries
        }
        else
        {
            cartGroceries = CartGrocery.loadSampleCartGrocery()
        }
        
        updateFilteringButtons()
        updateTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView()
        tableView.reloadData()
    }
    
    func updateFilteringButtons()
    {
        categoryButton.switchOnOff(isOn: categoryButtonOn)
        refrigerationButton.switchOnOff(isOn: refrigerationButtonOn)
        freezingButton.switchOnOff(isOn: freezingButtonOn)
        outdoorButton.switchOnOff(isOn: outdoorButtonOn)
    }
    
    func updateTableViewCell()
    {
        
    }
    
    func isEnableFridgeName(name: String) -> Bool
    {
        for index in 0...selectedFridgeIndex.count-1
        {
            if(name == fridgeNames[selectedFridgeIndex[index]])
            {
                return true
            }
        }
        
        return false
    }
    
    func updateTableView()
    {
        self.title = selectedfrideName
        
        numberOfSections = 0
        numbersOfRowInSection.removeAll()
        filteredGroceries.removeAll()
        sectionNames.removeAll()
        
        // 냉장, 냉동, 실외 선택으로 보여지는 groceries를 필터링해서 showGroceries에 추가한다.
        let showGroceries = groceries.filter
        {
            (((refrigerationButtonOn == true && $0.storage == .Refrigeration)
            || (freezingButtonOn == true && $0.storage == .Freezing)
            || (outdoorButtonOn == true && $0.storage == .Outdoor))
                && isEnableFridgeName(name: $0.fridgeName))
        }
        
        // 분류별이면 카테고리별로 섹터를 나누고 카테고리 순서로 filteredGroceries에 항목을 추가한다.
        if isFridgeViewCategorySelected()
        {
            for category in GroceryHistory.Category.allCases
            {
                var sectionGroceries: [Grocery] = []
                for grocery in showGroceries
                {
                    if(grocery.info.category == category)
                    {
                        sectionGroceries.append(grocery)
                    }
                }
                
                if sectionGroceries.count > 0
                {
                    numbersOfRowInSection.append(sectionGroceries.count)
                    numberOfSections += 1
                    filteredGroceries.append(sectionGroceries)
                    sectionNames.append(category.rawValue)
                }
            }
        }
        else
        {
            numbersOfRowInSection.append(showGroceries.count)
            numberOfSections = 1
            filteredGroceries.append(showGroceries)
            sectionNames.append("")

        }
    }
    
    func countButtonTapped(sender: GroceryListTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender)
        {
            let groceries = filteredGroceries[indexPath.section]
            let grocery = groceries[indexPath.row]
            
            if(grocery.isPercentageCount == false)
            {
                grocery.count -= 1
                if( grocery.count < 0 )
                {
                    grocery.count = 0
                }
            }
            else
            {
                grocery.count -= 10
                if( grocery.count < 0 )
                {
                    grocery.count = 0
                }
            }
            
            sender.countButton.updatePieChart(count:grocery.count, isPercentage: grocery.isPercentageCount)
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
    
    override public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        if let view = view as? UITableViewHeaderFooterView {
            //view.backgroundView?.backgroundColor = UIColor.blue
            //view.textLabel?.backgroundColor = UIColor.clear
            //view.textLabel?.textColor = UIColor.darkGray
            view.textLabel?.font = .systemFont(ofSize: 17)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell: GroceryListTableViewCell! = nil
        
        // Configure the cell...
        if(filteredGroceries.count > indexPath.section)
        {
            let groceries = filteredGroceries[indexPath.section]
            let grocery = groceries[indexPath.row]
            
            if(grocery.info.image == nil)
            {
                cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath) as? GroceryListTableViewCell
            }
            else
            {
                cell = tableView.dequeueReusableCell(withIdentifier: "groceryPictureCell", for: indexPath) as? GroceryListTableViewCell
                let pictureCell = cell as? GroceryListTableViewPictureCell
                pictureCell?.titleImage.image = grocery.info.image?.image()
            }
            
            cell.delegate = self

            cell.titleLabel?.text = grocery.info.title
            
            let diffDate = grocery.dueDate.date.timeIntervalSinceNow
            let diffDay = Int(diffDate/(DueDate.secondOfDay))
            cell.expirationLabel?.text = grocery.dueDate.getExpirationDay()
            cell.expirationLabel?.backgroundColor = diffDay>=3 ? UIColor.systemGray5 : .red
            cell.expirationLabel?.textColor = diffDay>=3 ? UIColor.darkGray : .white
            
            cell.countButton.updatePieChart(count: grocery.count, isPercentage: grocery.isPercentageCount)
        }
        
        return cell
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
     */
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func addIcon(origin: CGPoint, size: CGSize, systemName: String, color: UIColor, tag: Int) -> UIView
    {
        let imageView = UIImageView()
        imageView.frame = CGRect(origin: origin, size: size)
        imageView.image = UIImage(systemName: systemName)
        imageView.tintColor = color//UIColor.lightGray
        imageView.isOpaque = false
        imageView.layer.cornerRadius = 3
        //imageView.layer.borderColor = UIColor.clear.cgColor// UIColor.lightGray.cgColor
        //imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.tag = tag
        view.addSubview(imageView)
        
        return imageView
    }
    
    private func curveAnimation(from: CGPoint, to: CGPoint, size: CGSize, systemName: String, color: UIColor, duration: TimeInterval)
    {
        let controlPoint = CGPoint(x: (to.x + from.x) * 0.5, y: from.y - 100.0)
        let tag: Int = 1000
        
        let icon : UIView = addIcon(origin: from, size: size, systemName: systemName, color: color, tag: tag)
        
        let numberOfKeyFrames = 50
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.calculationModeCubic], animations:
        {
            for i in 1...numberOfKeyFrames
            {
                let t = CGFloat(i) / CGFloat(numberOfKeyFrames)
                let origin = BezierCurve(t: t, p0: from, c1: controlPoint, p1: to)
              
                //print(origin)
                
                UIView.addKeyframe(withRelativeStartTime: TimeInterval(t), relativeDuration: TimeInterval(1/CGFloat(numberOfKeyFrames))*duration)
                {
                    icon.frame = CGRect(origin: origin, size: size)
                }
            }
        }, completion: {_ in
            if let viewWithTag = self.view.viewWithTag(tag)
            {
                viewWithTag.removeFromSuperview()
            }})
    }
    
    var contentOffset: CGPoint = CGPoint()
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + 92)
    }
    
    
    // editing
    override func tableView(_ tableView: UITableView,
                    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {
        let closeAction = UIContextualAction(style: .destructive, title:  "Cart", handler:
        { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
        
            print("Going to the cart ...")
            fridgeTabBarController.animateBadge(tabBarIndex: .shopingCartTabBar)
            
            
            /*
            if let cell = tableView.cellForRow(at: indexPath) as? GroceryListTableViewCell
            {
                let screenRect = UIScreen.main.bounds
                let screenWidth = screenRect.size.width
                let screenHeight = screenRect.size.height
                
                
                let tabBarWidth = screenWidth / 4.0
                let cartTabIndex = 2
                let cartTabCenter: CGFloat = tabBarWidth * CGFloat(cartTabIndex) + tabBarWidth * 0.5
                
                let systemName: String = "cart"
                let size = CGSize(width: 30, height: 25)
                let originFrom = CGPoint(x: cell.frame.origin.x + tableView.contentOffset.x, y: cell.frame.origin.y + tableView.contentOffset.y)//CGPoint(x: 100, y: 50)
                let originTo = CGPoint(x: cartTabCenter + tableView.contentOffset.x, y: screenHeight + tableView.contentOffset.y)
                let color: UIColor = UIColor.systemGreen
                let duration: TimeInterval = 1
                curveAnimation(from: originFrom, to: originTo, size: size, systemName: systemName, color: color, duration: duration)
            }
            */
            // goto the cart
            let selectedGrocery = filteredGroceries[indexPath.section][indexPath.row]
            let cartGrocery = CartGrocery(info: getGroceryHistory(title: selectedGrocery.info.title, category: selectedGrocery.info.category, updateDate: true))
            cartGroceries.insert(cartGrocery, at: 0)
            
            CartGrocery.saveCartGrocery(cartGroceries)
            
            success(true)
        })
        
        closeAction.image = UIImage(systemName: "cart")
        closeAction.backgroundColor = .systemGreen
     
        return UISwipeActionsConfiguration(actions: [closeAction])
     }
   
    override func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {
        let modifyAction = UIContextualAction(style: .destructive, title:  "Trash", handler:
            { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             
                print("Trash action ...")
                if let cell = tableView.cellForRow(at: indexPath) as? GroceryListTableViewCell
                {
                    let translate = CATransform3DTranslate(CATransform3DIdentity, -1000, 0, 0)
                    
                    UIView.animate(withDuration: 0.5, animations: {cell.layer.transform = translate})
                    {_ in
                        cell.layer.transform = CATransform3DIdentity
                        
                        let selectedGrocery = filteredGroceries[indexPath.section][indexPath.row]
                        
                        if let selectedIndex = findGroceryIndex(grocery: selectedGrocery)
                        {
                            groceries.remove(at: selectedIndex.offset)
                            updateTableView()
                            tableView.reloadData()
                            
                            Grocery.saveGrocery(groceries)
                        }
                    
                        
                    }
                    
                    success(true)
                }
         })
        
         modifyAction.image = UIImage(systemName: "trash")
         modifyAction.backgroundColor = .red
     
         return UISwipeActionsConfiguration(actions: [modifyAction])
     }
    
    // Rearranging
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem]
    {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal
    {
        if session.localDragSession != nil && numberOfSections == 1
        { // Drag originated from the same app.
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }

        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator)
    {
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath)
    {
        if(numberOfSections == 1)
        {
            let fromGrocery = filteredGroceries[fromIndexPath.section][fromIndexPath.row]
            let toGrocery = filteredGroceries[to.section][to.row]
            
            if let fromIndex = findGroceryIndex(grocery: fromGrocery),
               let toIndex = findGroceryIndex(grocery: toGrocery)
            {
                groceries.remove(at: fromIndex.offset)
                groceries.insert(fromGrocery, at: toIndex.offset)
                updateTableView()
                tableView.reloadData()
                
                Grocery.saveGrocery(groceries)
            }
        }
    }
 

    // Override to support conditional rearranging of the table view.
    /*
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    }
    */
    
    func selectedCell()
    {
        performSegue(withIdentifier: "EditCell", sender: self)
    }
    
    @IBAction func categoryButtonTapped(_ sender: Any)
    {
        categoryButtonOn.toggle()
        updateFilteringButtons()
        updateTableView()
        tableView.reloadData()

    }
    
    @IBAction func refrigerationButtonTapped(_ sender: Any)
    {
        refrigerationButtonOn.toggle()
        updateFilteringButtons()
        updateTableView()
        tableView.reloadData()

    }
    
    @IBAction func freezingButtonTapped(_ sender: Any)
    {
        freezingButtonOn.toggle()
        updateFilteringButtons()
        updateTableView()
        tableView.reloadData()

    }
    
    @IBAction func outdoorButtonTapped(_ sender: Any)
    {
        outdoorButtonOn.toggle()
        updateFilteringButtons()
        updateTableView()
        tableView.reloadData()
    }
    
    
    
    

    
    // MARK: - Navigation
    @IBAction func unwindToGroceryListTableView(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        if(unwindSegue.identifier == "UnwindGroceryListFromAddGrocery")
        {
        
            if let sourceViewController = unwindSegue.source as? AddGroceryTableViewController
            {
                let title = sourceViewController.nameTextField.text ?? ""
                let category = GroceryHistory.Category(rawValue: sourceViewController.categoryButton.title(for: .normal) ?? "")!
                //grocery.info.image =
                
                let count = sourceViewController.count
                let isPercentageCount = sourceViewController.percentageSwitch.isOn
                
                let dueDate = sourceViewController.dueDate
                
                let storage = Grocery.Storage(rawValue: sourceViewController.storageSegment.selectedSegmentIndex)!
                let fridgeName = sourceViewController.fridgeSelectButton.title(for: .normal) ?? ""
                let notes = sourceViewController.noteTextField.text
                let image = sourceViewController.groceryImage
                
                if(title.isEmpty == false)
                {
                    if let grocery = sourceViewController.grocery
                    {
                        // editing
                        grocery.info.title = title
                        grocery.info.category = category
                        if(image != nil)
                        {
                            grocery.info.image = image
                        }
                        grocery.count = count
                        grocery.isPercentageCount = isPercentageCount
                        grocery.dueDate = dueDate
                        grocery.storage = storage
                        grocery.fridgeName = fridgeName
                        grocery.notes = notes
                        
                        if(grocery.info.image == nil)
                        {
                            if let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as? GroceryListTableViewCell
                            {
                                cell.titleLabel.text = title
                                cell.expirationLabel.text = grocery.dueDate.getExpirationDay()
                                cell.countButton.setTitle("\(grocery.count)", for: .normal)
                            }
                            else
                            {
                                tableView.reloadData()
                            }
                        }
                        else
                        {
                            if let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as? GroceryListTableViewPictureCell
                            {
                                cell.titleLabel.text = title
                                cell.expirationLabel.text = grocery.dueDate.getExpirationDay()
                                cell.countButton.setTitle("\(grocery.count)", for: .normal)
                            }
                            else
                            {
                                tableView.reloadData()
                            }
                        }
                    }
                    else
                    {
                        // adding
                        let newGrocery = Grocery(info: getGroceryHistory(title: title, category: category, updateDate: true), count: count, isPercentageCount: isPercentageCount, dueDate: dueDate, storage: storage, fridgeName: fridgeName, notes: notes)
                        if(image != nil)
                        {
                            newGrocery.info.image = image
                        }
                        
                        groceries.insert(newGrocery, at: 0)
                        updateTableView()
                    }
                
                    tableView.reloadData()
                    
                    Grocery.saveGrocery(groceries)
                    GroceryHistory.saveGroceryHistory(groceryHistories)
                }
            }
        }
        else if(unwindSegue.identifier == "ToGroceryList")
        {
            selectedfrideName = fridgeNames[selectedFridgeIndex[0]]
            updateTableView()
            tableView.reloadData()
        }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditCell"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let groceries = filteredGroceries[indexPath.section]
                let grocery = groceries[indexPath.row]
                let navigationController = segue.destination as! UINavigationController
                let addGroceryTableViewController = navigationController.topViewController as! AddGroceryTableViewController
                
                addGroceryTableViewController.grocery = grocery
            }
        }
    }
    

}
