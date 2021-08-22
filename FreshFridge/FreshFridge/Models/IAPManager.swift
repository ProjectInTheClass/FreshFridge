//
//  IAPManager.swift
//  FreshFridge
//
//  Created by changae choi on 2021/04/05.
//
import StoreKit
import Foundation

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver
{
    static let shared = IAPManager()
    
    private var purchasedSharing = false
    
    private var products = [SKProduct]()
    private var productBeginPurchased: SKProduct?
    
    // product
    enum Product : String, CaseIterable
    {
        case unlockEverything  = "com.codershigh.freshfridge.unlocksharing"
        case removeAds = "com.codershigh.freshfridge.removeAds"
    }
    
    public func isPurchasedSharing() -> Bool
    {
        return purchasedSharing
    }
    
    public func fetchProducts()
    {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({$0.rawValue})))
        request.delegate = self
        request.start()
        
        purchasedSharing = UserDefaults.standard.bool(forKey: "purchasedSharing")
        
        restoreIAP()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
        guard let product = products.first else { return }
        
        print(product.localizedTitle)
        print(product.localizedDescription)
        print(product.price)
        print(product.priceLocale)
        print(product.description)
    }
    // 2021-04-06 02:04:26.229094+0900 FreshFridge[2884:598926] <SKPaymentQueue: 0x280764060>: Payment completed with error: Error Domain=ASDErrorDomain Code=500 "Unhandled exception" UserInfo={NSUnderlyingError=0x280bd9920 {Error Domain=AMSErrorDomain Code=100 "Authentication Failed" UserInfo={NSLocalizedFailureReason=The verify credentials call failed., NSLocalizedDescription=Authentication Failed, NSUnderlyingError=0x280bd97d0 {Error Domain=AMSServerErrorDomain Code=-5000 "작업을 완료할 수 없습니다.(AMSServerErrorDomain 오류 -5000.)" UserInfo={NSLocalizedDescription=작업을 완료할 수 없습니다.(AMSServerErrorDomain 오류 -5000.)}}}}, NSLocalizedFailureReason=An unknown error occurred, NSLocalizedDescription=Unhandled exception}
    public func purchase(product: SKProduct)
    {
        guard SKPaymentQueue.canMakePayments() else { return }
        
        productBeginPurchased = product
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        // no imple
        transactions.forEach ({
            switch $0.transactionState
            {
            case .purchasing:
                print("purchasing")
                break
            case .purchased, .restored:
                print("purchased")
                SKPaymentQueue.default().finishTransaction($0)
                SKPaymentQueue.default().remove(self)
                purchasedSharing = true
                UserDefaults.standard.setValue(purchasedSharing, forKey: "purchasedSharing")
                UserDefaults.standard.synchronize()
                getRequestManager().updateFamilyShareViewController()
                break
            case .failed, .deferred:
                print("did not purchase")
                SKPaymentQueue.default().finishTransaction($0)
                SKPaymentQueue.default().remove(self)
                break
            @unknown default:
                SKPaymentQueue.default().finishTransaction($0)
                SKPaymentQueue.default().remove(self)
                break
            }
        })
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        for transaction in queue.transactions {
                let t: SKPaymentTransaction = transaction
                let prodID = t.payment.productIdentifier as String

                switch prodID {
                case "ProductID1":
                    // implement the given in-app purchase as if it were bought
                    break
                case "ProductID2":
                    // implement the given in-app purchase as if it were bought
                    break
                default:
                    print("iap not found")
                }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        
    }
    
    public func purchaseUnlockSharing()
    {
        guard products.first != nil else { return }
        
        purchase(product: products[0])
    }
    
    public func restoreIAP()
    {
        guard SKPaymentQueue.canMakePayments() else { return }
        
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}
