//
//  FamilyShareViewController.swift
//  FreshFridge
//
//  Created by changae choi on 2021/02/16.
//

import UIKit

class FamilyShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createPublicCode(_ sender: Any)
    {
        ShareManager.shared.startShareAndCreateCode()
    }
    
    @IBAction func enterPublicCode(_ sender: Any)
    {
        var publicCode: String = ""
        let alert = UIAlertController(title: "공유 코드", message: "공유 코드를 입력해주세요.", preferredStyle: .alert)
        alert.addTextField()
        let ok = UIAlertAction(title: "OK", style: .default)
        { (ok) in
            //code
            publicCode = alert.textFields?[0].text ?? ""
            
            ShareManager.shared.startShareWithPublicCode(publicCode: publicCode)
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        { (cancel) in
            //code
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
