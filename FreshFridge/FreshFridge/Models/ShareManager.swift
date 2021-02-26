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
    
    var startUpdateCounting = false
    
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
        return "http://z.ebadaq.com:45082"
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
    
    func initShareManager()
    {
        if( publicCode.isEmpty == false && getServerURL().isEmpty == false )
        {
            startShareWithPublicCode(publicCode: publicCode)
            {
                self.updateAllProduct()
                {
                    getRequestManager().updatePurchaseRecordViewController(updateTableView: getRequestManager().isUpdatePurchaseRecord)
                    getRequestManager().updateShopingCartViewController(updateTableView:   getRequestManager().isUpdateShopingCart)
                    getRequestManager().updateGroceryListViewController(updateTableView: getRequestManager().isUpdateGroceryList)
                }
                self.updateAllCartItem()
                {
                    getRequestManager().updateShopingCartViewController(updateTableView: getRequestManager().isUpdateShopingCart)
                }
                self.updateAllRefrigeratorItem()
                {
                    getRequestManager().updateGroceryListViewController(updateTableView: getRequestManager().isUpdateGroceryList)
                }
                                        
                ShareManager.shared.startUpdateCounting = true
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
        
        for (_, groceryHistoryReferences) in referenceMap
        {
            var id: Int = -1
            if(groceryHistoryReferences.groceries.count > 0)
            {
                id = groceryHistoryReferences.groceries[0].info.id.id
            }
            else if(groceryHistoryReferences.cartGroceries.count > 0)
            {
                id = groceryHistoryReferences.cartGroceries[0].info.id.id
            }
            
            if let groceryHistory = DataManager.shared.findGroceryHistory(id: AutoIncreasedID(id))
            {
                
                createGroceryHistory(title: groceryHistory.title, category: groceryHistory.category)
                {
                    (id: Int) in
                    
                    DispatchQueue.main.async()
                    {
                        print("You are on \(Thread.isMainThread ? "MAIN" : "BACKGROUND") thread.")
                        groceryHistory.id = AutoIncreasedID(id)
                        self.updateGroceryHistory(id: groceryHistory.id, favorite: groceryHistory.favorite, completion: nil)
                        
                        for grocery in groceryHistoryReferences.groceries
                        {
                            self.createGrocery(productID: id, count: grocery.count, isPercentageCount: grocery.isPercentageCount, dueDate: grocery.dueDate, storage: grocery.storage, fridgeName: grocery.fridgeName, notes: grocery.notes ?? "", image: grocery.info.image)
                        }
                        
                        for cartGrocery in groceryHistoryReferences.cartGroceries
                        {
                            self.createCartGrocery(productID: id, count: cartGrocery.count, isPercentageCount: cartGrocery.isPercentageCount, isPurchased: cartGrocery.isPurchased)
                        }
                    }
                }
            }
            
        }
        
        
        var removedGroceryHistories: [GroceryHistory] = []
        for grocery in DataManager.shared.getGroceries()
        {
            if nil == removedGroceryHistories.first(where: {$0.title == grocery.info.title && $0.category == grocery.info.category})
            {
                removedGroceryHistories.insert(grocery.info, at: 0)
                DataManager.shared.removeGroceryHistory(id: grocery.info.id)
            }
        }
        
        for cartGrocery in DataManager.shared.getCartGroceries()
        {
            if nil == removedGroceryHistories.first(where: {$0.title == cartGrocery.info.title && $0.category == cartGrocery.info.category})
            {
                removedGroceryHistories.insert(cartGrocery.info, at: 0)
                DataManager.shared.removeGroceryHistory(id: cartGrocery.info.id)
            }
        }
        
        for groceryHistory in DataManager.shared.getGroceryHistories()
        {
            createGroceryHistory(title: groceryHistory.title, category: groceryHistory.category)
            {
                (id: Int) in
                groceryHistory.id = AutoIncreasedID(id)
                self.updateGroceryHistory(id: groceryHistory.id, favorite: groceryHistory.favorite, completion: nil)
            }
        }
    }
        
    func startShareAndCreateCode(completion: @escaping (()->Void))
    {
        let subURL = "/requestCode"
        let baseURL = URL(string: getServerURL() + subURL)!
        let task = URLSession.shared.dataTask(with: baseURL)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
            let requestCode = try? jsonDecoder.decode(RequestCode.self, from: data)
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
            if let data = data,
            let requestCode = try? jsonDecoder.decode(RequestCode.self, from: data)
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
    
    func endShare()
    {
        guard isShared() else { return }
        
        ShareManager.shared.startUpdateCounting = false
        
        let subURL = "/resignCode"
        let baseURL = URL(string: getServerURL() + subURL)!
        let task = URLSession.shared.dataTask(with: baseURL)
        { (data, response, error) in
            _ = JSONDecoder()
            if let data = data,
            let string = String(data: data, encoding: .utf8)
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
            }
        }
        
        task.resume()
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
    
    func updateAllProduct(completion: @escaping (()->Void))
    {
        guard isShared() else { return }
        
        getRequestManager().isUpdatePurchaseRecord = false
        
        let subURL = "/Product"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
                "idForShare": "\(sharedID)",
                "where": "{\"updatedAt\":{\">\":\(lastestProductUpdateAt)},\"idForShare\":\(sharedID)}"
                //"where": "{\"updatedAt\":{\">\":\(lastestProductUpdateAt)}}"
            ]
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data
            {
                print(String(data: data, encoding: .utf8)!)
                if let products = try? jsonDecoder.decode([Product].self, from: data)
                {
                    //print(products)
                    
                    var isUpdateTable = false
                    for product in products
                    {
                        if let groceryHistory = DataManager.shared.findGroceryHistory(id: AutoIncreasedID(product.id))
                        {
                            // 기존 groceryHistory update
                            if(groceryHistory.title != product.title)
                            {
                                DataManager.shared.updateGroceryHistory(id: groceryHistory.id, title: product.title)
                                isUpdateTable = true
                            }
                            
                            if(groceryHistory.category.rawValue != product.category)
                            {
                                DataManager.shared.updateGroceryHistory(id: groceryHistory.id, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC)
                                
                                
                                getRequestManager().isUpdatePurchaseRecord = true
                                getRequestManager().isUpdateShopingCart = true
                                getRequestManager().isUpdateGroceryList = true
                                isUpdateTable = true
                            }
                            
                            if(groceryHistory.favorite != product.favorite)
                            {
                                DataManager.shared.updateGroceryHistory(id: groceryHistory.id, favorite: product.favorite)
                                isUpdateTable = true
                            }
                            
                            if(product.isDeleted)
                            {
                                DataManager.shared.removeGroceryHistory(id: groceryHistory.id)
                                getRequestManager().isUpdatePurchaseRecord = true
                                isUpdateTable = true
                            }
                        }
                        else
                        {
                            guard product.isDeleted == false else
                            {
                                continue
                            }
                            
                            DataManager.shared.insertGroceryHistory(id: product.id, title: product.title, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC, image: nil, updateDate: false)
                            DataManager.shared.updateGroceryHistory(id: AutoIncreasedID(product.id), favorite: product.favorite)
                            
                            getRequestManager().isUpdatePurchaseRecord = true
                            isUpdateTable = true
                        }
                        
                        if(self.lastestProductUpdateAt < product.updatedAt)
                        {
                            self.lastestProductUpdateAt = product.updatedAt
                            print(self.lastestProductUpdateAt)
                        }
                    }
                    
                    if (isUpdateTable)
                    {
                        completion()
                    }
                }
                
                
            }
        }
        
        task.resume()
    }
    
    
    
    func createGroceryHistory(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, completion: (((Int) -> Void)?) = nil)
    {
        let subURL = "/product"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
            "idForShare": "\(sharedID)",
            "title" : title,
            "category" : "\(category.rawValue)"
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
            if let data = data
            {
                print(String(data: data, encoding: .utf8)!)
                do
                {
                    let product: ShareManager.Product? = try jsonDecoder.decode(ShareManager.Product.self, from: data)
                    if let product = product
                    {
                        print(product)
                        
                        if let completion = completion
                        {
                            completion(product.id)
                        }
                    }
                }
                catch
                {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func createGroceryHistoryForCart(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, count: Int = 1, isPercentageCount: Bool = false, isPurchased: Bool = false, completion2: (((ShareManager.CartItem) -> Void)?) = nil)
    {
        createGroceryHistory(title: title, category: category)
        { (id: Int) in
            
            DataManager.shared.insertGroceryHistory(id: id, title: title, category: category, image: image, updateDate: true)
            
            //
            ShareManager.shared.createCartGrocery(productID: id, count: count, isPercentageCount: isPercentageCount, isPurchased: isPurchased, completion: completion2)
        }
    }
    
    func createGroceryHistoryForRefri(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Grocery.Storage, fridgeName: String, notes: String, completion2: (((ShareManager.RefrigeratorItem) -> Void)?) = nil)
    {
        createGroceryHistory(title: title, category: category)
        { (id: Int) in
            DataManager.shared.insertGroceryHistory(id: id, title: title, category: category, image: image, updateDate: true)
            
            
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
        if let foundGroceryHistory = DataManager.shared.findGroceryHistory(id: id)
        {
            let subURL = "/product/\(foundGroceryHistory.id.id)"
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
    
    func updateGroceryHistory(id: AutoIncreasedID, image: GroceryImage?, completion: (()->Void))
    {
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
    
    func updateAllRefrigeratorItem(completion: (()->Void)?)
    {
        guard isShared() else { return }
        
        getRequestManager().isUpdateGroceryList = false
        
        let subURL = "/RefriItem"
        let baseURL = URL(string: getServerURL() + subURL)!
        for frigdeID in fridgeIDs
        {
            guard frigdeID != -1 else { continue }
            
            let query: [String: String] = [
                    "idForRefri": "\(frigdeID)",
                    "where": "{\"updatedAt\":{\">\":\(lastestProductUpdateAt)},\"idForRefri\":\(frigdeID)}"
                    //"where": "{\"updatedAt\":{\">\":\(lastestRefriUpdateAt)}}"
                ]
            
            let url = baseURL.withQueries(query)!
            print(url)
            let task = URLSession.shared.dataTask(with: url)
            { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                if let data = data
                {
                    print(String(data: data, encoding: .utf8)!)
                    
                    do
                    {
                        let refriItems: [ShareManager.RefrigeratorItem]? = try jsonDecoder.decode([ShareManager.RefrigeratorItem].self, from: data)
                        if refriItems != nil
                        {
                            print(refriItems!)
                            
                            var isUpdateTable = false
                            for refriItem in refriItems!
                            {
                                if let product = refriItem.product
                                {
                                    if let grocery = DataManager.shared.findGrocery(id: AutoIncreasedID(refriItem.id))
                                    {
                                        // updating
                                        if(grocery.count != refriItem.count)
                                        {
                                            DataManager.shared.updateGrocery(id: grocery.id, count: refriItem.count)
                                            isUpdateTable = true
                                        }
                                        
                                        if(grocery.isPercentageCount != refriItem.isPercentageCount)
                                        {
                                            DataManager.shared.updateGrocery(id: grocery.id, isPercentageCount: refriItem.isPercentageCount)
                                            isUpdateTable = true
                                        }
                                        
                                        if(Int(grocery.dueDate.date.timeIntervalSince1970) * 1000 != Int(refriItem.dueDate))
                                        {
                                            DataManager.shared.updateGrocery(id: grocery.id, dueDate: DueDate(date: Date(timeIntervalSince1970: TimeInterval((Int(refriItem.dueDate) ?? 0) / 1000))))
                                            isUpdateTable = true
                                        }
                                        
                                        if(grocery.storage.rawValue != refriItem.storage)
                                        {
                                            DataManager.shared.updateGrocery(id: grocery.id, storage: Grocery.Storage(rawValue: refriItem.storage) ?? Grocery.Storage.Refrigeration)
                                            isUpdateTable = true
                                        }
                                        
                                        if(grocery.fridgeName != refriItem.fridgeName)
                                        {
                                            DataManager.shared.updateGrocery(id: grocery.id, fridgeName: refriItem.fridgeName)
                                            isUpdateTable = true
                                        }
                                        
                                        if(grocery.notes != refriItem.notes)
                                        {
                                            DataManager.shared.updateGrocery(id: grocery.id, notes: refriItem.notes)
                                            isUpdateTable = true
                                        }
                                        
                                        // groceryHistory
                                        if(grocery.info.title != product.title)
                                        {
                                            DataManager.shared.updateGrocery(id: grocery.id, title: product.title)
                                            isUpdateTable = true
                                        }
                                        
                                        if(grocery.info.category.rawValue != product.category)
                                        {
                                            //cartGrocery.info.category = category
                                            DataManager.shared.updateGroceryHistory(id: grocery.info.id, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC)
                                            
                                            getRequestManager().isUpdatePurchaseRecord = true
                                            getRequestManager().isUpdateShopingCart = true
                                            getRequestManager().isUpdateGroceryList = true
                                            isUpdateTable = true
                                        }
                                        
                                        if(refriItem.isDeleted)
                                        {
                                            DataManager.shared.removeGrocery(id: grocery.id)
                                            getRequestManager().isUpdateGroceryList = true
                                            isUpdateTable = true
                                        }
                                    }
                                    else
                                    {
                                        guard refriItem.isDeleted == false else { continue }
                                        
                                        // adding
                                        DataManager.shared.insertGrocery(id: refriItem.id, title: product.title,
                                                                      category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC,
                                                                      count: refriItem.count,
                                                                      isPercentageCount: refriItem.isPercentageCount,
                                                                      dueDate: DueDate(date: Date(timeIntervalSince1970: TimeInterval((Int(refriItem.dueDate) ?? 0) / 1000))),
                                                                      storage: Grocery.Storage(rawValue: refriItem.storage) ?? Grocery.Storage.Refrigeration,
                                                                      fridgeName: refriItem.fridgeName,
                                                                      notes: refriItem.notes,
                                                                      image: nil)
                                        
                                        getRequestManager().isUpdateGroceryList = true
                                        isUpdateTable = true
                                    }
                                    
                                    
                                    if(self.lastestRefriUpdateAt < refriItem.updatedAt)
                                    {
                                        self.lastestRefriUpdateAt = refriItem.updatedAt
                                        print(self.lastestRefriUpdateAt)
                                    }
                                    
                                }
                                
                                
                            } // end of for
                            
                            if(isUpdateTable)
                            {
                                if let completion = completion
                                {
                                    completion()
                                }
                            }
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                }
            }
            
            task.resume()
        }
        
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
                "dueDate":"\(Int(dueDate.date.timeIntervalSince1970 * 1000))",
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
                let jsonDecoder = JSONDecoder()
                if let data = data
                {
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
                }
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
        let json: [String: Any] = ["dueDate" : "\(Int(dueDate.date.timeIntervalSince1970 * 1000))"]
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
    
    func updateAllCartItem(completion: (()->Void)?)
    {
        guard isShared() else { return }
        
        getRequestManager().isUpdateShopingCart = false
        
        let subURL = "/cartItem"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
                "idForShare": "\(sharedID)",
                //"where": "{\"updatedAt\":{\">\":\(lastestCartUpdatedAt)}}"
                "where": "{\"updatedAt\":{\">\":\(lastestProductUpdateAt)},\"idForShare\":\(sharedID)}"
            ]
        
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data
            {
                //print(String(data: data, encoding: .utf8)!)
                
                do
                {
                    let cartItems: [ShareManager.CartItem]? = try jsonDecoder.decode([ShareManager.CartItem].self, from: data)
                    if cartItems != nil
                    {
                        //print(cartItems!)
                        var isUpdateTable = false
                        
                        for cartItem in cartItems!
                        {
                            if let product = cartItem.product
                            {
                                if let cartGrocery = DataManager.shared.findCartGrocery(id: AutoIncreasedID(cartItem.id))
                                {
                                    // 기존 cartGrocery update
                                    if(cartGrocery.count != cartItem.count)
                                    {
                                        DataManager.shared.updateCartGrocery(id: cartGrocery.id, count: cartItem.count)
                                        isUpdateTable = true
                                    }
                                    
                                    if(cartGrocery.isPercentageCount != cartItem.isPercentageCount)
                                    {
                                        DataManager.shared.updateCartGrocery(id: cartGrocery.id, isPercentage: cartItem.isPercentageCount)
                                        isUpdateTable = true
                                    }
                                    
                                    if(cartGrocery.isPurchased != cartItem.isPurchased)
                                    {
                                        DataManager.shared.updateCartGrocery(id: cartGrocery.id, isPurchased: cartItem.isPurchased)
                                        isUpdateTable = true
                                    }
                                    
                                    // groceryHistory
                                    if(cartGrocery.info.title != product.title)
                                    {
                                        DataManager.shared.updateGroceryHistory(id: cartGrocery.info.id, title: product.title)
                                        isUpdateTable = true
                                    }
                                    
                                    if(cartGrocery.info.category.rawValue != product.category)
                                    {
                                        //cartGrocery.info.category = category
                                        DataManager.shared.updateGroceryHistory(id: cartGrocery.info.id, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC)
                                        
                                        getRequestManager().isUpdatePurchaseRecord = true
                                        getRequestManager().isUpdateShopingCart = true
                                        getRequestManager().isUpdateGroceryList = true
                                        isUpdateTable = true
                                    }
                                    
                                    
                                    
                                    if(cartItem.isDeleted)
                                    {
                                        DataManager.shared.removeCartGrocery(id: cartGrocery.id)
                                        getRequestManager().isUpdateShopingCart = true
                                        isUpdateTable = true
                                    }
                                }
                                else
                                {
                                    guard cartItem.isDeleted == false else
                                    {
                                        continue
                                    }
                                    
                                    // 없는 경우 새로 추가
                                    DataManager.shared.insertCartGrocery(title: product.title, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC, image: nil,
                                                                                   id: cartItem.id, count: cartItem.count, isPercentageCount: cartItem.isPercentageCount, isPurchased: cartItem.isPurchased)
                                    
                                    isUpdateTable = true
                                    getRequestManager().isUpdateShopingCart = true
                                }
                                
                                if(self.lastestCartUpdatedAt < cartItem.updatedAt)
                                {
                                    self.lastestCartUpdatedAt = cartItem.updatedAt
                                    print(self.lastestCartUpdatedAt)
                                }
                            }
                        } // end of for
                        
                        if(isUpdateTable)
                        {
                            if let completion = completion
                            {
                                completion()
                            }
                        }
                    }
                }
                catch
                {
                    print(error)
                }
            }
        }
        
        task.resume()
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
        /*
        let subURL = "/cartItem"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
                "idForShare" : "\(sharedID)",
            "id" : "\(cartGrocery.id.id)"
            ]
        
        let url = baseURL.withQueries(query)!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data
            {
                print(String(data: data, encoding: .utf8)!)
                
                do
                {
                    let cartItem: ShareManager.CartItem? = try jsonDecoder.decode(ShareManager.CartItem.self, from: data)
                    
                    print(cartItem!)
                        
                    if let cartItem = cartItem
                    {
                        print(cartItem)
                        DataManager.shared.removeCartGrocery(cartGrocery: cartGrocery)
                        
                        if let completion = completion
                        {
                            completion()
                        }
                    }
                }
                catch
                {
                    print(error)
                }
            }
        }
        
        task.resume()
        */
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
                        print("냉장고가 충분하지 않습니다.")
                        self.endShare()
                        return
                    }//fatalError("냉장고가 충분하지 않습니다.") }
                    
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
