//
//  AddGroceryTableViewController.swift
//  GroceryListTableView
//
//  Created by changae choi on 2021/01/02.
//

import UIKit

class AddGroceryTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate, BarcodeDataDelegate {
    
    @IBOutlet weak var completeButton: UIBarButtonItem!
    @IBOutlet weak var storageSegment: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var countTextField: UITextField!
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
    
    var barcodeScanButton: UIButton!
    let barcodeScanButtonOffset: CGFloat = 100.0

    var isDueDatePickerShown = false
    
    var grocery: Grocery?
    
    var count: Int = 0  // 추가 버튼으로 들어온 경우 사용됨
    var dueDate: DueDate = DueDate(0)   // 추가 버튼으로 들어온 경우 사용됨
    var groceryImage: GroceryImage?
    
    var isFromShoppingCart: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Date Picker Darkmode에서 잘나오지 않는 문제
        //if #available(iOS 13.0, *)
        //{
            //overrideUserInterfaceStyle = .dark
        dueDatePicker.backgroundColor = .systemBackground
        //}
        //else
        //{
        //    dueDatePicker.backgroundColor = .white
        //}
        
        nameTextField.delegate = self
        
        countTextField.layer.cornerRadius = 8
        countTextField.clipsToBounds = true
        
        dueDateTitleLabel.layer.cornerRadius = 10
        dueDateTitleLabel.clipsToBounds = true
        dueDateTitleLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        dueDateButton.layer.cornerRadius = 10
        dueDateButton.clipsToBounds = true
        dueDateButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        noteTextField.delegate = self
        
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
            countTextField.text = "\(Int(grocery.count))"
            percentageSwitch.isOn = grocery.isPercentageCount
            fridgeSelectButton.setTitle(grocery.fridgeName, for: .normal)
            noteTextField.text = grocery.notes
            groceryImage = grocery.info.image
            if(groceryImage != nil)
            {
                pictureButton.setImage(groceryImage?.image(), for: .normal)
                
            }
            updateTableView()
            
            self.title = ""
            
        }
        else
        {
            count = 1
            dueDate.date = Calendar.current.startOfDay(for: Date())
            
            storageSegment.selectedSegmentIndex = 0
            categoryButton.setTitle(GroceryHistory.Category.ETC.rawValue, for: .normal)
            countTextField.text = "\(Int(count))"
            percentageSwitch.isOn = false
            fridgeSelectButton.setTitle(selectedfrideName, for: .normal)
            updateTableView()
            
            self.title = "상품 추가"
        }
        
        if(isFromShoppingCart)
        {
            storageSegment.isHidden = true
            dueDateTitleLabel.isHidden = true
            dueDateButton.isHidden = true
            dueDateIncreaseWeek.isHidden = true
            dueDateIncreaseMonth.isHidden = true
            dueDatePicker.isHidden = true
            fridgeSelectButton.isHidden = true
            noteTextField.isHidden = true
            barcodeScanButton.isHidden = true
        }
        else
        {
            storageSegment.isHidden = false
            dueDateTitleLabel.isHidden = false
            dueDateButton.isHidden = false
            dueDateIncreaseWeek.isHidden = false
            dueDateIncreaseMonth.isHidden = false
            dueDatePicker.isHidden = false
            fridgeSelectButton.isHidden = false
            noteTextField.isHidden = false
            barcodeScanButton.isHidden = false
        }
        
        enableCompletButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        }

        deinit {
           NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }

        @objc func rotated()
        {
            if UIDevice.current.orientation.isLandscape
            {
                print("Landscape")
            }
            else
            {
                print("Portrait")
            }
        
            barcodeScanButton.frame = CGRect(x: 5, y: self.view.frame.height - barcodeScanButtonOffset, width: self.view.frame.width - 10, height: 50)
        }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//
//        if UIDevice.current.orientation.isLandscape {
//            print("Landscape")
//        } else {
//            print("Portrait")
//        }
//
//        barcodeScanButton.frame = CGRect(x: 5, y: size.height - barcodeScanButtonOffset, width: size.width - 10, height: 50)
//    }
    
    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
        enableCompletButton()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        barcodeScanButton.frame.origin.y = scrollView.frame.height - barcodeScanButtonOffset + scrollView.contentOffset.y
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
//        nameTextField.resignFirstResponder()
//        noteTextField.resignFirstResponder()
        dismissKeyboard()
        return true;
    }
    
    let dueDatePickerIndexPath = IndexPath(row: 1, section: 4)
    let pictureButtonIndexPath = IndexPath(row: 0, section: 7)
    
    let storageSegmentedIndexPath = IndexPath(row: 0, section: 0)
    let dueDateLabelIndexPath = IndexPath(row: 0, section: 4)
    let selectFridgeNameIndexPath = IndexPath(row: 0, section: 5)
    let notesIndexPath = IndexPath(row: 0, section: 6)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
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
        else
        {
            if(isFromShoppingCart)
            {
                switch indexPath {
                case storageSegmentedIndexPath:
                    return 0.0
                case dueDateLabelIndexPath:
                    return 0.0
                case dueDatePickerIndexPath:
                    return 0.0
                case selectFridgeNameIndexPath:
                    return 0.0
                case notesIndexPath:
                    return 0.0
                default:
                    return 44.0
                }
            }
            else
            {
                return 44.0
            }
        }
    }
    
    func updateTableView()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dueDateButton.setTitle(dateFormatter.string(from: dueDate.date), for: .normal)
        print(dueDate.getExpirationDay())
        
        countTextField.text = "\(Int(count))"
        
        if(grocery != nil)
        {
            fridgeSelectButton.setTitle(grocery?.fridgeName, for: .normal)
        }
        else
        {
            fridgeSelectButton.setTitle(selectedfrideName, for: .normal)
        }
    }
    
    func enableCompletButton()
    {
        completeButton.isEnabled = false
        
        if let text = nameTextField.text
        {
            if(text != "")
            {
                completeButton.isEnabled = true
            }
        }
        
        if(pictureButton.image(for: .normal) != nil)
        {
            completeButton.isEnabled = true
        }
    }
    
    @IBAction func countTableCellTapped(_ sender: Any)
    {
        dismissKeyboard()
    }
    
    @IBAction func dueDateTableCellTapped(_ sender: Any)
    {
        dismissKeyboard()
    }
    
    @IBAction func storageSegmentedControlTapped(_ sender: Any)
    {
        dismissKeyboard()
    }
    
    @IBAction func nameTextFieldEdited(_ sender: Any)
    {
        enableCompletButton()
    }
    
    @IBAction func defaultNameButtonTapped(_ sender: Any)
    {
        dismissKeyboard()
    }
    
    @IBAction func categoryButtonTapped(_ sender: Any)
    {
        dismissKeyboard()
    }
    
    @IBAction func categorySelectButtonTapped(_ sender: Any)
    {
        dismissKeyboard()
    }
    
    @IBAction func countTextFieldEdited(_ sender: Any)
    {
        count = 0
        if let text = countTextField.text
        {
            count = Int(text) ?? 0
        }
        
        if(count < 0)
        {
            count = 0
        }
        
        if(percentageSwitch.isOn)
        {
            if(count > 100)
            {
                count = 100
            }
        }
    
        updateTableView()
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
        dismissKeyboard()
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
        dismissKeyboard()
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
        
        countTextField.text = "\(count)"
        dismissKeyboard()
    }
    
    @IBAction func dueDateButtonTapped(_ sender: Any)
    {
        dueDatePicker.date = dueDate.date
        
        isDueDatePickerShown.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
        dismissKeyboard()
    }
    
    @IBAction func dueDatePickerChanged(_ sender: Any)
    {
        dueDate.date = Calendar.current.startOfDay(for: dueDatePicker.date)
    
        updateTableView()
        dismissKeyboard()
    }
    
    @IBAction func dueDateToday(_ sender: Any)
    {
        dueDatePicker.date = Calendar.current.startOfDay(for: Date())
        dueDate.date = Calendar.current.startOfDay(for: Date())
    
        updateTableView()
        dismissKeyboard()
    }
    
    
    @IBAction func dueDateIncreaseWeekTapped(_ sender: Any)
    {
        dueDate.addDays(7)
        dueDatePicker.date = Calendar.current.startOfDay(for: dueDate.date)
        
        updateTableView()
        dismissKeyboard()
    }
    
    @IBAction func dueDateIncreaseMonthTapped(_ sender: Any)
    {
        dueDate.addMonth()
        dueDatePicker.date = Calendar.current.startOfDay(for: dueDate.date)
        
        updateTableView()
        dismissKeyboard()
    }
    
    @IBAction func fridgeSelectButtonTapped(_ sender: Any)
    {
        dismissKeyboard()
    }
    
    @IBAction func notesTextFieldEdited(_ sender: Any)
    {
        //noteTextField.resignFirstResponder()
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
        dismissKeyboard()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        groceryImage = GroceryImage(image: selectedImage)
        pictureButton.setImage(groceryImage?.image(), for: .normal)
        
        enableCompletButton()

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func barcodeScanButtonTapped(_ sender: Any)
    {
        // 구현 필요
        let scannerViewController = ScannerViewController()
        scannerViewController.delegate = self
        present(scannerViewController, animated: true, completion: nil )
        
        dismissKeyboard()
    }
    
    func sendBarcode(_ barcode: String)
    {
        guard barcode.isEmpty == false else { return }
        
        let webAddress = String(format: "http://www.koreannet.or.kr/home/hpisSrchGtin.gs1?gtin=%@", barcode)
        let searchTerm = [("<div class=\"productTit\">","</div>"),
                          ("<div class=\"imgArea\">","</div>")]
        
        WebScrapper.shared.scrapingInfo(webAddress: webAddress, searchStartEnd: searchTerm)
        { [self] (resultString, isSuccess) in
            if(isSuccess)
            {
                // getting title
                if(resultString.count > 0)
                {
                    var trimmedString = resultString[0]
                    trimmedString = WebScrapper.shared.trimmingString(in: trimmedString, trim: "&nbsp;")
                    print(trimmedString)
                    
                    trimmedString = WebScrapper.shared.trimmingString(in: trimmedString, trim: barcode)
                    print(trimmedString)
                    
                    trimmedString = trimmedString.trimmingCharacters(in: .whitespacesAndNewlines)
                    print(trimmedString)
                    
                    self.nameTextField.text = trimmedString
                }
                
                // getting image
                if(resultString.count > 1)
                {
                    var trimmedString = resultString[1]
                    trimmedString = WebScrapper.shared.trimmingString(in: trimmedString, trim: "<img src=\"")
                    print(trimmedString)
                    
                    trimmedString = WebScrapper.shared.trimmingAfterString(in: trimmedString, trim: " width=\"392\" height=\"260\" id=\"detailImage\" />")
                    print(trimmedString)
                    
                    trimmedString = trimmedString.trimmingCharacters(in: .whitespacesAndNewlines)
                    print(trimmedString)
                    
                    let link = trimmedString
                    if let url = URL(string: link)
                    {
                        WebScrapper.shared.downloadImage(from: url, ui: pictureButton)
                    }
                }
            }
            else
            {
                // 바코드 정보를 가져오지 못했습니다.
                print("바코드 정보를 가져오지 못했습니다.")
            }
        } // end of closer
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
                enableCompletButton()
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
                if let grocery = grocery
                {
                    grocery.fridgeName = sourceViewController.fridgeName
                }
            }
        }
    }
    
    @IBAction func completeButtonTapped(_ sender: Any)
    {
        if(isFromShoppingCart)
        {
            performSegue(withIdentifier: "UnwindShopingCartFromAddGrocery", sender: self)
        }
        else
        {
            performSegue(withIdentifier: "UnwindGroceryListFromAddGrocery", sender: self)
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
        if(segue.identifier == "SelectFridgeNameSeque")
        {
            let navController = segue.destination as! UINavigationController
            let controller = navController.topViewController as! SelectFridgeNameTableViewController
            controller.grocery = grocery
            controller.isFromAddGrocery = true
            
            if(grocery == nil)
            {
                if(fridgeSelectButton.title(for: .normal) != nil)
                {
                    controller.fridgeName = fridgeSelectButton.title(for: .normal)!
                }
                else
                {
                    controller.fridgeName = selectedfrideName
                }
            }
            else
            {
                controller.fridgeName = grocery!.fridgeName
            }
        }
    }
    

}
