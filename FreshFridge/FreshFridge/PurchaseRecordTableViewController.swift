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
        
    //처음에는 아래 기본값이지만 차후에 사용자가 바꿀수 있고 바뀐 그 값은 저장되어 있어야 한다.
    var categorySortButtonOn = false
    var favoriteSortButtonOn = true
    var recentSortButtonOn = false
    
    
    // 즐겨찾기가 상단에 위치하도록 먼저 걸러거나 아니거나 한 어레이
    var purchaseRecordTableViewArray: [GroceryHistory] = []
    
    // 최종 테이블 뷰는 필터드그로서리즈로 만든다. 카네고리별로 분류 될수 있다.
    var filteredGroceries: [[GroceryHistory]] = []
    
    // 서치바를 위한 어레이
    var searchbarGroceries: [GroceryHistory] = groceryHistories
    
    // 최신순 또는 가나다 순으로 정렬된 어레이
    var sortedArray: [GroceryHistory] = []
    

//    var favoriteFirstArray: [GroceryHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                      
        SearchBar.delegate = self
        
        searchbarGroceries = groceryHistories
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
        updateTableView()
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
        sortedArray.removeAll()
        purchaseRecordTableViewArray.removeAll()
        filteredGroceries.removeAll()
        sectionNames.removeAll()
        
        // 최신순 버튼이 켜져 있으면 서치바에서 넘어온 어레이를 그대로 담는다. 기본 어레이는 사용자가 추가한 순서대로 어팬드 되니까 어짜피 최신순 일 것이다.
        if recentSortButtonOn == true {
            sortedArray = searchbarGroceries
        }
        // 최신순 버튼이 꺼져 있으면 타이틀의 가나다 순으로 정렬해서 다음 어레이에 담는다.
        else {
            sortedArray = searchbarGroceries.sorted { $0.title < $1.title }
        }
        
        
        // 즐겨찾기 버튼이 켜져 있으면 어레이 값 중에서 즐겨찾기 값이 참인 것 먼저 상단에 위치하도록 정렬한다.
        if favoriteSortButtonOn == true {
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
        if categorySortButtonOn == true {
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
    }
        else {  // 분류별이 아니면 섹션 나누지 않고 그대로 진행한다.
        numbersOfRowInSection.append(purchaseRecordTableViewArray.count)
        numberOfSections = 1
        filteredGroceries.append(purchaseRecordTableViewArray)
        sectionNames.append("")
        }
    }


    
    
    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseRecordCell", for: indexPath) as! PurchaseRecordTableViewCell
        
        let cellContents = filteredGroceries[indexPath.section][indexPath.row]
        cell.updateCell(with: cellContents)

       
        

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

    
    // 즐겨찾기 별표 버튼을 누르면 반응
    func fovoriteCheckMarkTapped(sender: PurchaseRecordTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var thisGrocery = filteredGroceries[indexPath.section][indexPath.row]
            thisGrocery.favorite = !thisGrocery.favorite
            filteredGroceries[indexPath.section][indexPath.row] = thisGrocery
        }
        updateTableView()
        
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
        recentSortButtonOn = !recentSortButtonOn
        updateButtons()
        updateTableView()
        tableView.reloadData()
    }
    
}
