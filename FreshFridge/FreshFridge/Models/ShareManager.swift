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
    var sharedID: Int = -1
    var publicCode: String = ""
    var lastUpdateTime: Date = Date()
    
    static let shared = ShareManager()
    private init() {}
    
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
        sharedID = UserDefaults.standard.integer(forKey: "sharedID")
        publicCode = UserDefaults.standard.string(forKey: "publicCode") ?? ""
        
        if( publicCode.isEmpty == false && getServerURL().isEmpty == false )
        {
            startShareWithPublicCode(publicCode: publicCode)
            updateAllProduct()
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
            self.publicCode = try! valueContainer.decode(String.self, forKey: CodingKeys.publicCode)
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
                
                UserDefaults.standard.set(self.sharedID, forKey: "sharedID")
                UserDefaults.standard.set(self.publicCode, forKey: "publicCode")
                
                // 로컬의 데이터를 서버로 보내고, 로컬 데이터를 전부 지운다.
            }
        }
        
        task.resume()
    }
    
    func startShareWithPublicCode(publicCode: String)
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
                
                UserDefaults.standard.set(self.sharedID, forKey: "sharedID")
                UserDefaults.standard.set(self.publicCode, forKey: "publicCode")
                
                // 로컬의 데이터를 서버로 보내고, 로컬 데이터를 전부 지운다.
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
            }
        }
        
        task.resume()
    }
    
    struct Product: Codable
    {
        var createdAt: Int
        var updatedAt: Int
        var id: Int
        var title: String
        var category: Int
        var favorite: Bool
        var imageCode: String
        
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
            self.title = try! valueContainer.decode(String.self, forKey: CodingKeys.title)
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
                DataManager.shared.removeAll()
                if let products = try? jsonDecoder.decode([Product].self, from: data)
                {
                    print(products)
                    
                    for product in products
                    {
                        DataManager.shared.addProduct(product: product)
                    }
                }
                
                
            }
        }
        
        task.resume()
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
