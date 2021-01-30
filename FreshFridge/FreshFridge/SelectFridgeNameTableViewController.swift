//
//  SelectFridgeNameTableViewController.swift
//  FreshFridge
//
//  Created by changae choi on 2021/01/17.
//

import UIKit

class SelectFridgeNameTableViewController: UITableViewController {

   @IBOutlet weak var backButton: UIBarButtonItem!
    
    //var isFromAddingGrocery: Bool = false
    var grocery: Grocery?
    var isFromAddGrocery = false
    
    var fridgeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fridgeNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FridgeNameCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = fridgeNames[indexPath.row]
        cell.textLabel?.textColor = .label
        cell.textLabel?.font = systemFont15
        if(isFromAddGrocery)
        {
            let groceryFridgeName = fridgeName//grocery != nil ? grocery!.fridgeName : selectedfrideName
            if( groceryFridgeName == fridgeNames[indexPath.row] )
            {
                cell.accessoryType = .checkmark
            }
            else
            {
                cell.accessoryType = .none
            }
        }
        else
        {
            if(selectedFridgeIndex.contains(indexPath.row))
            {
                cell.accessoryType = .checkmark
            }
            else
            {
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)

        if(isFromAddGrocery) // AddGroceryTableViewController에서 들어온 경우
        {
            // 카테고리 하나만 선택 가능, 해당 항목을 체크하고 나머지는 해제
            cell?.accessoryType = .checkmark
            for rowIndex in 0...fridgeNames.count
            {
                let rowIndexPath = IndexPath(row: rowIndex, section: 0)
                let rowCell = tableView.cellForRow(at: rowIndexPath)
                if(rowCell == cell)
                {
                    rowCell?.accessoryType = .checkmark
                    fridgeName = fridgeNames[rowIndex]
                }
                else
                {
                    rowCell?.accessoryType = .none
                }
            }
            
            performSegue(withIdentifier: "ToAddGrocery", sender: self)
            dismiss(animated: true, completion: nil)
        }
        else
        {
            // 메인뷰에서 냉장고 선택 화면으로 들어온 경우, 멀티 선택 가능
            if let selectedIndex = selectedFridgeIndex.first(where: {$0 == indexPath.row})
            {
                // check된 것을 선택했을때 check 해제
                selectedFridgeIndex.remove(at: selectedFridgeIndex.firstIndex(of: selectedIndex)!)
                cell?.accessoryType = .none
            }
            else
            {
                // check안된 것을 선택했을때 check marking
                selectedFridgeIndex.append(indexPath.row)
                selectedFridgeIndex.sort(by:{$0<$1})
                cell?.accessoryType = .checkmark
            }
            
            UserDefaults.standard.set(selectedFridgeIndex, forKey: "selectedFridgeIndex")
        }

        if(selectedFridgeIndex.count == 0)
        {
            backButton.isEnabled = false
        }
        else
        {
            backButton.isEnabled = true
        }
    }

    @IBAction func backButtonTapped(_ sender: Any)
    {
        if(isFromAddGrocery)
        {
            performSegue(withIdentifier: "ToAddGrocery", sender: self)
        }
        else
        {
            performSegue(withIdentifier: "ToGroceryList", sender: self)
        }
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
