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
    
    var numberOfSections: Int = 0
    var sectionNames: [String] = []
    var numbersOfRowInSection: [Int] = []
        
    var categorySortButtonOn = true
    var favoriteSortButtonOn = true
    var recentSortButtonOn = false
    
    
    //테이블 뷰는 기본적으로 아래 어레이를 가지고 만든다.
    var purchaseRecordTableViewArray: [GroceryHistory] = []
    
    // 섹션을 나눌 때는 아래 네스팅된 어레이를 가지고 만든다.
    var filteredGroceries: [[GroceryHistory]] = []
    
    // 서치바를 위한 어레이
    var searchbarGroceries: [GroceryHistory] = groceryHistories
    
    // 가나다 순으로 정렬된 어레이
    var inAlphabeticalOrderArray: [GroceryHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                      
        SearchBar.delegate = self
        
        if let savedGroceryHistories = GroceryHistory.loadGroceryHistory()
        {
            groceryHistories = savedGroceryHistories
        }
        else
        {
            groceryHistories = GroceryHistory.loadSampleGroceryHistory()
        }
        
        updateButtons()
        updateTableView()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        if searchText == "" {
            searchbarGroceries = groceryHistories
        } else {
            searchbarGroceries = groceryHistories.filter { $0.title.contains(searchText)}
            }
        self.tableView.reloadData()
    }
 
    
    
    
    func updateButtons() {
        CategorySortButton.switchOnOff(isOn: categorySortButtonOn)
        FavoriteSortButton.switchOnOff(isOn: favoriteSortButtonOn)
        RecentSortButton.switchOnOff(isOn: recentSortButtonOn)
    }
    
    
    func updateTableView() {
        numberOfSections = 0
        numbersOfRowInSection.removeAll()
        filteredGroceries.removeAll()
        sectionNames.removeAll()
        
        if categorySortButtonOn == true {  // 분류별인 경우
        for category in GroceryHistory.Category.allCases {
            var sectionGroceries: [GroceryHistory] = []
            for grocery in searchbarGroceries {
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
    }
        else {  // 분류별이 아니면 섹션 나누지 않고 그대로 진행한다.
        numbersOfRowInSection.append(searchbarGroceries.count)
        numberOfSections = 1
        filteredGroceries.append(searchbarGroceries)
        sectionNames.append("")
        }
    }

//    func favoriteFirstSorting(_ array: )
    
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseRecordCell", for: indexPath)
        let cellContents = filteredGroceries[indexPath.row] // as! PurchaseRecordTableViewCell
        print(cellContents)
//        cell.textLabel?.text = cellContents.title
        

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

    func fovoriteCheckMarkTapped(sender: PurchaseRecordTableViewCell) {
        print("넘어오긴 했군")
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
        categorySortButtonOn = !categorySortButtonOn
        updateButtons()
        updateTableView()
        tableView.reloadData()
        
    }
    
    @IBAction func FavoriteSortButtonTapped(_ sender: UIButton) {
        favoriteSortButtonOn = !favoriteSortButtonOn
        updateButtons()
        updateTableView()
        tableView.reloadData()
    }
    
    @IBAction func RecentSortButtonTapped(_ sender: UIButton) {
        recentSortButtonOn.toggle()
        updateButtons()
        updateTableView()
        tableView.reloadData()
    }
    
}
