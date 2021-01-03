//
//  AddEditTableViewController.swift
//  TableViewHW
//
//  Created by iM27 on 2021/01/01.
//

import UIKit

class AddEditTableViewController: UITableViewController {
    
    var itemAdd: ItemStruct?
    // 사용자가 기존 항목을 에디트를 하거나 새로 추가를 할 때 item을 추가하여 테이블뷰에 넣도록 하기위한 변수선언, 보통 클래스 바로 아래다 적을 것! 함수 안에다 넣으면 안됨, 물음표는 옵셔널을 의미함.

    
    @IBOutlet weak var SymbolTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var MemoTextField: UITextField!
    @IBOutlet weak var QuantityTextField: UITextField!
    
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let itemInNextPage = itemAdd {
            SymbolTextField.text = itemInNextPage.symbol
            NameTextField.text = itemInNextPage.name
            MemoTextField.text = itemInNextPage.memo
            QuantityTextField.text = String(itemInNextPage.quantity)
        }
        updateSaveButtonState()
                
    }
    
    func updateSaveButtonState() {
        let symbolText = SymbolTextField.text ?? ""
        let nameText = NameTextField.text ?? ""
        let memoText = MemoTextField.text ?? ""
        let quantityNumber = QuantityTextField.text ?? ""
        
        SaveButton.isEnabled = !symbolText.isEmpty && !nameText.isEmpty && !memoText.isEmpty && !quantityNumber.isEmpty
        
        
    }

    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    // MARK: - Table view data source

   
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "SaveUnwind" else { return }

        let symbolText = SymbolTextField.text ?? ""
        let nameText = NameTextField.text ?? ""
        let memoText = MemoTextField.text ?? ""
        let quantityNumber = Int(QuantityTextField.text ?? "")
        
        itemAdd = ItemStruct(symbol: symbolText, name: nameText, memo: memoText, quantity: quantityNumber!)
    }

}
