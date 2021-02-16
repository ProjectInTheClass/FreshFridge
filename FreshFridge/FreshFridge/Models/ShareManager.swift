//
//  ShareManager.swift
//  FreshFridge
//
//  Created by changae choi on 2021/02/16.
//

import Foundation

class ShareManager
{
    var sharedID: Int = -1
    var publicCode: String = ""
   
    
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
        else
        {
            fatalError("root url not found")
        }
    }
    
    func beginShareManager()
    {
        sharedID = UserDefaults.standard.integer(forKey: "sharedID")
        publicCode = UserDefaults.standard.string(forKey: "publicCode") ?? ""
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
        guard isShared() == false else { return }
        
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
}
