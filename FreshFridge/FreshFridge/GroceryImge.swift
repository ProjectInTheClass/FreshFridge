//
//  GroceryImge.swift
//  FreshFridge
//
//  Created by changae choi on 2021/01/18.
//

import Foundation
import UIKit
import CryptoKit

class GroceryImage: Codable
{
    var filename: String
    var fileExtension: String = "png"
    var targetSize: CGSize = CGSize(width: 200, height: 200)
    
    init(filename: String)
    {
        self.filename = filename
    }
    
    init(image: UIImage?)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM_dd_yyyy_HH_mm_ss_SSS"
        let currentTimeString = dateFormatter.string(from: Date())
        let currentTimeData = Data(currentTimeString.utf8)
        let hashed = Insecure.MD5.hash(data: currentTimeData)//let hashed = SHA256.hash(data: currentTimeData)
        filename = hashed.compactMap { String(format: "%02x", $0) }.joined()
        
        print(filename)
        
        // image rotation & resizing
        if let image = image
        {
            let size = image.size

            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height

            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
            }
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale);
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            image.draw(in: rect)

            let normalizedImage : UIImage! = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if(normalizedImage != nil)
            {
                makeImage(uiImage: normalizedImage)
            }
            else
            {
                print("rotation failed.")
                makeImage(uiImage: image)
            }
        }
    }

    func image() -> UIImage?
    {
        let fullFilename = getDocumentsDirectory().appendingPathComponent("\(filename).\(fileExtension)")
        if let data = try? Data(contentsOf: fullFilename)
        {
            return UIImage(data: data)
        }
        
        return nil
    }
    
    
    
    func makeImage(uiImage: UIImage)
    {
        // file로 저장
        if let data = uiImage.pngData()
        {
            let fullFilename = getDocumentsDirectory().appendingPathComponent("\(filename).\(fileExtension)")
            try? data.write(to: fullFilename)
        }
    }
}
