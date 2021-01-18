//
//  AddGroceryTableViewController.swift
//  GroceryListTableView
//
//  Created by changae choi on 2021/01/02.
//

import UIKit

class AddGroceryTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

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
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var fridgeSelectButton: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var pictureButton: UIButton!
//    @IBOutlet weak var barcodeScanButton: UIButton!
    
    var barcodeScanButton: UIButton!
    let barcodeScanButtonOffset: CGFloat = 100.0

    var isDueDatePickerShown = false
    
    var grocery: Grocery?
    
    var count: Int = 0  // 추가 버튼으로 들어온 경우 사용됨
    var dueDate: DueDate = DueDate(0)   // 추가 버튼으로 들어온 경우 사용됨
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageSegment.setTitleTextAttributes([NSAttributedString.Key.font: systemFont15], for: .normal)
        storageSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .selected)
        storageSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
        
        
        countLabel.layer.cornerRadius = 10
        countLabel.clipsToBounds = true
        
        dueDateTitleLabel.layer.cornerRadius = 10
        dueDateTitleLabel.clipsToBounds = true
        dueDateTitleLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        dueDateButton.layer.cornerRadius = 10
        dueDateButton.clipsToBounds = true
        dueDateButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        pictureButton.imageView?.contentMode = .scaleAspectFit
        
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
        // self.navigationItemscaleAspectFit.rightBarButtonItem = self.editButtonItem
        if let grocery = grocery
        {
            count = grocery.count
            dueDate.date = grocery.dueDate.date
            
            storageSegment.selectedSegmentIndex = grocery.storage.rawValue
            nameTextField.text = grocery.info.title
            categoryButton.setTitle(grocery.info.category.rawValue, for: .normal)
            countLabel.text = "\(Int(grocery.count))"
            percentageSwitch.isOn = grocery.isPercentageCount
            fridgeSelectButton.setTitle(grocery.fridgeName, for: .normal)
            noteTextField.text = grocery.notes
            if(grocery.info.image != nil)
            {
                pictureButton.setImage(grocery.info.image?.image(), for: .normal)
                
            }
            updateTableView()
            
            self.title = ""
            
        }
        else
        {
            count = 0
            dueDate.date = Date()
            
            storageSegment.selectedSegmentIndex = 0
            categoryButton.setTitle(GroceryHistory.Category.ETC.rawValue, for: .normal)
            countLabel.text = "\(Int(count))"
            percentageSwitch.isOn = false
            fridgeSelectButton.setTitle(selectedfrideName, for: .normal)
            updateTableView()
            
            self.title = "상품 추가"
        }
        
        
        
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        barcodeScanButton.frame.origin.y = scrollView.frame.height - barcodeScanButtonOffset + scrollView.contentOffset.y
    }
    
    let dueDatePickerIndexPath = IndexPath(row: 1, section: 4)
    let pictureButtonIndexPath = IndexPath(row: 0, section: 7)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath == dueDatePickerIndexPath)
        {
            if(isDueDatePickerShown)
            {
                return 300.0
            }
            else
            {
                return 0.0
            }
        }
        else if(indexPath == pictureButtonIndexPath)
        {
            if(view.superview != nil)
            {
                return view.superview!.frame.size.width * 3.0 / 4.0
            }
            else
            {
                return view.frame.width * 3.0 / 4.0
            }
        }
        
        return 44.0
    }
    
    func updateTableView()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dueDateButton.setTitle(dateFormatter.string(from: dueDate.date), for: .normal)
        
        countLabel.text = "\(Int(count))"
        
        if(grocery != nil)
        {
            fridgeSelectButton.setTitle(grocery?.fridgeName, for: .normal)
        }
        else
        {
            fridgeSelectButton.setTitle(selectedfrideName, for: .normal)
        }
    }
    
    @IBAction func countDecreaseButtonTapped(_ sender: Any)
    {
        if(percentageSwitch.isOn)
        {
            count -= 10
        }
        else
        {
            count -= 1
        }
        
        if(count < 0)
        {
            count = 0
        }
        
        updateTableView()
    }
    
    @IBAction func countIncreaseButtonTapped(_ sender: Any)
    {
        if(percentageSwitch.isOn)
        {
            count += 10
            if(count > 100)
            {
                count = 100
            }
        }
        else
        {
            count += 1
        }
        
        updateTableView()
    }
    
    @IBAction func percentageSwitchChanged(_ sender: Any)
    {
        if(percentageSwitch.isOn)
        {
            count = 100
        }
        else
        {
            count = 1
        }
        
        countLabel.text = "\(count)"
    }
    
    @IBAction func dueDateButtonTapped(_ sender: Any)
    {
        isDueDatePickerShown.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func dueDatePickerChanged(_ sender: Any)
    {
        dueDate.date = dueDatePicker.date
        updateTableView()
    }
    
    @IBAction func dueDateIncreaseWeekTapped(_ sender: Any)
    {
        dueDate.addDays(7)
        updateTableView()
    }
    
    @IBAction func dueDateIncreaseMonthTapped(_ sender: Any)
    {
        dueDate.addMonth()
        updateTableView()
    }
    
    @IBAction func fridgeSelectButtonTapped(_ sender: Any) {
    }
    
    @IBAction func pictureButtonTapped(_ sender: UIButton)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                //print("User selected Camera Action")
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            
            alertController.addAction(cameraAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {
                action in
                //print("User selected Photo Library Action")
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
                })
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.popoverPresentationController?.sourceView = sender
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        let typeImage = GroceryImage(image: selectedImage)
        if let grocery = grocery
        {
            grocery.info.image = typeImage
        }
        
        pictureButton.setImage(typeImage.image(), for: .normal)
        

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func barcodeScanButtonTapped(_ sender: Any) {
    }
    
    @IBAction func unwindToAddGrocery(_ unwindSegue: UIStoryboardSegue)
    {
        if( unwindSegue.identifier == "defaultNameSeque")
        {
            let sourceViewController = unwindSegue.source as! DefaultNameViewController
            if(sourceViewController.selectedName != "")
            {
                // Use data from the view controller which initiated the unwind segue
                nameTextField.text = sourceViewController.selectedName
            }
        }
        else if(unwindSegue.identifier == "CategorySegue")
        {
            let sourceViewController = unwindSegue.source as! CategoryTableViewController
            if(sourceViewController.categoryName != "")
            {
                categoryButton.setTitle(sourceViewController.categoryName, for: .normal)
            }
        }
        else if(unwindSegue.identifier == "ToAddGrocery")
        {
            let sourceViewController = unwindSegue.source as! SelectFridgeNameTableViewController
            if(sourceViewController.fridgeName != "")
            {
                fridgeSelectButton.setTitle(sourceViewController.fridgeName, for: .normal)
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "FromAddGrocerySeque")
        {
            let navController = segue.destination as! UINavigationController
            let controller = navController.topViewController as! SelectFridgeNameTableViewController
            controller.grocery = grocery
            controller.isFromAddGrocery = true
        }
    }
    

}
