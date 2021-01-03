//
//  FoodSafetyKorea.swift
//  FoodSafetyKoreaOpenAPITest
//
//  Created by changae choi on 2021/01/03.
//

import Foundation

class FetchDataFoodSafetyKorea
{
    static let shared = FetchDataFoodSafetyKorea()
    private init() {}
    
    func requestBarcodeProductInfo(barcodeString: String, completion: @escaping (String) -> Void)
    {
        if let baseURL = URL(string: "http://openapi.foodsafetykorea.go.kr/api/5ccf8af9a4e045da824e/C005/json/1/1000/BAR_CD=\(barcodeString)")
        {
            let task = URLSession.shared.dataTask(with: baseURL) {
                (data, response, error) in
                do
                {
                    if let data = data
                    {
                        var resultString: String = ""
                        
                        var mdata = String(data: data, encoding: .utf8)
                        var mmdata = mdata?.data(using: String.Encoding.utf8, allowLossyConversion: false)!
                        
                        if let mdata = mdata,
                           let mmdata = mmdata,
                           let jsonResult = try JSONSerialization.jsonObject(with: mmdata, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        {
                            print("asyncResult\(mdata)")
                            
                            if let items = jsonResult["C005"] as? NSDictionary
                            {
                                if let result = items["RESULT"] as? NSDictionary
                                {
                                    resultString.append("\(result["MSG"] as! String)\n\n\n")
                                }
                                
                                if let array = items["row"] as? NSArray
                                {
                                    for index in 0...array.count-1
                                    {
                                        if let results = array[index] as? NSDictionary
                                        {
                                            //self.productReportNumber = results["PRDLST_REPORT_NO"] as! String
                                            //print(self.productReportNumber)
                                            
                                            resultString.append("유통바코드:\(results["BAR_CD"] as! String)\n")
                                            resultString.append("제조사명:\(results["BSSH_NM"] as! String)\n")
                                            resultString.append("폐업일자:\(results["CLSBIZ_DT"] as! String)\n")
                                            resultString.append("생산중단일:\(results["END_DT"] as! String)\n")
                                            resultString.append("업종:\(results["INDUTY_NM"] as! String)\n")
                                            resultString.append("유통기한:\(results["POG_DAYCNT"] as! String)\n")
                                            resultString.append("식품유형:\(results["PRDLST_DCNM"] as! String)\n")
                                            resultString.append("제품명:\(results["PRDLST_NM"] as! String)\n")
                                            resultString.append("품목보고(신고)번호:\(results["PRDLST_REPORT_NO"] as! String)\n")
                                            resultString.append("보고(신고일):\(results["PRMS_DT"] as! String)\n")
                                            resultString.append("주소:\(results["SITE_ADDR"] as! String)\n")
                                        }
                                        
                                    } // end of for
                                    
                                }
                            }
                            completion(resultString)
                        }
                    }
                }
                catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            }
            task.resume()
        }
    }

    func requestIngredientInfo(productNumber: Int, completion: @escaping (String) -> Void) {
        
        let baseURL = URL(string: "http://openapi.foodsafetykorea.go.kr/api/5ccf8af9a4e045da824e/C002/json/1/2/PRDLST_REPORT_NO=\(productNumber)")!
        let task = URLSession.shared.dataTask(with: baseURL) {
            (data, response, error) in
            do
            {
                var resultString = ""
                
                print(data)
                var mdata = String(data: data!, encoding: .utf8)
                var mmdata = mdata?.data(using: String.Encoding.utf8, allowLossyConversion: false)!
                
                print(mdata)
                
                if let data = data,
                   let mdata = mdata,
                   let mmdata = mmdata,
                   
                   let jsonResult = try JSONSerialization.jsonObject(with: mmdata, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                {
                    print("asyncResult\(jsonResult)")
                    
                    if let items = jsonResult["C002"] as? NSDictionary
                    {
                        if let array = items["row"] as? NSArray
                        {
                            if let results = array[0] as? NSDictionary
                            {
                                resultString.append("원재료:\(results["RAWMTRL_NM"] as! String)\n")
                            }
                        }
                    }
                    
                    completion(resultString)
                }
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }

} // end of class
