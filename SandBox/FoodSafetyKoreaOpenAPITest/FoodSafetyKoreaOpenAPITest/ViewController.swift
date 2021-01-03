//
//  ViewController.swift
//  FoodSafetyKoreaOpenAPITest
//
//  Created by changae choi on 2020/12/31.
//

import UIKit
import Foundation


class ViewController: UIViewController {

    @IBOutlet var barcodeTextField: UITextField!
    @IBOutlet var resultTextView: UITextView!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, view: UIImageView!) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                view!.image = UIImage(data: data)
            }
        }
    }
    
    func flushControls()
    {
        resultTextView.text = ""
        imageView.image = UIImage()
    }
    
    @IBAction func requestTapped()
    {
        flushControls()
        let barcodeString: String = barcodeTextField.text != nil ? barcodeTextField.text! : " "
        
        FetchDataFoodSafetyKorea.shared.requestBarcodeProductInfo(barcodeString: barcodeString){
            (resultString) in
            
            DispatchQueue.main.async {
                
                self.resultTextView.text = resultString
            }
        }
    }
    
    @IBAction func beepscanRequestTapped(_ sender: Any)
    {
        flushControls()
        let barcode = barcodeTextField.text != nil ? barcodeTextField.text! : " "
        
        let searchTerm = [("<meta content=", " name="), ("<img src="," ")]
        WebScrapper.shared.scrapingInfo(webAddress: String(format: "https://www.beepscan.com/barcode/%@", barcode), searchStartEnd: searchTerm)
        { [self] (resultString, isSuccess) in
            if(isSuccess)
            {
                if(resultString.count > 0)
                {
                    self.resultTextView.text = resultString[0]
                }
                
                if(resultString.count > 1)
                {
                    let link = resultString[1]
                    if let url = URL(string: link)
                    {
                        self.imageView.image = UIImage(named: "loadingImage")
                        self.downloadImage(from: url, view: imageView)
                    }
                }
            }
        } // end of closer
    }
    
    @IBAction func requestGoogleTapped(_ sender: Any)
    {
        flushControls()
        var barcodeString = barcodeTextField.text != nil ? barcodeTextField.text! : " "
        barcodeString += "+barcode"
        
        GoogleSearcher.shared.searchImageForTerm(term: barcodeString, page: 1)
        { [self] (isSuccess) in
            
            if(isSuccess)
            {
                if(GoogleSearcher.shared.resultLinks.count > 0 )
                {
                    let link = GoogleSearcher.shared.resultLinks[0]
                    if let url = URL(string: link)
                    {
                        self.imageView.image = UIImage(named: "loadingImage")
                        self.downloadImage(from: url, view: imageView)
                    }
                }
            }
        }
    }
    
    @IBAction func scrapingKoreanNetTapped(_ sender: Any)
    {
        flushControls()
        let barcode = barcodeTextField.text ?? ""
        let webAddress = String(format: "http://www.koreannet.or.kr/home/hpisSrchGtin.gs1?gtin=%@", barcode)
        let searchTerm = [("<div class=\"productTit\">","</div>"),
                          ("<div class=\"imgArea\">","</div>")]
        
        WebScrapper.shared.scrapingInfo(webAddress: webAddress, searchStartEnd: searchTerm)
        { [self] (resultString, isSuccess) in
            if(isSuccess)
            {
                if(resultString.count > 0)
                {
                    var trimmedString = resultString[0]
                    trimmedString = WebScrapper.shared.trimmingString(in: trimmedString, trim: "&nbsp;")
                    print(trimmedString)
                    
                    trimmedString = WebScrapper.shared.trimmingString(in: trimmedString, trim: barcode)
                    print(trimmedString)
                    
                    trimmedString = trimmedString.trimmingCharacters(in: .whitespacesAndNewlines)
                    print(trimmedString)
                    
                    self.resultTextView.text = trimmedString
                }
                
                if(resultString.count > 1)
                {
                    var trimmedString = resultString[1]
                    trimmedString = WebScrapper.shared.trimmingString(in: trimmedString, trim: "<img src=\"")
                    print(trimmedString)
                    
                    trimmedString = WebScrapper.shared.trimmingAfterString(in: trimmedString, trim: " width=\"392\" height=\"260\" id=\"detailImage\" />")
                    print(trimmedString)
                    
                    trimmedString = trimmedString.trimmingCharacters(in: .whitespacesAndNewlines)
                    print(trimmedString)
                    
                    let link = trimmedString
                    if let url = URL(string: link)
                    {
                        self.imageView.image = UIImage(named: "loadingImage")
                        self.downloadImage(from: url, view: imageView)
                    }
                }
            }
        } // end of closer
        
    }
}

