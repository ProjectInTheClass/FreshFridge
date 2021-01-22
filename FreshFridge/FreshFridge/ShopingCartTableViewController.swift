//
//  ShopingCartTableViewController.swift
//  FreshFridge
//
//  Created by Park Youngeun on 2021/01/20.
//

import UIKit

class ShopingCartTableViewController: UITableViewController{
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var latestButton: UIButton!
   
    var numberOfSections: Int = 0
    var sectionNames: [String] = []
    var numbersOfRowInSection: [Int] = []
    var filteredGroceries: [[CartGrocery]] = []
    
    //var filtersInFridgeView: [Bool] = [true, true, true]   // FridgeViewFilter순서
    var categoryButtonOn = true
    var latestButtonOn = true
    
    

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
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numbersOfRowInSection[section]
    }

  /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ShopingCartTableViewCell! = nil
    
        if(filteredGroceries.count > indexPath.section){
            let groceries = filteredGroceries[indexPath.section]
            let grocery = groceries[indexPath.row]
         /*
           if(gorcery.info.image == nil)
            {
                cell = tableView.dequeueReusableCell(withIdentifier: "shopingCartCell", for indexPath) as? ShopingCartTableViewCell
            }else{
                cell = tableView.dequeueReusableCell(withIdentifier: "shopingCartPictureCell", for: indexPath) as? ShopingCartTableViewCell
                let pictureCell = cell as? ShopingCartTableViewPictureCell
                pictureCell?.titleImage.image = grocery.info.image?.image()
            }
        }
        */
        
        
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
*/
        return cell
        }
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
