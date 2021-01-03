//
//  ItemTableViewController.swift
//  TableViewHW
//
//  Created by iM27 on 2020/12/31.
//

import UIKit

var itemsArray: [ItemStruct] = [
    ItemStruct(symbol: "🧅", name: "양파", memo: "다먹으면 표시해놔!", quantity: 5),
    ItemStruct(symbol: "🥬", name: "양배추", memo: "매일 먹자!", quantity: 1),
    ItemStruct(symbol: "🐢", name: "불노장생", memo: "120살 까지!", quantity: 1),
    ItemStruct(symbol: "🍳", name: "계란", memo: "노른자는 반숙이 쵝오", quantity: 30),
    ItemStruct(symbol: "🍔", name: "싸이버거", memo: "맘스터치!", quantity: 2),
    ItemStruct(symbol: "🍎", name: "사과", memo: "아침마다 먹기!", quantity: 10),
    ItemStruct(symbol: "🍖", name: "산적요리", memo: "꼭꼭 씹어먹기!", quantity: 1),
    ItemStruct(symbol: "🍪", name: "블루베리 머핀", memo: "간식!", quantity: 12),
    ItemStruct(symbol: "🥛", name: "우유", memo: "많이 먹으면 오히려 골다공증!", quantity: 2),
    ItemStruct(symbol: "🥐", name: "버터 크로와상", memo: "아침식사!", quantity: 25),
    ItemStruct(symbol: "🫐", name: "블루베리", memo: "눈에 좋단다!", quantity: 2),
    ItemStruct(symbol: "🐷", name: "삼겹살", memo: "적당히 먹어, 살쪄", quantity: 3)
    
]


class ItemTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem

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
        return itemsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCellIdentifier", for: indexPath) as! ItemTableViewCell
        let itemCell = itemsArray[indexPath.row]
        cell.contentUpdate(with: itemCell)
        cell.showsReorderControl = true
        // Configure the cell...
        print("itemCell의 값:" + "\(itemCell)") //itemCell을 프린트 해보면 어레이 안에 내가 코딩해 놓은 값들이 쭉 들어있다. 이걸 위에 있는 contentUpdate 함수를 실행하면서 테이블뷰 셀의 각 레이블에 할당해서 화면에 보여주게 된다.
        print("cell의 값:" + "\(cell)")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movingItemInCell = itemsArray.remove(at: sourceIndexPath.row)
        itemsArray.insert(movingItemInCell, at: destinationIndexPath.row)
        //셀을 선택해서 움직이면 선택한 그 셀의 값은 리무브하고 도착한 목적지 셀에 그 값을 다시 넣어준다. 어레이 배열 순서 값이 바뀌게 되는 것임.
    }

    @IBAction func EditButtonTapped(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            itemsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        // 셀을 지우려면 이 오버라이드도 있어야 한다.
    }

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

    
    @IBAction func unwindToMainView(_ unwindSegue: UIStoryboardSegue) {
        
        guard unwindSegue.identifier == "SaveUnwind",
              let sourceViewController = unwindSegue.source as? AddEditTableViewController,
              let itemNew = sourceViewController.itemAdd else { return }
        //세이브 버튼 눌렀을 때 저장하고 첫화면으로 되돌아 가기
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            itemsArray[selectedIndexPath.row] = itemNew
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: itemsArray.count, section: 0)
            itemsArray.append(itemNew)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditItem" {
            // 세그웨이 identifier에 위 따옴표 속 이름을 입력해줘야 다음 페이지에서 기존내용이 뜬다!
            let indexPath = tableView.indexPathForSelectedRow! // indexPathsForSelectedRows 이 매소드와 다르다 s가 붙었는지 안붙었는지 확인할 것!!!
            let itemForEdit = itemsArray[indexPath.row]
            let navigationController = segue.destination as! UINavigationController
            let addEditItemTableViewController = navigationController.topViewController as! AddEditTableViewController
            
            addEditItemTableViewController.itemAdd = itemForEdit
            // emojiAdd 라는 변수는 AddEditEmoji테이블뷰컨트롤러 파일에 선언되어 있다.
            
        }
    }
    

}
