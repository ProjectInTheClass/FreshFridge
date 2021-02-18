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
    var fridgeIDs: [Int] = [-1,-1,-1,-1]
    {
        didSet
        {
            UserDefaults.standard.set(fridgeIDs, forKey: "fridgeIDs")
        }
    }
    
    
    var lastUpdateTime: Date = Date()
    
    static let shared = ShareManager()
    private init()
    {
        sharedID = UserDefaults.standard.integer(forKey: "sharedID")
        publicCode = UserDefaults.standard.string(forKey: "publicCode") ?? ""
        if let fridgeIDs = UserDefaults.standard.array(forKey: "fridgeIDs")
        {
            self.fridgeIDs = fridgeIDs as! [Int]
        }
    }
    
    func isShared() -> Bool
    {
        return publicCode.isEmpty == false
    }
    
    func getServerURL() -> String {
        let dictionary = ProcessInfo.processInfo.environment
        if let rootURL = dictionary["ROOT_URL"]
        {
            return rootURL
        }
        
        return ""
    }
    
    func initShareManager()
    {
        if( publicCode.isEmpty == false && getServerURL().isEmpty == false )
        {
            startShareWithPublicCode(publicCode: publicCode)
            {
                self.updateAllProduct()
                self.updateAllCartItem()
                self.updateAllRefrigeratorItem()
                                        
                //self.createRefrigerator(fridgeIndex: 0) // test code
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
        
    func startShareAndCreateCode()
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
                
                // 로컬의 데이터를 서버로 보내고, 로컬 데이터를 전부 지운다.
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
                
                // 로컬의 데이터를 서버로 보내고, 로컬 데이터를 전부 지운다.
                completion()
            }
        }
        
        task.resume()
    }
    
    func endShare()
    {
        guard isShared() else { return }
        
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
                
                DataManager.shared.removeAllGroceryHistories()
                DataManager.shared.removeAllCartGroceries()
                DataManager.shared.removeAllFridgeGroceries()
            }
        }
        
        task.resume()
    }
    
    struct Product: Codable
    {
        var createdAt: Int// = 0
        var updatedAt: Int// = 0
        var id: Int// = 0
        var title: String //= ""
        var category: Int// = 0
        var favorite: Bool// = false
        var imageCode: String// = ""
        
        enum CodingKeys: String, CodingKey
        {
            case createdAt
            case updatedAt
            case id
            case title
            case category
            case favorite
            case imageCode
        }
        
        init(from decoder: Decoder) throws
        {
            let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.createdAt = try valueContainer.decode(Int.self, forKey: CodingKeys.createdAt)
            self.updatedAt = try valueContainer.decode(Int.self, forKey: CodingKeys.updatedAt)
            self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
            self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
            self.category = try valueContainer.decode(Int.self, forKey: CodingKeys.category)
            self.favorite = try valueContainer.decode(Bool.self, forKey: CodingKeys.favorite)
            self.imageCode = try! valueContainer.decode(String.self, forKey: CodingKeys.imageCode)
        }
    }
    
    // Product
    func updateAllProduct()
    {
        guard isShared() else { return }
        let subURL = "/Product"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
                "id": "\(sharedID)",
            ]
        
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data
            {
                //print(String(data: data, encoding: .utf8)!)
                DataManager.shared.removeAllGroceryHistories()
                if let products = try? jsonDecoder.decode([Product].self, from: data)
                {
                    //print(products)
                    
                    for product in products
                    {
                        let groceryHistory = DataManager.shared.addGroceryHistory(title: product.title, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC, updateDate: false)
                        groceryHistory.favorite = product.favorite
                    }
                }
                
                
            }
        }
        
        task.resume()
    }
    
    struct CartItem: Codable
    {
        var createdAt: Int
        var updatedAt: Int
        var id: Int
        var isPurchased: Bool
        var count: Int
        var isPercentageCount: Bool
        var product: Product?// = Product()
        
        enum CodingKeys: String, CodingKey
        {
            case createdAt
            case updatedAt
            case id
            case isPurchased
            case count
            case isPercentageCount
            case product
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
        }
    }
    
    // CartItem
    func updateAllCartItem()
    {
        guard isShared() else { return }
        let subURL = "/cartItem"
        let baseURL = URL(string: getServerURL() + subURL)!
        let query: [String: String] = [
                "idForShare": "\(sharedID)"
            ]
        
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data
            {
                //print(String(data: data, encoding: .utf8)!)
                DataManager.shared.removeAllCartGroceries()
               
                do
                {
                    let cartItems: [ShareManager.CartItem]? = try jsonDecoder.decode([ShareManager.CartItem].self, from: data)
                    if cartItems != nil
                    {
                        //print(cartItems!)
                        
                        for cartItem in cartItems!
                        {
                            if let product = cartItem.product
                            {
                                DataManager.shared.addCartGrocery(title: product.title, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC, image: nil, count: cartItem.count, isPercentageCount: cartItem.isPercentageCount, isPurchased: cartItem.isPurchased)
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
    
    func createRefrigerator(fridgeIndex: Int)
    {
        guard isShared() else { return }
        
        guard fridgeIndex >= 0 && fridgeIndex < 4 else { return }
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

        // insert json data to the request
//        let json: [String: Any] = ["idForShare": "\(sharedID)"]
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        request.httpBody = jsonData
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
                }
            }
            catch
            {
                print(error)
            }

        }
        
        task.resume()
    }
    
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
        }
    }
    
    func updateAllRefrigeratorItem()
    {
        guard isShared() else { return }
        
        DataManager.shared.removeAllFridgeGroceries()
        
        let subURL = "/RefriItem"
        let baseURL = URL(string: getServerURL() + subURL)!
        for frigdeID in fridgeIDs
        {
            guard frigdeID != -1 else { continue }
            
            let query: [String: String] = [
                    "idForRefri": "\(frigdeID)"
                ]
            
            let url = baseURL.withQueries(query)!
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
                            
                            for refriItem in refriItems!
                            {
                                if let product = refriItem.product
                                {
                                    let _ = DataManager.shared.addGrocery(title: product.title,
                                                                  category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC,
                                                                  count: refriItem.count,
                                                                  isPercentageCount: refriItem.isPercentageCount,
                                                                  dueDate: DueDate(date: Date(timeIntervalSince1970: TimeInterval((Int(refriItem.dueDate) ?? 0) / 1000))),
                                                                  storage: Grocery.Storage(rawValue: refriItem.storage) ?? Grocery.Storage.Refrigeration,
                                                                  fridgeName: refriItem.fridgeName,
                                                                  notes: refriItem.notes,
                                                                  image: nil)
                                    
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
    
    func updatePurchaseRecordViewController()
    {
        guard (UIApplication.shared.delegate as! AppDelegate).purchaseRecordViewController != nil else { return }
        
        
        DispatchQueue.main.async()
        {
            (UIApplication.shared.delegate as! AppDelegate).purchaseRecordViewController.updateTableView()
            (UIApplication.shared.delegate as! AppDelegate).purchaseRecordViewController.tableView.reloadData()
        }
    }
}
