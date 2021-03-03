//
//  SettingTableViewController.swift
//  FreshFridge
//
//  Created by changae choi on 2021/03/02.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet var selectFridgeCells: [UITableViewCell]!
    @IBOutlet var selectFridgeButtons: [UIButton]!
    @IBOutlet var removeButtons: [UIButton]!
    
    @IBOutlet weak var appImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0...3
        {
            if(selectedFridgeIndex.contains(index))
            {
                selectFridgeCells[index].accessoryType = .checkmark
            }
            else
            {
                selectFridgeCells[index].accessoryType = .none
            }
            
            selectFridgeButtons[0].titleLabel?.textAlignment = .left
            selectFridgeButtons[1].titleLabel?.textAlignment = .left
            selectFridgeButtons[2].titleLabel?.textAlignment = .left
            selectFridgeButtons[3].titleLabel?.textAlignment = .left
            
            removeButtons[0].titleLabel?.textAlignment = .left
            removeButtons[1].titleLabel?.textAlignment = .left
            removeButtons[2].titleLabel?.textAlignment = .left
        }
        
        appImage.layer.cornerRadius = 15
        appImage.clipsToBounds = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func backButtonTapped(_ sender: Any)
    {
        performSegue(withIdentifier: "ToGroceryList", sender: self)
    }
    
    func updateSelectFridgeButtons(index: Int)
    {
        if let selectedIndex = selectedFridgeIndex.first(where: {$0 == index})
        {
            // check된 것을 선택했을때 check 해제
            selectedFridgeIndex.remove(at: selectedFridgeIndex.firstIndex(of: selectedIndex)!)
            selectFridgeCells[index].accessoryType = .none
        }
        else
        {
            // check안된 것을 선택했을때 check marking
            selectedFridgeIndex.append(index)
            selectedFridgeIndex.sort(by:{$0<$1})
            selectFridgeCells[index].accessoryType = .checkmark
        }
        
        UserDefaults.standard.set(selectedFridgeIndex, forKey: "selectedFridgeIndex")
        
        if(selectedFridgeIndex.count == 0)
        {
            backButton.isEnabled = false
        }
        else
        {
            backButton.isEnabled = true
        }
    }

    
    @IBAction func selectFirstFridge(_ sender: Any) {
        updateSelectFridgeButtons(index: 0)
    }
    
    @IBAction func selectSecondFridge(_ sender: Any) {
        updateSelectFridgeButtons(index: 1)
    }
    
    @IBAction func selectThirdFridge(_ sender: Any) {
        updateSelectFridgeButtons(index: 2)
    }
    
    @IBAction func selectForthFridge(_ sender: Any) {
        updateSelectFridgeButtons(index: 3)
    }
    
    
    @IBAction func removeAllGroceries(_ sender: Any)
    {
        presentAlert(title: "냉장고 품목 전체를 삭제하시겠습니까?", parent: self)
        {_ in
            //DataManager.shared.removeAllFridgeGroceries()
            for grocery in DataManager.shared.getGroceries()
            {
                RequestManager.shared.getRequestInterface().removeGrocery(id: grocery.id)
            }
        }
        
    }
    
    @IBAction func removeAllGroceryHistories(_ sender: Any)
    {
        //DataManager.shared.removeAllGroceryHistories()
        // 냉장고나 카트에 참조되지 않는 구입기록을 골라낸다.
        presentAlert(title: "구입기록 전체를 삭제하시겠습니까?", parent: self)
        {_ in
            var notReferencedGroceryHistory: [GroceryHistory] = []
            for groceryHistory in DataManager.shared.getGroceryHistories()
            {
                var found: Bool = false
                for grocery in DataManager.shared.getGroceries()
                {
                    if(groceryHistory === grocery.info)
                    {
                        found = true
                    }
                }
                
                for cartGrocery in DataManager.shared.getCartGroceries()
                {
                    if(groceryHistory === cartGrocery.info)
                    {
                        found = true
                    }
                }
                
                if(found == false)
                {
                    notReferencedGroceryHistory.insert(groceryHistory, at:0)
                }
            }
            
            // 참조되지 않는 구입기록을 서버에 생성 요청한다.
            for groceryHistory in notReferencedGroceryHistory
            {
                //DataManager.shared.removeGroceryHistory(id: groceryHistory.id)
                RequestManager.shared.getRequestInterface().removeGroceryHistory(id: groceryHistory.id)
            }
        }
    }
    
    
    @IBAction func removeAllCartGroceries(_ sender: Any)
    {
        //DataManager.shared.removeAllCartGroceries()
        presentAlert(title: "장바구니 전체를 삭제하시겠습니까?", parent: self)
        {_ in
            for cartGrocery in DataManager.shared.getCartGroceries()
            {
                RequestManager.shared.getRequestInterface().removeCartGrocery(id: cartGrocery.id)
            }
        }
    }
    
    
    
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    

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
