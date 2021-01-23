//
//  ShopingCartTableViewController.swift
//  FreshFridge
//
//  Created by Park Youngeun on 2021/01/20.
//
// var cartGroceries = [CartGrocery]()


import UIKit

class ShopingCartTableViewController: UITableViewController, ShopingCartCellDelegate{

 
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var latestButton: UIButton!
    
    
    
    var numberOfSections: Int = 0
    var sectionNames: [String] = []
    var numbersOfRowInSection: [Int] = []
    
    
    //처음에는 아래 기본값이지만 차후에 사용자가 바꿀수 있고 바뀐 그 값은 저장되어 있어야 한다.
    
    var categoryButtonOn = true
    var latestButtonOn = false
        
    // 섹션을 나누지 않을 때는 아래 어레이를 가지고 만든다.
    var shopingCartTableViewArray: [CartGrocery] = []
    
    // 섹션을 나눌 때는 아래 네스팅된 어레이를 가지고 만든다.
    var filteredGroceries: [[CartGrocery]] = []
    
    // 최신순 또는 가나다 순으로 정렬된 어레이
    var sortedArray: [CartGrocery] = []

    // 최종 테이블 뷰는 필터드그로서리즈로 만든다. 카네고리별로 분류 될수 있다.
    var filteredCartGroceries: [[CartGrocery]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopingCartTableViewArray = cartGroceries 
        updateButtons() 
        updateTableView()
    }

    func updateButtons() {
        categoryButton.switchOnOff(isOn: categoryButtonOn)
        latestButton.switchOnOff(isOn: latestButtonOn)
    }
    
    
    func updateTableView() {
        numberOfSections = 0
        shopingCartTableViewArray.removeAll()
        numbersOfRowInSection.removeAll()
        filteredCartGroceries.removeAll()
        sectionNames.removeAll()
        
        // 최신순 버튼이 켜져 있으면 CartGrocery 어레이를 그대로 담는다. 기본 어레이는 사용자가 추가한 순서대로 어팬드 되니까 어짜피 최신순 일 것이다.
        if latestButtonOn == true {
            sortedArray = cartGroceries
        }
        // 최신순 버튼이 꺼져 있으면 타이틀의 가나다 순으로 정렬해서 다음 어레이에 담는다.
        //else {
          //  sortedArray = cartGroceries.sorted { $0.info < $1.info }
            
        //}
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopingCartCell", for: indexPath) as! ShopingCartTableViewCell
        
        let cellContents = filteredGroceries[indexPath.section][indexPath.row]
        cell.updateCell(with: cellContents)

        cell.delegate = self
        

        return cell
    }

// 장바구니 체크 박스 누르면 반응
    func checkCartTapped(sender: ShopingCartTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            let checkGrocery = filteredGroceries[indexPath.section][indexPath.row]
            checkGrocery.isPurchased = !checkGrocery.isPurchased
            filteredGroceries[indexPath.section][indexPath.row] = checkGrocery
        }
        updateTableView()
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
    
}
