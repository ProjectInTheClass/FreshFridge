//
//  FamilyShareViewController.swift
//  FreshFridge
//
//  Created by changae choi on 2021/02/16.
//

import UIKit



class FamilyShareViewController: UIViewController {

    
    @IBOutlet weak var SharingCondition: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sharingInfo()
        
        // Do any additional setup after loading the view.
    }
    
    func sharingInfo() {
        if ShareManager.shared.isShared() {
            SharingCondition.image = UIImage(systemName:"person.2")?.withTintColor(.systemBlue)
        } else {
            SharingCondition.image = UIImage(systemName:"person.badge.plus")?.withTintColor(.lightGray)
        }
    }
    
    
    @IBAction func createPublicCode(_ sender: Any)
    {
        if ShareManager.shared.isCreatedShareCode()
        {
            presentAlertOk(title: "생성 실패".localized(), message: "이미 생성한 공유 코드가 존재합니다.(%@)".localized(with: [ShareManager.shared.createdPublicCode]), parent: self)
            
            return
        }
        
        if ShareManager.shared.isShared()
        {
            ShareManager.shared.endShare()
        }
        
        
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
                            
                            ShareManager.shared.update(async: false)
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
                    
                    ShareManager.shared.update(async: false)
                }
            }
        }
        
        presentAlertYesNoCancel(title: "가족 공유".localized(), message: "현재 가지고 있는 데이터를 공유하시겠습니까? '아니요'하면 데이터가 지워집니다".localized(), parent: self, yes: yes, no: no)
        sharingInfo()
    }
    
    @IBAction func enterPublicCode(_ sender: Any)
    {
        if ShareManager.shared.isShared()
        {
            presentAlertOk(title: "코드 보기".localized(), message: "사용 중인 공유 코드 (%@)".localized(with: [ShareManager.shared.publicCode]), parent: self)
            
            return
        }
        
        var publicCode: String = ""
        let alert = UIAlertController(title: "코드 입력".localized(), message: "공유 코드를 입력해주세요".localized(), preferredStyle: .alert)
        alert.addTextField()
        let ok = UIAlertAction(title: "OK", style: .default)
        {_ in
            
            // 공유 코드 가져오기
            publicCode = alert.textFields?[0].text ?? ""
            
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
                                
                                ShareManager.shared.update(async: false)
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
                        
                        ShareManager.shared.update(async: false)
                    }
                }
            }
            
            presentAlertYesNoCancel(title: "가족 공유".localized(), message: "현재 가지고 있는 데이터를 공유하시겠습니까? '아니요'하면 데이터가 지워집니다".localized(), parent: self, yes: yes, no: no)
            
            
            
        }
        alert.addAction(ok)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
        sharingInfo()
        
        
    }
    
    
    @IBAction func resignShare(_ sender: Any)
    {
        if ShareManager.shared.isShared() == false
        {
            return
        }
        
        presentAlertOkCancel(title: "공유를 취소하시겠습니까?".localized(), parent: self)
        {_ in 
            ShareManager.shared.endShare()
        }
        sharingInfo()
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
