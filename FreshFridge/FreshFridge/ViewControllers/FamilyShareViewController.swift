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
        if ShareManager.shared.isCreatedShareCode()
        {
            let alert = UIAlertController(title: "생성 실패", message: "이미 생성한 공유 코드가 존재합니다.(\(ShareManager.shared.createdPublicCode))", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if ShareManager.shared.isShared()
        {
            ShareManager.shared.endShare()
        }
        
        
        let alert = UIAlertController(title: "가족 공유", message: "현재 가지고 있는 데이터를 공유하시겠습니까? '아니요'하면 데이터가 지워집니다.", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default)
        {
            (yes) in
            ShareManager.shared.startShareAndCreateCode()
            {
                // 로컬의 데이터를 서버로 보내고, 로컬 데이터를 전부 지운다.
                DispatchQueue.main.async()
                {
                    print("You are on \(Thread.isMainThread ? "MAIN" : "BACKGROUND") thread.")
                    
                    ShareManager.shared.sendAllLocalData()
                    {
                        DispatchQueue.main.async()
                        {
                            DataManager.shared.removeAllGroceryHistories()
                            DataManager.shared.removeAllCartGroceries()
                            DataManager.shared.removeAllFridgeGroceries()
                            
                            ShareManager.shared.update(true)
                        }
                    }
                }
            }
            
        }
        
        let no = UIAlertAction(title: "No", style: .default)
        { (no) in
            ShareManager.shared.startShareAndCreateCode()
            {
                DispatchQueue.main.async()
                {
                    DataManager.shared.removeAllGroceryHistories()
                    DataManager.shared.removeAllCartGroceries()
                    DataManager.shared.removeAllFridgeGroceries()
                    
                    ShareManager.shared.update(true)
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        { (cancel) in
            //code
        }
        alert.addAction(yes)
        alert.addAction(no)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func enterPublicCode(_ sender: Any)
    {
        if ShareManager.shared.isShared()
        {
            let alert = UIAlertController(title: "사용 중인 공유 코드", message: "\(ShareManager.shared.publicCode)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        var publicCode: String = ""
        let alert = UIAlertController(title: "공유 코드", message: "공유 코드를 입력해주세요.", preferredStyle: .alert)
        alert.addTextField()
        let ok = UIAlertAction(title: "OK", style: .default)
        { (ok) in
            //code
            publicCode = alert.textFields?[0].text ?? ""
            //
            let alert = UIAlertController(title: "가족 공유", message: "현재 가지고 있는 데이터를 공유하시겠습니까? '아니요'하면 데이터가 지워집니다.", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: .default)
            {
                (yes) in
                ShareManager.shared.startShareWithPublicCode(publicCode: publicCode)
                {
                    DispatchQueue.main.async()
                    {
                        print("You are on \(Thread.isMainThread ? "MAIN" : "BACKGROUND") thread.")
                        
                        // 로컬의 데이터를 서버로 보내고, 로컬 데이터를 전부 지운다.
                        ShareManager.shared.sendAllLocalData()
                        {
                            DispatchQueue.main.async()
                            {
                                DataManager.shared.removeAllGroceryHistories()
                                DataManager.shared.removeAllCartGroceries()
                                DataManager.shared.removeAllFridgeGroceries()
                                
                                ShareManager.shared.update(true)
                            }
                        }
                    }
                }
            }
            
            let no = UIAlertAction(title: "No", style: .default)
            { (no) in
                ShareManager.shared.startShareWithPublicCode(publicCode: publicCode)
                {
                    DispatchQueue.main.async()
                    {
                        DataManager.shared.removeAllGroceryHistories()
                        DataManager.shared.removeAllCartGroceries()
                        DataManager.shared.removeAllFridgeGroceries()
                        
                        ShareManager.shared.update(true)
                    }
                }
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            { (cancel) in
                //code
            }
            alert.addAction(yes)
            alert.addAction(no)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        { (cancel) in
            //code
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func resignShare(_ sender: Any)
    {
        if ShareManager.shared.isShared() == false
        {
            return
        }
        
        ShareManager.shared.endShare()
        
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
