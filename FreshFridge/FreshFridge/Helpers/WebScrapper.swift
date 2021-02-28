//
//  WebScrapper.swift
//  FoodSafetyKoreaOpenAPITest
//
//  Created by changae choi on 2021/01/03.
//

import Foundation
import UIKit

class WebScrapper
{
    static let shared = WebScrapper()
    private init() {}

    public func scrapingInfo(webAddress: String, searchStartEnd:[(String, String)], completion: @escaping (_ resultString: [String],  Bool) -> Void)
    {
        let serverAddress = String(format: webAddress)

        let url = serverAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let finalUrl = URL(string: url!)
        let request = NSMutableURLRequest(url: finalUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)

        let session = URLSession.shared

        let datatask = session.dataTask(with: request as URLRequest)
        { (data, response, error) in
            if let data = data,
                let stringDataOrigin = String.init(data: data, encoding: .utf8)
            {
                var resultString: [String] = []
                var stringData = ""
                for term in searchStartEnd
                {
                    stringData = stringDataOrigin
                    if let range = stringData.range(of: term.0)
                    {
                        let firstIndex = stringData.index(after: range.upperBound)
                        stringData = String(stringData[firstIndex..<stringData.endIndex])
                        if let range2 = stringData.range(of: term.1)
                        {
                            let lastIndex = stringData.index(before: range2.lowerBound)
                            stringData = String(stringData[stringData.startIndex..<lastIndex])
                            
                            resultString.append(stringData)
                        }
                    }
                } // end of for
                
                DispatchQueue.main.async
                {
                    if(resultString.count > 0)
                    {
                        completion(resultString, true)
                    }
                    else
                    {
                        completion(resultString, false)
                    }
                }
            }
        }
            
        datatask.resume()
    } // end of searchForBarcode
    
    func trimmingString(in inputString: String, trim trimString: String) -> String
    {
        var resultString: String = inputString
        var range = resultString.range(of: trimString)
        while range != nil
        {
            resultString = String(resultString[resultString.startIndex..<range!.lowerBound])
                + String(resultString[range!.upperBound..<resultString.endIndex])
            
            range = resultString.range(of: trimString)
        }
        
        return resultString
    }
    
    func trimmingAfterString(in inputString: String, trim trimString: String) -> String
    {
        var resultString: String = inputString
        var range = resultString.range(of: trimString)
        while range != nil
        {
            let lastIndex = resultString.index(before: range!.lowerBound)
            resultString = String(resultString[resultString.startIndex..<lastIndex])
            
            range = resultString.range(of: trimString)
        }
        
        return resultString
    }
    
    func trimmingBeforeString(in inputString: String, trim trimString: String) -> String
    {
        var resultString: String = inputString
        var range = resultString.range(of: trimString)
        while range != nil
        {
            resultString = String(resultString[range!.upperBound..<resultString.endIndex])
            
            range = resultString.range(of: trimString)
        }
        
        return resultString
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, ui: UIButton?, completion: @escaping (()->Void)) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async()
            {
                ui?.setImage(UIImage(data: data), for: .normal)
                
                completion()
            }
        }
    }
    
    
} // end of class
    //56782ey24573
