//
//  GoogleSearcher.swift
//  FoodSafetyKoreaOpenAPITest
//
//  Created by changae choi on 2021/01/03.
//

import Foundation

public class GoogleSearcher
{
    static let shared = GoogleSearcher()
    private init() {}
    
    var totalCount = 0
    var resultLinks: [String] = []
    
    // term : 검색어
    // page : 검색할 페이지
    public func searchImageForTerm(term: String, page: Int, completion: @escaping (Bool) -> Void)
    {
        let apiKey = "AIzaSyBLACmGgN0BM7woRJtJGt-fkQqFJNOFaSs"
        let bundleId = "funnySurprise.MemeMaker"
        let searchEngineId = "2ffa7135302712c7d"
        var serverAddress = String(format: "https://www.googleapis.com/customsearch/v1?q=%@&cx=%@&key=%@&searchType=image&num=8&start=",term ,searchEngineId, apiKey)
        serverAddress += "\(page)"

        let url = serverAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let finalUrl = URL(string: url!)
        let request = NSMutableURLRequest(url: finalUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.setValue(bundleId, forHTTPHeaderField: "X-Ios-Bundle-Identifier")

        let session = URLSession.shared

        let datatask = session.dataTask(with: request as URLRequest)
        { (data, response, error) in
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                {
                    print("asyncResult\(jsonResult)")
                    
                    if let items = jsonResult["items"] as? NSArray
                    {
                        for i in 0...items.count-1
                        {
                            if let itemDic = items[i] as? NSDictionary,
                               let imageLink = itemDic["link"] as? String
                            {
                                print("image link is \(imageLink)")
                                self.resultLinks.append(imageLink)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            completion(true)
                        }
                    }
                    
                    if let items = jsonResult["searchInformation"] as? NSDictionary
                    {
                        if let count = items["totalResults"]
                        {
                            self.totalCount = Int(count as! String)!
                        }
                    }
                    
                }
                
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
        }
            
        datatask.resume()
    }// end of func
}
