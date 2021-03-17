//
//  CategoryTableViewController.swift
//  FreshFridge
//
//  Created by changae choi on 2021/01/17.
//

import UIKit

class CategoryTableViewController: UITableViewController, ImageTableViewCellDelegate {
        

    //var categoryName = ""
    var category: GroceryHistory.Category? = nil// = GroceryHistory.Category.ETC
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ""
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // s elf.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GroceryHistory.Category.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        // Configure the cell...
        (cell as! ImageTableViewCell).titleLabel?.text = GroceryHistory.Category.allCases[indexPath.row].description
        (cell as! ImageTableViewCell).titleLabel?.textColor = .label
        (cell as! ImageTableViewCell).titleLabel?.font = systemFont18
        (cell as! ImageTableViewCell).titleImage?.image = UIImage(named: GroceryHistory.Category(rawValue: indexPath.row)!.systemName)
        (cell as! ImageTableViewCell).tag = indexPath.row
        (cell as! ImageTableViewCell).delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        category = GroceryHistory.Category.allCases[indexPath.row]
        performSegue(withIdentifier: "CategorySegue", sender: self)
    }
    
    func selectedCell(cell: ImageTableViewCell)
    {
        //category = GroceryHistory.Category(rawValue: cell.tag)
        //performSegue(withIdentifier: "CategorySegue", sender: self)
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
