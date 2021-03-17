//
//  ShareManager.swift
//  FreshFridge
//
//  Created by changae choi on 2021/02/16.
//

import Foundation
import UIKit

class ShareManager
{
    var sharedID: Int
    {
        didSet
        {
            UserDefaults.standard.set(sharedID, forKey: "sharedID")
        }
    }
    var publicCode: String
    {
        didSet
        {
            UserDefaults.standard.set(publicCode, forKey: "publicCode")
        }
    }
    
    var createdPublicCode: String
    {
        didSet
        {
            UserDefaults.standard.set(createdPublicCode, forKey: "createdPublicCode")
        }
    }
            
    var fridgeIDs: [Int] = [-1,-1,-1,-1]
    {
        didSet
        {
            UserDefaults.standard.set(fridgeIDs, forKey: "fridgeIDs")
        }
    }
    
    
    var lastUpdateTime: Date = Date()
    var lastestCartUpdatedAt: Int = -1
    var lastestProductUpdateAt: Int = -1
    var lastestRefriUpdateAt: Int = -1
    
    
    static let shared = ShareManager()
    private init()
    {
        sharedID = UserDefaults.standard.integer(forKey: "sharedID")
        publicCode = UserDefaults.standard.string(forKey: "publicCode") ?? ""
        createdPublicCode = UserDefaults.standard.string(forKey: "createdPublicCode") ?? ""
        //createdPublicCode = ""// test code
        if let fridgeIDs = UserDefaults.standard.array(forKey: "fridgeIDs")
        {
            self.fridgeIDs = fridgeIDs as! [Int]
        }
        //fridgeIDs = [-1,-1,-1,-1] // test code
    }
    
    func isShared() -> Bool
    {
        return publicCode.isEmpty == false
    }
    
    func isCreatedShareCode() -> Bool
    {
        return createdPublicCode.isEmpty == false
    }
    
    
    func getServerURL() -> String {
        /*
        let dictionary = ProcessInfo.processInfo.environment
        if let rootURL = dictionary["ROOT_URL"]
        {
            return rootURL
        }
        */
        //return "http://z.ebadaq.com:45082"
        return "http://freshfridge.cafe24app.com"
    }
    
    func getFridgeID(fridgeName: String) -> Int
    {
        if let frigdeID = fridgeNames.enumerated().first(where: {$0.element == fridgeName})?.offset
        {
            return fridgeIDs[frigdeID]
        }
        else
        {
            return -1
        }
    }
    
    func resetUpdating()
    {
        lastestProductUpdateAt = -1
        lastestCartUpdatedAt = -1
        lastestRefriUpdateAt = -1
    }
    
    func initShareManager()
    {
        if( publicCode.isEmpty == false && getServerURL().isEmpty == false )
        {
            startShareWithPublicCode(publicCode: publicCode)
            {
                DispatchQueue.main.async {
                    ShareManager.shared.update(async: false)
                }
            }
        }
    }
    
    struct RequestCode: Codable
    {
        var createdAt: Int
        var updatedAt: Int
        var id: Int
        var publicCode: String
        
        enum CodingKeys: String, CodingKey
        {
            case createdAt
            case updatedAt
            case id
            case publicCode
        }
        
        init(from decoder: Decoder) throws
        {
            let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.createdAt = try valueContainer.decode(Int.self, forKey: CodingKeys.createdAt)
            self.updatedAt = try valueContainer.decode(Int.self, forKey: CodingKeys.updatedAt)
            self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
            self.publicCode = try valueContainer.decode(String.self, forKey: CodingKeys.publicCode)
        }
    }
    
    func sendAllLocalData()
    {
        // 서버의 구입기록을 가져와서 중복이면 생성요청을 생략한다.
        
        // 서버에서 구입기록을 groceryHistoriesInServer에 가져온다.
        var temp: [GroceryHistory] = []
        for groceryHistory in DataManager.shared.groceryHistories
        {
            temp.insert(groceryHistory, at: temp.count)
        }
        DataManager.shared.groceryHistories.removeAll()
        
        var isRepeat: Bool = true
        while isRepeat {
            isRepeat = !ShareManager.shared.updateAllProduct(async: false, completion: {})
        }
        
        var groceryHistoriesInServer: [GroceryHistory] = []
        for groceryHistory in DataManager.shared.groceryHistories
        {
            groceryHistoriesInServer.insert(groceryHistory, at: groceryHistoriesInServer.count)
        }
        DataManager.shared.groceryHistories = temp
        
        // 냉장고나 카트 아이템이 참조하는 구입기록을 referenceMap에 골라낸다.
        struct GroceryHistoryReferences
        {
            var groceries: [Grocery] = []
            var cartGroceries: [CartGrocery] = []
        }
        
        var referenceMap: [String:GroceryHistoryReferences] = [:]
        
        for grocery in DataManager.shared.getGroceries()
        {
            let key: String = "\(grocery.info.title)\(grocery.info.category.rawValue)"
            //referenceMapForGrocery[key]?.insert(grocery, at: 0)
            if nil == referenceMap[key]
            {
                referenceMap[key] = GroceryHistoryReferences()
            }
            
            referenceMap[key]!.groceries.insert(grocery, at: 0)
            
        }
        
        for cartGrocery in DataManager.shared.getCartGroceries()
        {
            let key: String = "\(cartGrocery.info.title)\(cartGrocery.info.category.rawValue)"
            //referenceMapForCart[key]?.insert(cartGrocery, at: 0)
            if nil == referenceMap[key]
            {
                referenceMap[key] = GroceryHistoryReferences()
            }
            
            referenceMap[key]!.cartGroceries.insert(cartGrocery, at: 0)
        }
        
        // groceryHistory를 서버에 생성 요청한다.
        for groceryHistory in DataManager.shared.getGroceryHistories().reversed()
        {
            // 서버에 같은 목록이 있는지 확인
            if let sameHistory = groceryHistoriesInServer.first(where: { $0.title == groceryHistory.title && $0.category == groceryHistory.category })
            {
                // 서버에 같은 이름, 카테고리 구입기록이 있는 경우
                //print("You are on \(Thread.isMainThread ? "MAIN" : "BACKGROUND") thread.")
                groceryHistory.id = sameHistory.id
                
                DispatchQueue.main.async()
                {
                    if(sameHistory.favorite != groceryHistory.favorite)
                    {
                        self.updateGroceryHistory(id: groceryHistory.id, favorite: groceryHistory.favorite, completion: nil)
                    }
                    
                    // processing image
                    if let image = groceryHistory.image,
                       let uiImage = image.image()
                    {
                        self.uploadImage(image: uiImage, filename: image.filename)
                        {
                            (imageName: String) in
                            image.resetFilename(name: imageName)
                            
                            DispatchQueue.main.async
                            {
                                self.updateGroceryHistory(id: sameHistory.id, image: image)
                                {
                                }
                            }
                        }
                    }
                }
                
            }
            else
            {
                //
                createGroceryHistorySync(title: groceryHistory.title, category: groceryHistory.category)
                {
                    (id: Int) in
                    groceryHistory.id = AutoIncreasedID(id)
                    groceryHistoriesInServer.insert(groceryHistory, at: groceryHistoriesInServer.count)
                    
                    DispatchQueue.main.async()
                    {
                        print("You are on \(Thread.isMainThread ? "MAIN" : "BACKGROUND") thread.")
                        
                        self.updateGroceryHistory(id: groceryHistory.id, favorite: groceryHistory.favorite, completion: nil)
                        
                        // processing image
                        if let image = groceryHistory.image,
                           let uiImage = image.image()
                        {
                            self.uploadImage(image: uiImage, filename: image.filename)
                            {
                                (imageName: String) in
                                
                                DispatchQueue.main.async
                                {
                                    image.resetFilename(name: imageName)
                                    self.updateGroceryHistory(id: AutoIncreasedID(id), image: image)
                                    {
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // grocery 생성을 서버에 요청한다.
        for grocery in DataManager.shared.getGroceries().reversed()
        {
            createGrocery(productID: grocery.info.id.id, count: grocery.count, isPercentageCount: grocery.isPercentageCount, dueDate: grocery.dueDate, storage: grocery.storage, fridgeName: grocery.fridgeName, notes: grocery.notes ?? "", image: grocery.info.image)
        }
        
        // cartGrocery 생성을 서버에 요청한다.
        for cartGrocery in DataManager.shared.getCartGroceries().reversed()
        {
            createCartGrocery(productID: cartGrocery.info.id.id, count: cartGrocery.count, isPercentageCount: cartGrocery.isPercentageCount, isPurchased: cartGrocery.isPurchased)
        }
        
        ShareManager.shared.lastestProductUpdateAt = -1
        ShareManager.shared.lastestCartUpdatedAt = -1
        ShareManager.shared.lastestRefriUpdateAt = -1
        
        NSLog("completed sendAllData")
    }
        
    func startShareAndCreateCode(completion: @escaping (()->Void))
    {
        let subURL = "/requestCode"
        let baseURL = URL(string: getServerURL() + subURL)!
        let task = URLSession.shared.dataTask(with: baseURL)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else
            {
                return
            }
            let error = error
            guard error == nil else
            {
                print("Error occur: \(String(describing: error))")
                return
            }
            
            NSLog("Complete: \(String(describing: response))")
            
            //if let data = data,
            if let requestCode = try? jsonDecoder.decode(RequestCode.self, from: data)
            {
                print(requestCode)
                
                self.sharedID = requestCode.id
                self.publicCode = requestCode.publicCode
                self.createdPublicCode = requestCode.publicCode
                
                
                
                    // 고정으로 냉장고 4개를 만든다
                    ShareManager.shared.createRefrigerator(fridgeIndex: 0)
                    {
                        ShareManager.shared.createRefrigerator(fridgeIndex: 1)
                        {
                            ShareManager.shared.createRefrigerator(fridgeIndex: 2)
                            {
                                ShareManager.shared.createRefrigerator(fridgeIndex: 3)
                                {
                                    completion()
                                }
                            }
                        }
                    }
                
                
                //completion()
            }
        }
        
        task.resume()
    }
    
    func startShareWithPublicCode(publicCode: String, completion: @escaping (()->Void))
    {
        let subURL = "/requestCode"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
                "code": "\(publicCode)",
            ]
        
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            //if let data = data,
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else
            {
                return
            }
            let error = error
            guard error == nil else
            {
                print("Error occur: \(String(describing: error))")
                return
            }
            
            NSLog("Complete: \(String(describing: response))")
            
            if let requestCode = try? jsonDecoder.decode(RequestCode.self, from: data)
            {
                print(requestCode)
                
                self.sharedID = requestCode.id
                self.publicCode = requestCode.publicCode
                
                // 4개 냉장고의 아이디를 가져온다
                
                    self.requestRefrigeratorIDs()
                    {
                        completion()
                    }
                
            }
        }
        
        task.resume()
    }
    
    func endShare(completion: @escaping ()->Void)
    {
        guard isShared() else { return }
        
        
        let subURL = "/resignCode"
        let baseURL = URL(string: getServerURL() + subURL)!
        let task = URLSession.shared.dataTask(with: baseURL)
        { (data, response, error) in
            _ = JSONDecoder()
            //if let data = data,
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else
            {
                return
            }
            let error = error
            guard error == nil else
            {
                print("Error occur: \(String(describing: error))")
                return
            }
            
            NSLog("Complete: \(String(describing: response))")
            
            if let string = String(data: data, encoding: .utf8)
            {
                print(string)
                self.publicCode = ""
                self.sharedID = -1
                
                self.fridgeIDs = [-1,-1,-1,-1]
                
                DataManager.shared.removeAllGroceryHistories()
                DataManager.shared.removeAllCartGroceries()
                DataManager.shared.removeAllFridgeGroceries()
                
                ShareManager.shared.lastestProductUpdateAt = -1
                ShareManager.shared.lastestCartUpdatedAt = -1
                ShareManager.shared.lastestRefriUpdateAt = -1
                
                //self.createdPublicCode = "" // test code
                completion()
            }
        }
        
        task.resume()
    }
    
    func update(async: Bool)
    {
        guard ShareManager.shared.isShared() else { return }
        
        let showLoading = true//!async
        if(showLoading)
        {
            //LoadingHUD.showProgressCircle()
            LoadingHUD.showProgressAnimation()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01)
        {
            // 일정초마다.. 서버로부터 전부 받아서 update
            getRequestManager().isUpdatePurchaseRecord = false
            getRequestManager().isUpdateShopingCart = false
            getRequestManager().isUpdateGroceryList = false
            
            let maxRepeatCount = 100
            
            var isRepeat: Bool = true
            var repeatCount = 0
            while isRepeat
            {
                guard repeatCount < maxRepeatCount else { break }
                isRepeat = !ShareManager.shared.updateAllProduct(async: async)
                {
                    getRequestManager().updatePurchaseRecordViewController(updateTableView: getRequestManager().isUpdatePurchaseRecord)
                }
                                
                repeatCount += 1
            }
            
            isRepeat = true
            repeatCount = 0
            while isRepeat
            {
                guard repeatCount < maxRepeatCount else { break }
                
                isRepeat = !ShareManager.shared.updateAllCartItem(async: async)
                {
                    getRequestManager().updateShopingCartViewController(updateTableView: getRequestManager().isUpdateShopingCart)
                }
                
                repeatCount += 1
            }
            
            isRepeat = true
            repeatCount = 0
            while isRepeat
            {
                guard repeatCount < maxRepeatCount else { break }
                
                isRepeat = !ShareManager.shared.updateAllRefrigeratorItem(async: async)
                {
                    getRequestManager().updateGroceryListViewController(updateTableView: getRequestManager().isUpdateGroceryList)
                }
                
                repeatCount += 1
            }
            
            if(!async)
            {
                getRequestManager().updatePurchaseRecordViewController(updateTableView: getRequestManager().isUpdatePurchaseRecord)
                getRequestManager().updateShopingCartViewController(updateTableView: getRequestManager().isUpdateShopingCart)
                getRequestManager().updateGroceryListViewController(updateTableView: getRequestManager().isUpdateGroceryList)
            }
            
            if(showLoading)
            {
                //LoadingHUD.hideProgressCircle()
                LoadingHUD.hideProgressAnimation()
            }
            
        }
        
        
    }
    
    
    //------------------------------------------------------------------------------
    // GroceryHistory / Product
    struct Product: Codable
    {
        var createdAt: Int// = 0
        var updatedAt: Int// = 0
        var id: Int// = 0
        var title: String //= ""
        var idForShare: Int
        var lastPurchaseDate: String
        var category: Int// = 0
        var favorite: Bool// = false
        var imageCode: String// = ""
        var isDeleted: Bool
        
        enum CodingKeys: String, CodingKey
        {
            case createdAt
            case updatedAt
            case id
            case title
            case idForShare
            case lastPurchaseDate
            case category
            case favorite
            case imageCode
            case isDeleted
        }
        
        init(from decoder: Decoder) throws
        {
            let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.createdAt = try valueContainer.decode(Int.self, forKey: CodingKeys.createdAt)
            self.updatedAt = try valueContainer.decode(Int.self, forKey: CodingKeys.updatedAt)
            self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
            self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
            self.idForShare = try valueContainer.decode(Int.self, forKey: CodingKeys.idForShare)
            self.lastPurchaseDate = try valueContainer.decode(String.self, forKey: CodingKeys.lastPurchaseDate)
            self.category = try valueContainer.decode(Int.self, forKey: CodingKeys.category)
            self.favorite = try valueContainer.decode(Bool.self, forKey: CodingKeys.favorite)
            self.imageCode = try! valueContainer.decode(String.self, forKey: CodingKeys.imageCode)
            self.isDeleted = try valueContainer.decode(Bool.self, forKey: CodingKeys.isDeleted)
        }
    }
    
    func processProductData(async: Bool, data: Data?) -> Bool
    {
        let jsonDecoder = JSONDecoder()
        if let data = data
        {
            print(String(data: data, encoding: .utf8)!)
            
            do
            {
                let products: [ShareManager.Product]? = try jsonDecoder.decode([ShareManager.Product].self, from: data)
                if let products = products
                {
                    for product in products
                    {
                        var isDownloadImage = false
                        if let groceryHistory = DataManager.shared.findGroceryHistory(id: AutoIncreasedID(product.id))
                        {
                            // 기존 groceryHistory update
                            if(groceryHistory.title != product.title)
                            {
                                DataManager.shared.updateGroceryHistory(id: groceryHistory.id, title: product.title)
                            }
                            
                            if(groceryHistory.category.rawValue != product.category)
                            {
                                DataManager.shared.updateGroceryHistory(id: groceryHistory.id, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC)
                                                            
                                getRequestManager().isUpdatePurchaseRecord = true
                                getRequestManager().isUpdateShopingCart = true
                                getRequestManager().isUpdateGroceryList = true
                                
                            }
                            
                            if(groceryHistory.favorite != product.favorite)
                            {
                                DataManager.shared.updateGroceryHistory(id: groceryHistory.id, favorite: product.favorite)
                            }
                            
                            if(product.imageCode.isEmpty == false)
                            {
                                isDownloadImage = true
                                if let image = groceryHistory.image
                                {
                                    if(image.filename == product.imageCode)
                                    {
                                        isDownloadImage = false
                                    }
                                }
                                
                                
                            }
                            
                            if(product.isDeleted)
                            {
                                DataManager.shared.removeGroceryHistory(id: groceryHistory.id)
                                getRequestManager().isUpdatePurchaseRecord = true
                            }
                        }
                        else
                        {
                            if product.isDeleted == false
                            {
                                
                                DataManager.shared.insertGroceryHistory(id: product.id, title: product.title, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC, image: nil, updateDate: false)
                                DataManager.shared.updateGroceryHistory(id: AutoIncreasedID(product.id), favorite: product.favorite)
                                
                                if(product.imageCode.isEmpty == false)
                                {
                                    isDownloadImage = true
                                }
                                
                                getRequestManager().isUpdatePurchaseRecord = true
                            }
                        }
                        
                        if(isDownloadImage)
                        {
                            if let groceryHistory = DataManager.shared.findGroceryHistory(id: AutoIncreasedID(product.id))
                            {
                                if let uiImage = GroceryImage.loadImage(filename: product.imageCode)
                                {
                                    groceryHistory.image = GroceryImage(image: uiImage, filename: product.imageCode)
                                    getRequestManager().isUpdatePurchaseRecord = true
                                    getRequestManager().isUpdateGroceryList = true
                                    getRequestManager().isUpdateShopingCart = true
                                }
                                else
                                {
                                    self.downloadImage(id: product.imageCode)
                                    { (image: UIImage?) in
                                        groceryHistory.image = GroceryImage(image: image, filename: product.imageCode)
                                        GroceryImage.saveImage(image: image, filename: product.imageCode)
                                        
                                        DispatchQueue.main.async {
                                            RequestManager.shared.updatePurchaseRecordViewController(updateTableView: true)
                                            RequestManager.shared.updateShopingCartViewController(updateTableView: true)
                                            RequestManager.shared.updateGroceryListViewController(updateTableView: true)
                                        }
                                    }
                                }
                            }
                        }
                        
                        if(self.lastestProductUpdateAt < product.updatedAt)
                        {
                            self.lastestProductUpdateAt = product.updatedAt
                            print(self.lastestProductUpdateAt)
                        }
                        
                    }
                    
                    var isCompleted = false
                    if(products.count == 0)
                    {
                        isCompleted = true
                    }
                    
                    if(async)
                    {
                        isCompleted = true
                    }
                    
                    //completion(isCompleted)
                    return isCompleted
                }
            }
            catch
            {
                print(error)
                
                // 실패하는 경우 다시 RequestCode를 호출한다.
                startShareWithPublicCode(publicCode: publicCode, completion: {})
                
                //completion(true)
                return true
            }
        }
        
        return true
    }
    
    // return이 false이면 다시 호출함
    func updateAllProduct(async: Bool, completion: @escaping (()->Void)) -> Bool
    {
        guard isShared() else { return false}
        
        let subURL = "/Product"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
                "idForShare": "\(sharedID)",
                "sort":"updatedAt ASC",
                "where": "{\"updatedAt\":{\">\":\(lastestProductUpdateAt)},\"idForShare\":\(sharedID)}"
            ]
        let url = baseURL.withQueries(query)!
        
        if(async)
        {
            let task = URLSession.shared.dataTask(with: url)
            { (data, response, error) in
                
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else
                {
                    return
                }
                let error = error
                guard error == nil else
                {
                    print("Error occur: \(String(describing: error))")
                    return
                }
                
                NSLog("Complete: \(String(describing: response))")
                
                _ = self.processProductData(async: async, data: data)
                completion()
            }
            task.resume()
            
            return true
        }
        else
        {
            let task = URLSession.shared.synchronousDataTask(with: url)
            guard let data = task.0, let response = task.1 as? HTTPURLResponse, response.statusCode == 200 else
            {
                return true
            }
            let error = task.2
            guard error == nil else
            {
                print("Error occur: \(String(describing: error))")
                return true
            }
            return processProductData(async: async, data: data)
        }
    }
    
    
    
    func createGroceryHistory(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, completion: @escaping (((Int) -> Void)))
    {
        let subURL = "/product"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
            "idForShare": "\(sharedID)",
            "title" : title,
            "category" : "\(category.rawValue)",
            "lastPurchaseDate" : "\(DueDate.getTimeIntervalSince1970MS(date: Date()))"
            ]
        
        let url = baseURL.withQueries(query)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // insert json data to the request
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            //if let data = data
            //{
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else
            {
                return
            }
            let error = error
            guard error == nil else
            {
                print("Error occur: \(String(describing: error))")
                return
            }
            
            NSLog("Complete: \(String(describing: response))")
            
            print(String(data: data, encoding: .utf8)!)
            do
            {
                let product: ShareManager.Product? = try jsonDecoder.decode(ShareManager.Product.self, from: data)
                if let product = product
                {
                    print(product)
                    
                    completion(product.id)
                }
            }
            catch
            {
                print(error)
            }
            //}
        }
        
        task.resume()
    }
    
    func createGroceryHistorySync(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, completion: @escaping (((Int) -> Void)))
    {
        let subURL = "/product"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
            "idForShare": "\(sharedID)",
            "title" : title,
            "category" : "\(category.rawValue)",
            "lastPurchaseDate" : "\(DueDate.getTimeIntervalSince1970MS(date: Date()))"
            ]
        
        let url = baseURL.withQueries(query)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // insert json data to the request
        //let task = URLSession.shared.dataTask(with: request)
        //{ (data, response, error) in
        let task = URLSession.shared.synchronousDataTask(with: request)
        guard let data = task.0, let response = task.1 as? HTTPURLResponse, response.statusCode == 200 else
        {
            return
        }
        let error = task.2
        guard error == nil else
        {
            print("Error occur: \(String(describing: error))")
            return
        }
        let jsonDecoder = JSONDecoder()
        print(String(data: data, encoding: .utf8)!)
        do
        {
            let product: ShareManager.Product? = try jsonDecoder.decode(ShareManager.Product.self, from: data)
            if let product = product
            {
                print(product)
                
                completion(product.id)
            }
        }
        catch
        {
            print(error)
        }
    }
    
    func createGroceryHistoryForCart(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, count: Int = 1, isPercentageCount: Bool = false, isPurchased: Bool = false, completion2: (((ShareManager.CartItem) -> Void)?) = nil)
    {
        createGroceryHistory(title: title, category: category)
        { (id: Int) in
            
            // insert grocery history
            DataManager.shared.insertGroceryHistory(id: id, title: title, category: category, image: image, updateDate: true)
            
            // processing image
            if let image = image,
               let uiImage = image.image()
            {
                self.uploadImage(image: uiImage, filename: image.filename)
                {
                    (imageName: String) in
                    DispatchQueue.main.async
                    {
                        image.resetFilename(name: imageName)
                        self.updateGroceryHistory(id: AutoIncreasedID(id), image: image)
                        {
                        }
                    }
                }
            }
            
            // create cart grocery
            ShareManager.shared.createCartGrocery(productID: id, count: count, isPercentageCount: isPercentageCount, isPurchased: isPurchased, completion: completion2)
        }
    }
    
    func createGroceryHistoryForRefri(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Grocery.Storage, fridgeName: String, notes: String, completion2: (((ShareManager.RefrigeratorItem) -> Void)?) = nil)
    {
        createGroceryHistory(title: title, category: category, image: image)
        { (id: Int) in
            DataManager.shared.insertGroceryHistory(id: id, title: title, category: category, image: image, updateDate: true)
            
            // processing image
            if let image = image,
               let uiImage = image.image()
            {
                self.uploadImage(image: uiImage, filename: image.filename)
                {
                    (imageName: String) in
                    
                    DispatchQueue.main.async
                    {
                        image.resetFilename(name: imageName)
                        self.updateGroceryHistory(id: AutoIncreasedID(id), image: image)
                        {
                        }
                        
                    }
                }
            }
            
            //
            ShareManager.shared.createGrocery(productID: id, count: count, isPercentageCount: isPercentageCount, dueDate: dueDate, storage: storage, fridgeName: fridgeName, notes: notes, image: image, completion: completion2)
        }
    }
    
    func deleteGroceryHistory(id: AutoIncreasedID, completion: (()->Void)?)
    {
        let json: [String: Any] = ["isDeleted" : true]
        updateGroceryHistory(id: id, json: json)
        {
            DataManager.shared.removeGroceryHistory(id: id)

            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateGroceryHistory(id: AutoIncreasedID, json: [String: Any], completion: ((()->Void)?) = nil)
    {
        //if let foundGroceryHistory = DataManager.shared.findGroceryHistory(id: id)
        //{
            let subURL = "/product/\(id.id)"
            let baseURL = URL(string: self.getServerURL() + subURL)!
            let query: [String: String] = [
                "idForShare": "\(self.sharedID)"
                ]
            
            let url = baseURL.withQueries(query)!
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request)
            { (data, response, error) in
                guard error == nil else {
                    print("Error occur: \(String(describing: error))")
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }
                
                // 통신에 성공한 경우 data에 Data 객체가 전달됩니다.
                print(String(data: data, encoding: .utf8)!)

                let jsonDecoder = JSONDecoder()
                let productItem: ShareManager.Product? = try? jsonDecoder.decode(ShareManager.Product.self, from: data)
                
                if let _ = productItem
                {
                    if let completion = completion
                    {
                        completion()
                    }
                }
            }
            
            task.resume()
//        }
//        else
//        {
//            NSLog("findGroceryHistory 실패")
//        }
        
    }
   
    
    func updateGroceryHistory(id: AutoIncreasedID, lastPurchaseDate: Date, completion: (()->Void)?)
    {
        let json: [String: Any] = ["lastPurchaseDate" : "\(DueDate.getTimeIntervalSince1970MS(date: lastPurchaseDate))"]
        if let groceryHistory = DataManager.shared.findGroceryHistory(id: id)
        {
            updateGroceryHistory(id: id, json: json)
            {
                DataManager.shared.moveToTheFrontGroceryHistory(groceryHistory: groceryHistory)

                if let completion = completion
                {
                    completion()
                }
            }
        }
    }
    
    func updateGroceryHistory(id: AutoIncreasedID, title: String, completion: (()->Void)?)
    {
        let json: [String: Any] = ["title" : title]
        updateGroceryHistory(id: id, json: json)
        {
            DataManager.shared.updateGroceryHistory(id: id, title: title)

            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateGroceryHistory(id: AutoIncreasedID, category: GroceryHistory.Category, completion: (()->Void)?)
    {
        let json: [String: Any] = ["category" : category.rawValue]
        updateGroceryHistory(id: id, json: json)
        {
            DataManager.shared.updateGroceryHistory(id: id, category: category)
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateGroceryHistory(id: AutoIncreasedID, image: GroceryImage?, completion: (()->Void)?)
    {
        let json: [String: Any] = ["imageCode" : image!.filename]
        updateGroceryHistory(id: id, json: json)
        {
            DataManager.shared.updateGroceryHistory(id: id, image: image)
            if let completion = completion
            {
                completion()
                NSLog("completed updateGroceryHistory(imageCode)")
            }
        }
    }
    
    func updateGroceryHistory(id: AutoIncreasedID, favorite: Bool, completion: (()->Void)?)
    {
        let json: [String: Any] = ["favorite" : favorite]
        updateGroceryHistory(id: id, json: json)
        {
            DataManager.shared.updateGroceryHistory(id: id, favorite: favorite)
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func downloadImage(id: String, completion: @escaping ((UIImage?)->Void))
    {
        if let uiImage = UIImage(named: id)
        {
            completion(uiImage)
            return
        }
        
        let subURL = "/image/show/\(id)"
        guard let url = URL(string: self.getServerURL() + subURL) else
        {
            print("downloadImage url error"+"("+self.getServerURL()+subURL+")")
            return
        }
        
        print("Download Started")
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            //print(String(data: data, encoding: .utf8)!)
            print(response.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            
            completion(UIImage(data: data))
        }
        task.resume()
    }
    
    func uploadImage(image: UIImage, filename: String, completion: @escaping ((String)->Void) )
    {
        if let _ = UIImage(named: filename)
        {
            completion(filename)
            return
        }

        
        let subURL = "/image/uploader"
        let baseURL = URL(string: self.getServerURL() + subURL)!
        
        let url = baseURL
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else// (imageData == nil)
        {
            print("UIImageJPEGRepresentation return nil")
            return
        }

        let body = NSMutableData()
        body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        //body.append(NSString(format:"Content-Disposition: form-data; name=\"grocery_img\"; filename=\"%@\"\r\n", filename).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n", filename).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(NSString(format: "Content-Type: image/jpg\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(imageData)
        body.append(NSString(format: "\r\n--%@--\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)

        request.httpBody = body as Data
        request.setValue(String(body.length), forHTTPHeaderField: "Content-Length")

        let task =  URLSession.shared.dataTask(with: request as URLRequest, completionHandler:
        //session.uploadTask(with: urlRequest, from: data, completionHandler:
        {
            (data, response, error) -> Void in
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else
            {
                return
            }
            let error = error
            guard error == nil else
            {
                print("Error occur: \(String(describing: error))")
                return
            }
            
            NSLog("Complete: \(String(describing: response))")
            
           // do what you want in success case
            if let imageName = String(data: data, encoding: .utf8)
            {
                print(imageName)
                
                completion(imageName)
            }
            
        })

        task.resume()
    }
    
    //------------------------------------------------------------------------------
    // grocery / refriItem
    struct RefrigeratorItem: Decodable // RefriItem과는 product가 다름
    {
        var createdAt: Int
        var updatedAt: Int
        var id: Int
        var count: Int
        var isPercentageCount: Bool
        var dueDate: String
        var storage: Int
        var fridgeName: String
        var notes: String
        var product: Product?
        var isDeleted: Bool
        
        enum CodingKeys: String, CodingKey
        {
            case createdAt
            case updatedAt
            case id
            case count
            case isPercentageCount
            case dueDate
            case storage
            case fridgeName
            case notes
            case product
            case isDeleted
        }
        
        init(from decoder: Decoder) throws
        {
            let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.createdAt = try valueContainer.decode(Int.self, forKey: CodingKeys.createdAt)
            self.updatedAt = try valueContainer.decode(Int.self, forKey: CodingKeys.updatedAt)
            self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
            self.count = try valueContainer.decode(Int.self, forKey: CodingKeys.count)
            self.isPercentageCount = try valueContainer.decode(Bool.self, forKey: CodingKeys.isPercentageCount)
            self.dueDate = try valueContainer.decode(String.self, forKey: CodingKeys.dueDate)
            self.storage = try valueContainer.decode(Int.self, forKey: CodingKeys.storage)
            self.fridgeName = try valueContainer.decode(String.self, forKey: CodingKeys.fridgeName)
            self.notes = try valueContainer.decode(String.self, forKey: CodingKeys.notes)
            self.product = try valueContainer.decodeIfPresent(ShareManager.Product.self, forKey: CodingKeys.product)
            self.isDeleted = try valueContainer.decode(Bool.self, forKey: CodingKeys.isDeleted)
        }
    }
    
    func processRefrigeratorItemData(async: Bool, data: Data?) -> Bool
    {
        let jsonDecoder = JSONDecoder()
        if let data = data
        {
            print(String(data: data, encoding: .utf8)!)
            
            do
            {
                let refriItems: [ShareManager.RefrigeratorItem]? = try jsonDecoder.decode([ShareManager.RefrigeratorItem].self, from: data)
                if let refriItems = refriItems
                {
                    print(refriItems)
                    
                    for refriItem in refriItems
                    {
                        if let product = refriItem.product
                        {
                            if let grocery = DataManager.shared.findGrocery(id: AutoIncreasedID(refriItem.id))
                            {
                                // updating
                                if(grocery.count != refriItem.count)
                                {
                                    DataManager.shared.updateGrocery(id: grocery.id, count: refriItem.count)
                                }
                                
                                if(grocery.isPercentageCount != refriItem.isPercentageCount)
                                {
                                    DataManager.shared.updateGrocery(id: grocery.id, isPercentageCount: refriItem.isPercentageCount)
                                }
                                
                                //if(Int(grocery.dueDate.date.timeIntervalSince1970) * 1000 != Int(refriItem.dueDate))
                                if(grocery.dueDate.getTimeIntervalSince1970MS() != Int(refriItem.dueDate))
                                {
                                    DataManager.shared.updateGrocery(id: grocery.id, dueDate: DueDate(timeIntervalSince1970MS: Int(refriItem.dueDate) ?? 0))
                                }
                                
                                if(grocery.storage.rawValue != refriItem.storage)
                                {
                                    DataManager.shared.updateGrocery(id: grocery.id, storage: Grocery.Storage(rawValue: refriItem.storage) ?? Grocery.Storage.Refrigeration)
                                }
                                
                                if(grocery.fridgeName != refriItem.fridgeName)
                                {
                                    DataManager.shared.updateGrocery(id: grocery.id, fridgeName: refriItem.fridgeName)
                                }
                                
                                if(grocery.notes != refriItem.notes)
                                {
                                    DataManager.shared.updateGrocery(id: grocery.id, notes: refriItem.notes)
                                }
                                
                                // groceryHistory
                                if(grocery.info.title != product.title)
                                {
                                    DataManager.shared.updateGrocery(id: grocery.id, title: product.title)
                                }
                                
                                if(grocery.info.category.rawValue != product.category)
                                {
                                    //cartGrocery.info.category = category
                                    DataManager.shared.updateGroceryHistory(id: grocery.info.id, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC)
                                    
                                    getRequestManager().isUpdatePurchaseRecord = true
                                    getRequestManager().isUpdateShopingCart = true
                                    getRequestManager().isUpdateGroceryList = true
                                }
                                
                                if(refriItem.isDeleted)
                                {
                                    DataManager.shared.removeGrocery(id: grocery.id)
                                    getRequestManager().isUpdateGroceryList = true
                                }
                            }
                            else
                            {
                                if refriItem.isDeleted == false
                                {
                                
                                    // adding
                                    DataManager.shared.insertGrocery(id: refriItem.id, title: product.title,
                                                                  category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC,
                                                                  count: refriItem.count,
                                                                  isPercentageCount: refriItem.isPercentageCount,
                                                                  dueDate: DueDate(timeIntervalSince1970MS: Int(refriItem.dueDate) ?? 0),
                                                                  storage: Grocery.Storage(rawValue: refriItem.storage) ?? Grocery.Storage.Refrigeration,
                                                                  fridgeName: refriItem.fridgeName,
                                                                  notes: refriItem.notes,
                                                                  image: nil)
                                    
                                    getRequestManager().isUpdateGroceryList = true
                                }
                            }
                        }
                        
                        if(self.lastestRefriUpdateAt < refriItem.updatedAt)
                        {
                            self.lastestRefriUpdateAt = refriItem.updatedAt
                            print(self.lastestRefriUpdateAt)
                        }
                        
                        
                    } // end of for
                    
                    var isCompleted = false
                    if(refriItems.count == 0)
                    {
                        isCompleted = true
                    }
                    
                    if(async)
                    {
                        isCompleted = true
                    }
                    //completion(isCompleted)
                    return isCompleted
                }
            }
            catch
            {
                print(error)
                
                // 실패하는 경우 다시 RequestCode를 호출한다.
                startShareWithPublicCode(publicCode: publicCode, completion: {})
                
                // completion(true)
                return true
            }
        }
        
        return true
    }
    
    func updateAllRefrigeratorItem(async: Bool, completion: @escaping (()->Void)) -> Bool
    {
        guard isShared() else { return false}
        
        let subURL = "/RefriItem"
        let baseURL = URL(string: getServerURL() + subURL)!
        for frigdeID in fridgeIDs
        {
            guard frigdeID != -1 else { continue }
            
            let query: [String: String] = [
                    "idForRefri": "\(frigdeID)",
                    "sort":"updatedAt ASC",
                    "where": "{\"updatedAt\":{\">\":\(lastestRefriUpdateAt)},\"idForRefri\":\(frigdeID)}"
                ]
            
            let url = baseURL.withQueries(query)!
            print(url)
            
            if(async)
            {
                let task = URLSession.shared.dataTask(with: url)
                { (data, response, error) in
                    
                    guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else
                    {
                        return
                    }
                    let error = error
                    guard error == nil else
                    {
                        print("Error occur: \(String(describing: error))")
                        return
                    }
                    
                    NSLog("Complete: \(String(describing: response))")
                    
                    _ = self.processRefrigeratorItemData(async: async, data: data)
                    completion()
                }
                task.resume()
                
                return true
            }
            else
            {
                let task = URLSession.shared.synchronousDataTask(with: url)
                guard let data = task.0, let response = task.1 as? HTTPURLResponse, response.statusCode == 200 else
                {
                    return true
                }
                let error = task.2
                guard error == nil else
                {
                    print("Error occur: \(String(describing: error))")
                    return true
                }
                return processRefrigeratorItemData(async: async, data: data)
            }
        }
        
        return true
    } // end of func
    
    func createGrocery(productID: Int, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Grocery.Storage, fridgeName: String, notes: String, image: GroceryImage?, completion: (((RefrigeratorItem)->Void)?) = nil)
    {
        guard isShared() else { return }
        
        getRequestManager().isUpdateGroceryList = false
        
        let subURL = "/RefriItem"
        let baseURL = URL(string: getServerURL() + subURL)!
        if let frigdeID = fridgeNames.enumerated().first(where: {$0.element == fridgeName})?.offset
        {
            guard fridgeIDs[frigdeID] != -1 else { return }
            
            let query: [String: String] = [
                "idForRefri": "\(fridgeIDs[frigdeID])",
                "product": "\(productID)",
                "count":"\(count)",
                "isPercentageCount":"\(isPercentageCount)",
                "dueDate":"\(dueDate.getTimeIntervalSince1970MS())",
                "storage":"\(storage.rawValue)",
                "fridgeName":fridgeName,
                "notes":notes.isEmpty ? "\"\"" : notes,
                ]
            
            let url = baseURL.withQueries(query)!
            print(url)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request)
            { (data, response, error) in
                
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else
                {
                    return
                }
                let error = error
                guard error == nil else
                {
                    print("Error occur: \(String(describing: error))")
                    return
                }
                
                NSLog("Complete: \(String(describing: response))")
                
                let jsonDecoder = JSONDecoder()
                //if let data = data
                //{
                    print(String(data: data, encoding: .utf8)!)
                    
                    do
                    {
                        let refriItem: ShareManager.RefrigeratorItem? = try jsonDecoder.decode(ShareManager.RefrigeratorItem.self, from: data)
                        if let refriItem = refriItem
                        {
                            print(refriItem)
                                
                            if let _ = refriItem.product
                            {
                                if let completion = completion
                                {
                                    completion(refriItem)
                                }
                            }
                            
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                //}
            }
            
            task.resume()
       }
    }
    
    func deleteGrocery(id: AutoIncreasedID, completion: ((()->Void)?) = nil)
    {
        let json: [String: Any] = ["isDeleted" : true]
        updateGrocery(id: id, json: json)
        {
            DataManager.shared.removeGrocery(id: id)
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, json: [String: Any], completion: ((()->Void)?))
    {
        if let foundGrocery = DataManager.shared.findGrocery(id: id)
        {
            let subURL = "/RefriItem/\(foundGrocery.id.id)"
            let baseURL = URL(string: self.getServerURL() + subURL)!
            let query: [String: String] = [
                "idForRefri": "\(getFridgeID(fridgeName: foundGrocery.fridgeName))"
                ]
            
            let url = baseURL.withQueries(query)!
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request)
            { (data, response, error) in
                guard error == nil else
                {
                    print("Error occur: \(String(describing: error))")
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else
                {
                    return
                }
                
                // 통신에 성공한 경우 data에 Data 객체가 전달됩니다.
                print(String(data: data, encoding: .utf8)!)

                let jsonDecoder = JSONDecoder()
                let refriItem: ShareManager.RefrigeratorItem? = try? jsonDecoder.decode(ShareManager.RefrigeratorItem.self, from: data)
                
                if refriItem != nil
                {
                    if let completion = completion
                    {
                        completion()
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    func updateGrocery(id: AutoIncreasedID, count: Int, completion: ((()->Void)?))
    {
        let json: [String: Any] = ["count" : count]
        updateGrocery(id: id, json: json)
        {
            DataManager.shared.updateGrocery(id: id, count: count)
            
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, isPercentageCount: Bool, completion: ((()->Void)?))
    {
        let json: [String: Any] = ["isPercentageCount" : isPercentageCount]
        updateGrocery(id: id, json: json)
        {
            DataManager.shared.updateGrocery(id: id, isPercentageCount: isPercentageCount)
            
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, dueDate: DueDate, completion: ((()->Void)?))
    {
        let json: [String: Any] = ["dueDate" : "\(dueDate.getTimeIntervalSince1970MS())"]
        updateGrocery(id: id, json: json)
        {
            DataManager.shared.updateGrocery(id: id, dueDate: dueDate)
            
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, storage: Grocery.Storage, completion: ((()->Void)?))
    {
        let json: [String: Any] = ["storage" : storage.rawValue]
        updateGrocery(id: id, json: json)
        {
            DataManager.shared.updateGrocery(id: id, storage: storage)
            
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, fridgeName: String, completion: ((()->Void)?))
    {
        let json: [String: Any] = ["fridgeName" : fridgeName]
        updateGrocery(id: id, json: json)
        {
            DataManager.shared.updateGrocery(id: id, fridgeName: fridgeName)
            
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, notes:String?, completion: ((()->Void)?))
    {
        if let notes = notes
        {
            let json: [String: Any] = ["notes" : notes]
            updateGrocery(id: id, json: json)
            {
                DataManager.shared.updateGrocery(id: id, notes: notes)
                
                if let completion = completion
                {
                    completion()
                }
            }
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, title: String, completion: (()->Void)?)
    {
        let json: [String: Any] = ["title" : title]
        
        if let grocery = DataManager.shared.findGrocery(id: id)
        {
            updateGroceryHistory(id: grocery.info.id, json: json)
            {
                DataManager.shared.updateGrocery(id: id, title: title)

                if let completion = completion
                {
                    completion()
                }
            }
        }
    }
    
    //------------------------------------------------------------------------------
    // cartGrocery / CartItem
    struct CartItem: Codable
    {
        var createdAt: Int
        var updatedAt: Int
        var id: Int
        var isPurchased: Bool
        var count: Int
        var isPercentageCount: Bool
        var product: Product?// = Product()
        var isDeleted: Bool
        
        enum CodingKeys: String, CodingKey
        {
            case createdAt
            case updatedAt
            case id
            case isPurchased
            case count
            case isPercentageCount
            case product
            case isDeleted
        }
        
        init(from decoder: Decoder) throws
        {
            let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.createdAt = try valueContainer.decode(Int.self, forKey: CodingKeys.createdAt)
            self.updatedAt = try valueContainer.decode(Int.self, forKey: CodingKeys.updatedAt)
            self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
            self.isPurchased = try valueContainer.decode(Bool.self, forKey: CodingKeys.isPurchased)
            self.count = try valueContainer.decode(Int.self, forKey: CodingKeys.count)
            self.isPercentageCount = try valueContainer.decode(Bool.self, forKey: CodingKeys.isPercentageCount)
            self.product = try valueContainer.decodeIfPresent(Product.self, forKey: CodingKeys.product)
            self.isDeleted = try valueContainer.decode(Bool.self, forKey: CodingKeys.isDeleted)
        }
    }
    
    func processCartItemData(async: Bool, data: Data?) -> Bool
    {
        let jsonDecoder = JSONDecoder()
        if let data = data
        {
            //print(String(data: data, encoding: .utf8)!)
            
            do
            {
                let cartItems: [ShareManager.CartItem]? = try jsonDecoder.decode([ShareManager.CartItem].self, from: data)
                if let cartItems = cartItems
                {
                    //print(cartItems)
                    
                    for cartItem in cartItems
                    {
                        if let product = cartItem.product
                        {
                            if let cartGrocery = DataManager.shared.findCartGrocery(id: AutoIncreasedID(cartItem.id))
                            {
                                // 기존 cartGrocery update
                                if(cartGrocery.count != cartItem.count)
                                {
                                    DataManager.shared.updateCartGrocery(id: cartGrocery.id, count: cartItem.count)
                                }
                                
                                if(cartGrocery.isPercentageCount != cartItem.isPercentageCount)
                                {
                                    DataManager.shared.updateCartGrocery(id: cartGrocery.id, isPercentage: cartItem.isPercentageCount)
                                }
                                
                                if(cartGrocery.isPurchased != cartItem.isPurchased)
                                {
                                    DataManager.shared.updateCartGrocery(id: cartGrocery.id, isPurchased: cartItem.isPurchased)
                                }
                                
                                // groceryHistory
                                if(cartGrocery.info.title != product.title)
                                {
                                    DataManager.shared.updateGroceryHistory(id: cartGrocery.info.id, title: product.title)
                                }
                                
                                if(cartGrocery.info.category.rawValue != product.category)
                                {
                                    //cartGrocery.info.category = category
                                    DataManager.shared.updateGroceryHistory(id: cartGrocery.info.id, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC)
                                    
                                    getRequestManager().isUpdatePurchaseRecord = true
                                    getRequestManager().isUpdateShopingCart = true
                                    getRequestManager().isUpdateGroceryList = true
                                }
                                
                                
                                
                                if(cartItem.isDeleted)
                                {
                                    DataManager.shared.removeCartGrocery(id: cartGrocery.id)
                                    getRequestManager().isUpdateShopingCart = true
                                }
                            }
                            else
                            {
                                if cartItem.isDeleted == false
                                {
                                                                    
                                    // 없는 경우 새로 추가
                                    DataManager.shared.insertCartGrocery(title: product.title, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC, image: nil,
                                                                                   id: cartItem.id, count: cartItem.count, isPercentageCount: cartItem.isPercentageCount, isPurchased: cartItem.isPurchased)
                                    getRequestManager().isUpdateShopingCart = true
                                }
                            }
                            
                            
                        }
                        
                        if(self.lastestCartUpdatedAt < cartItem.updatedAt)
                        {
                            self.lastestCartUpdatedAt = cartItem.updatedAt
                            print(self.lastestCartUpdatedAt)
                        }
                        
                    } // end of for
                    
                    var isCompleted = false
                    if(cartItems.count == 0)
                    {
                        isCompleted = true
                    }
                    
                    if(async)
                    {
                        isCompleted = true
                    }
                    //completion(isCompleted)
                    
                    return isCompleted
                }
            }
            catch
            {
                print(error)
                
                // 실패하는 경우 다시 RequestCode를 호출한다.
                startShareWithPublicCode(publicCode: publicCode, completion: {})
                
                //completion(true)
                return true
            }
        }
        
        return true
    }
    
    func updateAllCartItem(async:Bool, completion: @escaping (()->Void)) -> Bool
    {
        guard isShared() else { return false }
        
        let subURL = "/cartItem"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
                "idForShare": "\(sharedID)",
                "sort":"updatedAt ASC",
                "where": "{\"updatedAt\":{\">\":\(lastestCartUpdatedAt)},\"idForShare\":\(sharedID)}"
            ]
        
        let url = baseURL.withQueries(query)!
        
        if(async)
        {
            let task = URLSession.shared.dataTask(with: url)
            {
                (data, response, error) in
                
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else
                {
                    return
                }
                let error = error
                guard error == nil else
                {
                    print("Error occur: \(String(describing: error))")
                    return
                }
                
                NSLog("Complete: \(String(describing: response))")
                
                _ = self.processCartItemData(async: async, data: data)
                completion()
            }
            task.resume()
            
            return true
        }
        else
        {
            let task = URLSession.shared.synchronousDataTask(with: url)
            guard let data = task.0, let response = task.1 as? HTTPURLResponse, response.statusCode == 200 else
            {
                return true
            }
            let error = task.2
            guard error == nil else
            {
                print("Error occur: \(String(describing: error))")
                return true
            }
            return processCartItemData(async: async, data: data)
        }
    }
    
    func createCartGrocery(productID: Int, count: Int = 1, isPercentageCount: Bool = false, isPurchased: Bool = false, completion: (((ShareManager.CartItem)->Void)?) = nil)
    {
        // product를 추가하고 id를 받아서 cartitem을 추가한다.
        // add cartitem to server
        let subURL = "/cartItem"
        let baseURL = URL(string: self.getServerURL() + subURL)!
        let query: [String: String] = [
            "idForShare": "\(self.sharedID)"
            ]
        
        let url = baseURL.withQueries(query)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // insert json data to the request
        let json: [String: Any] = ["product" : productID,
                                   "count" : count,
                                   "isPurchased" : isPurchased ? "true" : "false",
                                   "isPercentageCount" : isPercentageCount ? "true" : "false"
                                    ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            //if let data = data
            //{
                
                guard error == nil else {
                    print("Error occur: \(String(describing: error))")
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }
                
                // 통신에 성공한 경우 data에 Data 객체가 전달됩니다.
                print(String(data: data, encoding: .utf8)!)

                do
                {
                    let cartItem: ShareManager.CartItem? = try jsonDecoder.decode(ShareManager.CartItem.self, from: data)
                    
                        //print(cartItems!)
                        
                        if let cartItem = cartItem
                        {
                            if cartItem.product != nil
                            {
                                if let completion = completion
                                {
                                    completion(cartItem)
                                }
                            }
                        }
                    
                }
                catch
                {
                    print(error)
                }
            
        }
        
        task.resume()
    }
    
    func deleteCartGrocery(id: AutoIncreasedID, completion: ((()->Void)?) = nil)
    {
        let json: [String: Any] = ["isDeleted" : true]
        updateCartGrocery(id: id, json: json)
        {
            DataManager.shared.removeCartGrocery(id: id)
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateCartGrocery(id: AutoIncreasedID, json: [String: Any], completion: ((()->Void)?))
    {
        if let foundCartGrocery = DataManager.shared.findCartGrocery(id: id)
        {
            let subURL = "/cartItem/\(foundCartGrocery.id.id)"
            let baseURL = URL(string: self.getServerURL() + subURL)!
            let query: [String: String] = [
                "idForShare": "\(self.sharedID)"
                ]
            
            let url = baseURL.withQueries(query)!
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request)
            { (data, response, error) in
                guard error == nil else {
                    print("Error occur: \(String(describing: error))")
                    return
                }

                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }
                
                // 통신에 성공한 경우 data에 Data 객체가 전달됩니다.
                print(String(data: data, encoding: .utf8)!)

                let jsonDecoder = JSONDecoder()
                let cartItem: ShareManager.CartItem? = try? jsonDecoder.decode(ShareManager.CartItem.self, from: data)
                
                if cartItem != nil
                {
                    if let completion = completion
                    {
                        completion()
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    func updateCartGrocery(id: AutoIncreasedID, isPurchased: Bool, completion: (()->Void)?)
    {
        let json: [String: Any] = ["isPurchased" : isPurchased ? "true" : "false"]
        updateCartGrocery(id: id, json: json)
        {
            DataManager.shared.updateCartGrocery(id: id, isPurchased: isPurchased)
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateCartGrocery(id: AutoIncreasedID, count: Int, completion: (()->Void)?)
    {
        let json: [String: Any] = ["count" : count]
        updateCartGrocery(id: id, json: json)
        {
            DataManager.shared.updateCartGrocery(id: id, count: count)
            
            if let completion = completion
            {
                completion()
            }
        }
    }
    
    func updateCartGrocery(id: AutoIncreasedID, isPercentage: Bool, completion: (()->Void)?)
    {
        let json: [String: Any] = ["isPercentageCount" : isPercentage ? "true" : "false"]
        updateCartGrocery(id: id, json: json)
        {
            DataManager.shared.updateCartGrocery(id: id, isPercentage: isPercentage)
            
            if let completion = completion
            {
                completion()
            }
        }
    }
    

    
    
    //------------------------------------------------------------------------------
    // refrigerator
    struct RefriItem: Decodable
    {
        var createdAt: Int
        var updatedAt: Int
        var id: Int
        var count: Int
        var isPercentageCount: Bool
        var dueDate: String
        var storage: Int
        var fridgeName: String
        var notes: String
        var product: Int
        var isDeleted: Bool
        
        enum CodingKeys: String, CodingKey
        {
            case createdAt
            case updatedAt
            case id
            case count
            case isPercentageCount
            case dueDate
            case storage
            case fridgeName
            case notes
            case product
            case isDeleted
        }
        
        init(from decoder: Decoder) throws
        {
            let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.createdAt = try valueContainer.decode(Int.self, forKey: CodingKeys.createdAt)
            self.updatedAt = try valueContainer.decode(Int.self, forKey: CodingKeys.updatedAt)
            self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
            self.count = try valueContainer.decode(Int.self, forKey: CodingKeys.count)
            self.isPercentageCount = try valueContainer.decode(Bool.self, forKey: CodingKeys.isPercentageCount)
            self.dueDate = try valueContainer.decode(String.self, forKey: CodingKeys.dueDate)
            self.storage = try valueContainer.decode(Int.self, forKey: CodingKeys.storage)
            self.fridgeName = try valueContainer.decode(String.self, forKey: CodingKeys.fridgeName)
            self.notes = try valueContainer.decode(String.self, forKey: CodingKeys.notes)
            self.product = try valueContainer.decode(Int.self, forKey: CodingKeys.product)
            self.isDeleted = try valueContainer.decode(Bool.self, forKey: CodingKeys.isDeleted)
        }
    }
    
    struct Refrigerator: Decodable
    {
        var refriItems: [RefriItem]
        var createdAt: Int
        var updatedAt: Int
        var id: Int
        
        enum CodingKeys: String, CodingKey
        {
            case refriItems
            case createdAt
            case updatedAt
            case id
        }
        
        init(from decoder: Decoder) throws
        {
            let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.refriItems = try valueContainer.decode([ShareManager.RefriItem].self, forKey: CodingKeys.refriItems)
            self.createdAt = try valueContainer.decode(Int.self, forKey: CodingKeys.createdAt)
            self.updatedAt = try valueContainer.decode(Int.self, forKey: CodingKeys.updatedAt)
            self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        }
    }
    
    func createRefrigerator(fridgeIndex: Int, completion: @escaping (()->Void))
    {
        //guard isShared() else { return }
        
//        guard fridgeIndex >= 0 && fridgeIndex < 4 else { return }
        guard fridgeIDs[fridgeIndex] == -1 else { return }
        
        let subURL = "/Refrigerator"
        let baseURL = URL(string: getServerURL() + subURL)!
        print(baseURL)
        let query: [String: String] = [
                "idForShare": "\(sharedID)"
            ]
        
        let url = baseURL.withQueries(query)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let jsonDecoder = JSONDecoder()
           
            print(String(data: data, encoding: .utf8)!)
            
            do
            {
                let refrigerator: Refrigerator? = try jsonDecoder.decode(Refrigerator.self, from: data)
                if(refrigerator != nil)
                {
                    print(refrigerator!)
                    self.fridgeIDs[fridgeIndex] = refrigerator!.id
                    
                    completion()
                }
            }
            catch
            {
                print(error)
            }

        }
        
        task.resume()
    }
    
    func requestRefrigeratorIDs(completion: @escaping (()->Void))
    {
        guard isShared() else { return }
        
        let subURL = "/Refrigerator"
        let baseURL = URL(string: getServerURL() + subURL)!
        print(baseURL)
        let query: [String: String] = [
                "idForShare": "\(sharedID)"
            ]
        
        let url = baseURL.withQueries(query)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let jsonDecoder = JSONDecoder()
           
            print(String(data: data, encoding: .utf8)!)
            
            do
            {
                let refrigerators: [Refrigerator]? = try jsonDecoder.decode([Refrigerator].self, from: data)
                if let refrigerators = refrigerators
                {
                    print(refrigerators)
                    
                    guard refrigerators.count == 4 else
                    {
                        print("냉장고가 충분하지 않습니다.") //fatalError("냉장고가 충분하지 않습니다.")
                        //self.endShare()
                        
                        // 냉장고를 생성
                        for index in refrigerators.count...3
                        {
                            self.createRefrigerator(fridgeIndex: index, completion: {})
                        }
                        self.requestRefrigeratorIDs(completion: completion)
                        
                        return
                    }
                    
                    for i in 0...refrigerators.count-1
                    {
                        if( i >= 0 && i < 4)
                        {
                            self.fridgeIDs[i] = refrigerators[i].id
                        }
                    }
                    
                    completion()
                }
            }
            catch
            {
                print(error)
            }

        }
        
        task.resume()
    }
    
    
    
} // end of class
