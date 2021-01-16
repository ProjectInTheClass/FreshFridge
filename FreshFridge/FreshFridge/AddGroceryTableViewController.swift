//
//  AddGroceryTableViewController.swift
//  GroceryListTableView
//
//  Created by changae choi on 2021/01/02.
//

import UIKit

class AddGroceryTableViewController: UITableViewController {

    @IBOutlet weak var storageSegment: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countDecreaseButton: UIButton!
    @IBOutlet weak var countIncreaseButton: UIButton!
    @IBOutlet weak var percentageSwitch: UISwitch!
    @IBOutlet weak var dueDateTitleLabel: UILabel!
    @IBOutlet weak var dueDateButton: UIButton!
    @IBOutlet weak var dueDateIncreaseWeek: UIButton!
    @IBOutlet weak var dueDateIncreaseMonth: UIButton!
    @IBOutlet weak var fridgeSelectButton: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var pictureButton: UIButton!
//    @IBOutlet weak var barcodeScanButton: UIButton!
    
    var barcodeScanButton: UIButton!
    let barcodeScanButtonOffset: CGFloat = 100.0
    
    var isDueDatePickerShown = false
    
    var grocery: Grocery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLabel.layer.cornerRadius = 10
        countLabel.clipsToBounds = true
        
        dueDateTitleLabel.layer.cornerRadius = 10
        dueDateTitleLabel.clipsToBounds = true
        dueDateTitleLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        dueDateButton.layer.cornerRadius = 10
        dueDateButton.clipsToBounds = true
        dueDateButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        barcodeScanButton = UIButton(frame: CGRect(x: 5, y: self.view.frame.height - barcodeScanButtonOffset, width: self.view.frame.width - 10, height: 50))
        barcodeScanButton.backgroundColor = .orange
        barcodeScanButton.setTitle("Barcode Scan", for: .normal)
        barcodeScanButton.addTarget(self, action: #selector(barcodeScanButtonTapped(_:)), for: .touchUpInside)
        barcodeScanButton.layer.cornerRadius = 20
        barcodeScanButton.clipsToBounds = true
        self.view.addSubview(barcodeScanButton)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let grocery = grocery
        {
            storageSegment.selectedSegmentIndex = grocery.storage.rawValue
            
            nameTextField.text = grocery.info.title
            categoryButton.setTitle(grocery.info.category.rawValue, for: .normal)
            countLabel.text = "\(Int(grocery.count))"
            percentageSwitch.isOn = grocery.isPercentageCount
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "ko_KR")
            
            dueDateButton.setTitle(dateFormatter.string(from: grocery.dueDate.date), for: .normal)
            fridgeSelectButton.setTitle(grocery.fridgeName, for: .normal)
            noteTextField.text = grocery.notes
            
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        barcodeScanButton.frame.origin.y = scrollView.frame.height - barcodeScanButtonOffset + scrollView.contentOffset.y
    }
    
    let dueDatePickerIndexPath = IndexPath(row: 1, section: 4)
    let pictureButtonIndexPath = IndexPath(row: 0, section: 7)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath == dueDatePickerIndexPath)
        {
            if(isDueDatePickerShown)
            {
                return 250.0
            }
            else
            {
                return 0.0
            }
        }
        else if(indexPath == pictureButtonIndexPath)
        {
            return 200.0
        }
        
        return 44.0
    }
    
    @IBAction func storageSegmentTapped(_ sender: Any) {
    }
    
    @IBAction func nameTextFieldEdited(_ sender: Any) {
    }
    
    @IBAction func categoryButtonTapped(_ sender: Any) {
    }
    
    @IBAction func countDecreaseButtonTapped(_ sender: Any) {
    }
    
    @IBAction func countIncreaseButtonTapped(_ sender: Any) {
    }
    
    @IBAction func percentageSwitchChanged(_ sender: Any) {
    }
    
    @IBAction func dueDateButtonTapped(_ sender: Any) {
        isDueDatePickerShown.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func dueDateIncreaseWeekTapped(_ sender: Any) {
    }
    
    @IBAction func dueDateIncreaseMonthTapped(_ sender: Any) {
    }
    
    @IBAction func fridgeSelectButtonTapped(_ sender: Any) {
    }
    @IBAction func noteTextFieldEdited(_ sender: Any) {
    }
    @IBAction func pictureButtonTapped(_ sender: Any) {
    }
    @IBAction func barcodeScanButtonTapped(_ sender: Any) {
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
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
