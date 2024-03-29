//
//  FamilyShareViewController.swift
//  FreshFridge
//
//  Created by changae choi on 2021/02/16.
//

import UIKit
import Firebase


class FamilyShareViewController: UIViewController {

    
    @IBOutlet weak var SharingCondition: UIImageView!
    
    @IBOutlet weak var createPublicCodeButton: UIButton!
    @IBOutlet weak var enterPublicCodeButton: UIButton!
    @IBOutlet weak var resignShareButton: UIButton!
    @IBOutlet weak var unlockSharingButton: UIButton!
    @IBOutlet weak var restorePurchaseButton: UIButton!
    @IBOutlet weak var publicCodeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRequestManager().familyShareViewController = self

        createPublicCodeButton.layer.cornerRadius = 10
        createPublicCodeButton.clipsToBounds = true
        enterPublicCodeButton.layer.cornerRadius = 10
        enterPublicCodeButton.clipsToBounds = true
        resignShareButton.layer.cornerRadius = 10
        resignShareButton.clipsToBounds = true
        unlockSharingButton.layer.cornerRadius = 10
        unlockSharingButton.clipsToBounds = true
        restorePurchaseButton.layer.cornerRadius = 10
        restorePurchaseButton.clipsToBounds = true
        
        sharingInfo()
        
        // Do any additional setup after loading the view.
    }
    
    func sharingInfo()
    {
        if(IAPManager.shared.isPurchasedSharing())
        {
            createPublicCodeButton.isEnabled = true
            enterPublicCodeButton.isEnabled = true
            //resignShareButton.isEnabled = true
            unlockSharingButton.isEnabled = false
            restorePurchaseButton.isEnabled = false
        }
        else
        {
            createPublicCodeButton.isEnabled = false
            enterPublicCodeButton.isEnabled = false
            //resignShareButton.isEnabled = false
            unlockSharingButton.isEnabled = true
            restorePurchaseButton.isEnabled = true
        }
        
        if ShareManager.shared.isShared()
        {
            SharingCondition.image = UIImage(systemName:"person.2")?.withTintColor(UIColor.systemBlue, renderingMode: .automatic)
            
            SharingCondition.image = SharingCondition.image?.withRenderingMode(.alwaysTemplate)
            SharingCondition.tintColor = UIColor.link
            publicCodeLabel.isHidden = false
            publicCodeLabel.text = "공유 코드".localized() + " : [\(ShareManager.shared.publicCode)]"
            createPublicCodeButton.isEnabled = false
            enterPublicCodeButton.isEnabled = false
            resignShareButton.isEnabled = true
        }
        else
        {
            SharingCondition.image = UIImage(systemName:"person.badge.plus")?.withTintColor(.systemGray, renderingMode: .automatic)
            SharingCondition.image = SharingCondition.image?.withRenderingMode(.alwaysTemplate)
            SharingCondition.tintColor = UIColor.systemGray2
            publicCodeLabel.isHidden = true
            createPublicCodeButton.isEnabled = true
            enterPublicCodeButton.isEnabled = true
            resignShareButton.isEnabled = false
        }
        
        
//        if(ShareManager.shared.isCreatedShareCode())
//        {
//            createPublicCodeButton.isEnabled = false
//        }
//        else
//        {
//            createPublicCodeButton.isEnabled = true
//        }
    }
    
    
    @IBAction func createPublicCode(_ sender: Any)
    {
        if ShareManager.shared.isCreatedShareCode()
        {
            presentAlertOk(title: "[\"%@\"]".localized(with: [ShareManager.shared.createdPublicCode]), message: "이미 생성한 공유 코드가 존재합니다.".localized(), parent: self)
            //sharingInfo()
            return
        }
        
        if ShareManager.shared.isShared()
        {
            presentAlertOk(title: "먼저 공유 취소를 해야합니다.".localized(), parent: self)
            return
        }
        
        Analytics.logEvent("create_sharing", parameters: nil)
        
//        var isSendLocalData: Bool = true
//        if ShareManager.shared.isShared()
//        {
//            //presentAlertOk(title: "공유 취소".localized(), message: "공유를 취소합니다.(%s)".localized(with: [ShareManager.shared.sharedID]), parent: self)
//            ShareManager.shared.endShare()
//
//            isSendLocalData = false
//        }
        
//        if(isSendLocalData)
//        {
        let yes = UIAlertAction(title: "Yes".localized(), style: .default)
            {
                (yes) in
                ShareManager.shared.startShareAndCreateCode()
                {
                    // 로컬의 데이터를 서버로 보내고, 로컬 데이터를 전부 지운다.
                    DispatchQueue.main.async()
                    {
                        print("You are on \(Thread.isMainThread ? "MAIN" : "BACKGROUND") thread.")
                        
                        ShareManager.shared.sendAllLocalData()
                        DataManager.shared.removeAllGroceryHistories()
                        DataManager.shared.removeAllCartGroceries()
                        DataManager.shared.removeAllFridgeGroceries()
                        
                        ShareManager.shared.update(async: false)
                        
                        RequestManager.shared.updateGroceryListViewController(updateTableView: true)
                        RequestManager.shared.updateShopingCartViewController(updateTableView: true)
                        RequestManager.shared.updatePurchaseRecordViewController(updateTableView: true)
                        
                        self.sharingInfo()
                    }
                }
                
            }
            
        let no = UIAlertAction(title: "No".localized(), style: .default)
            { (no) in
                ShareManager.shared.startShareAndCreateCode()
                {
                    DispatchQueue.main.async()
                    {
                        DataManager.shared.removeAllGroceryHistories()
                        DataManager.shared.removeAllCartGroceries()
                        DataManager.shared.removeAllFridgeGroceries()
                        
                        ShareManager.shared.update(async: false)
                        
                        self.sharingInfo()
                    }
                }
            }
            
            presentAlertYesNoCancel(title: "가족 공유".localized(), message: "현재 가지고 있는 데이터를 공유하시겠습니까? '아니요'하면 데이터가 지워집니다.".localized(), parent: self, yes: yes, no: no)
        //}
        /*
        else
        {
            ShareManager.shared.startShareAndCreateCode()
            {
                DispatchQueue.main.async()
                {
                    DataManager.shared.removeAllGroceryHistories()
                    DataManager.shared.removeAllCartGroceries()
                    DataManager.shared.removeAllFridgeGroceries()
                    
                    ShareManager.shared.update(async: false)
                    
                    self.sharingInfo()
                }
            }
        }
        */
        
    }
    
    @IBAction func enterPublicCode(_ sender: Any)
    {
        if ShareManager.shared.isShared()
        {
            presentAlertOk(title: "[\"%@\"]".localized(with: [ShareManager.shared.publicCode]), message: "공유 코드".localized(), parent: self)
            //sharingInfo()
            return
        }
        
        var publicCode: String = ""
        let alert = UIAlertController(title: "코드 입력".localized(), message: "공유 코드를 입력해주세요.".localized(), preferredStyle: .alert)
        alert.addTextField()
        let ok = UIAlertAction(title: "Ok".localized(), style: .default)
        {_ in
            // 공유 코드 가져오기
            publicCode = alert.textFields?[0].text ?? ""
            ShareManager.shared.startShareWithPublicCode(publicCode: publicCode)
            {
                DispatchQueue.main.async()
                {
                    let yes = UIAlertAction(title: "Yes".localized(), style: .default)
                    { (yes) in
                        
                        DispatchQueue.main.async()
                        {
                            print("You are on \(Thread.isMainThread ? "MAIN" : "BACKGROUND") thread.")
                            
                            // 로컬의 데이터를 서버로 보내고, 로컬 데이터를 전부 지운다.
                            ShareManager.shared.sendAllLocalData()
                            DataManager.shared.removeAllGroceryHistories()
                            DataManager.shared.removeAllCartGroceries()
                            DataManager.shared.removeAllFridgeGroceries()
                            
                            ShareManager.shared.update(async: false)
                            
                            RequestManager.shared.updateGroceryListViewController(updateTableView: true)
                            RequestManager.shared.updateShopingCartViewController(updateTableView: true)
                            RequestManager.shared.updatePurchaseRecordViewController(updateTableView: true)
                            
                            //presentAlertOk(title: "가족 공유 성공".localized(), parent: self)
                            self.sharingInfo()
                        }
                        
                    }
                    
                    let no = UIAlertAction(title: "No".localized(), style: .default)
                    { (no) in
                        
                        DispatchQueue.main.async()
                        {
                            DataManager.shared.removeAllGroceryHistories()
                            DataManager.shared.removeAllCartGroceries()
                            DataManager.shared.removeAllFridgeGroceries()
                            
                            ShareManager.shared.update(async: false)
                            
                            //presentAlertOk(title: "가족 공유 성공".localized(), parent: self)
                            self.sharingInfo()
                        }
                    }
                    
                    presentAlertYesNoCancel(title: "가족 공유".localized(), message: "현재 가지고 있는 데이터를 공유하시겠습니까? '아니요'하면 데이터가 지워집니다.".localized(), parent: self, yes: yes, no: no)
                    
                }
            }
        }
        alert.addAction(ok)
        
        let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func resignShare(_ sender: Any)
    {
        if ShareManager.shared.isShared() == false
        {
            //sharingInfo()
            return
        }
        
        presentAlertOkCancel(title: "공유 취소".localized(), message: "공유를 취소하시겠습니까?".localized(), parent: self)
        {_ in 
            ShareManager.shared.endShare()
            {
                DispatchQueue.main.async {
                    //presentAlertOk(title: "가족 공유 취소 성공".localized(), parent: self)
                    self.sharingInfo()
                }
            }
        }
        
    }
    
    
    @IBAction func unlockSharing(_ sender: Any) {
        
        IAPManager.shared.purchaseUnlockSharing()
        
        
        
    }
    
    @IBAction func restorePurchase(_ sender: Any) {
        IAPManager.shared.restoreIAP()
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
