//
//  GroceryListTableViewController.swift
//  GroceryListTableView
//
//  Created by changae choi on 2020/12/26.
//

import UIKit

class GroceryListTableViewController: UITableViewController {

    static var today = Date()
    
    var groceries: [Grocery] = [
        Grocery(title: "양파", category: .Vegetable, count: 5, dueDate: today.addingTimeInterval(secondOfDay*7*2), saveDate: today,
                notes: "", storage: Storage.Outdoor),
        Grocery(title: "양배추", category: .Vegetable, count: 1, dueDate: today.addingTimeInterval(secondOfDay*30), saveDate: today, notes: "", storage: Storage.Refrigeration),
        Grocery(title: "달걀", category: .MeatsAndEggs, count: 30, dueDate: today.addingTimeInterval(-secondOfDay*7), saveDate: today, notes: "", storage: Storage.Refrigeration)
    ]
    
    var numberOfSections: Int = 0
    var sectionNames: [String] = []
    var cellCount: [Int] = []
    var filteredGroceries: [[Grocery]] = []
    
    var filter: FridgeFilter = .CategoryFilter
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        updateTableView()
    }
    
    func updateTableView()
    {
        numberOfSections = 0
        cellCount.removeAll()
        filteredGroceries.removeAll()
        sectionNames.removeAll()
        if filter == .CategoryFilter
        {
            for type in Category.allCases
            {
                let filtered = groceries.filter{$0.category == type}
                if filtered.count > 0
                {
                    cellCount.append(filtered.count)
                    numberOfSections+=1
                    filteredGroceries.append(filtered)
                    sectionNames.append(type.rawValue)
                }
            }
        }
        else
        {
            let storageFilter: Storage
            switch filter {
            case .RefrigerationFilter:
                storageFilter = .Refrigeration
            case .FreezingFilter:
                storageFilter = .Freezing
            case .OutdoorFilter:
                storageFilter = .Outdoor
            default:
                storageFilter = .Refrigeration
            }
            let filtered = groceries.filter{$0.storage == storageFilter}
            if filtered.count > 0
            {
                cellCount.append(filtered.count)
                numberOfSections=1
                filteredGroceries.append(filtered)
                sectionNames.append(FridgeFilter.RefrigerationFilter.rawValue)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellCount[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionNames[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath) as! GroceryListTableViewCell

        // Configure the cell...
        if(filteredGroceries.count > 0)
        {
            let groceries = filteredGroceries[indexPath.section]
            let grocery = groceries[indexPath.row]
            
            cell.titleLabel?.text = grocery.title
            
            let diffDate = grocery.dueDate.timeIntervalSinceNow
            let diffDay = Int(diffDate/(secondOfDay))
            cell.expirationLabel?.text = diffDay>=0 ? String("D-\(diffDay+1)") : String("D+\(-diffDay)")
            cell.expirationLabel?.textColor = diffDay>=0 ? UIColor.darkGray : .red
            
            cell.countButton.setTitle("\(grocery.count)", for: .normal)
        }
        
        return cell
    }
    @IBAction func filterSegmentControlChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
        case 0: filter = .CategoryFilter
        case 1: filter = .RefrigerationFilter
        case 2: filter = .FreezingFilter
        case 3: filter = .OutdoorFilter
        default: return
            
        }
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
