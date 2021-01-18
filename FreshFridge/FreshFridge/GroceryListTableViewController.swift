//
//  GroceryListTableViewController.swift
//  GroceryListTableView
//
//  Created by changae choi on 2020/12/26.
//

import UIKit

class GroceryListTableViewController: UITableViewController, GroceryListCellDelegate {
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var refrigerationButton: UIButton!
    @IBOutlet weak var freezingButton: UIButton!
    @IBOutlet weak var outdoorButton: UIButton!

    
    var numberOfSections: Int = 0
    var sectionNames: [String] = []
    var numbersOfRowInSection: [Int] = []
    var filteredGroceries: [[Grocery]] = []
    
    //var filtersInFridgeView: [Bool] = [true, true, true]   // FridgeViewFilter순서
    var categoryButtonOn = true
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
            
            filteredGroceries[indexPath.section] = groceries
            
            sender.countButton.updatePieChart(count: groceries[indexPath.row].count, isPercentage: groceries[indexPath.row].isPercentageCount)
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
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    @IBAction func unwindToGroceryListTableView(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        if(unwindSegue.identifier == "SaveUnwind")
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
                
                
                if let grocery = sourceViewController.grocery
                {
                    // editing
                    grocery.info.title = title
                    grocery.info.category = category
                    //grocery.info.image
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
                    let newGrocery = Grocery(info: getGroceryHistory(title: title, category: category), count: count, isPercentageCount: isPercentageCount, dueDate: dueDate, storage: storage, fridgeName: fridgeName, notes: notes)
                    groceries.append(newGrocery)
                    
                    updateTableView()
                }
                
                tableView.reloadData()
                
                Grocery.saveGrocery(groceries)
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
            let indexPath = tableView.indexPathForSelectedRow!
            let groceries = filteredGroceries[indexPath.section]
            let grocery = groceries[indexPath.row]
            let navigationController = segue.destination as! UINavigationController
            let addGroceryTableViewController = navigationController.topViewController as! AddGroceryTableViewController
            
            addGroceryTableViewController.grocery = grocery
        }
    }
    

}
