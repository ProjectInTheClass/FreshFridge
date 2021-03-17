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
    var filename: String = ""
    var fileExtension: String = "jpg"
    static var viewSize: CGSize = CGSize(width: 300, height: 300)
    static var cachedImages: [String:UIImage] = [:]
    
    init(image: UIImage?, filename: String? = nil)
    {
        if let filename = filename
        {
            self.filename = filename
        }
        else
        {
            self.filename = UUID().uuidString
        }
        
        // image rotation & resizing
        if let image = image
        {
            // image rotation & resizing
            let size = image.size

            let widthRatio  = GroceryImage.viewSize.width  / size.width
            let heightRatio = GroceryImage.viewSize.height / size.height

            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio)
            {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else
            {
                newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
            }
            
            print("image.size : ")
            print(image.size)
            print("newSize : ")
            print(newSize)
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale);
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            image.draw(in: rect)

            var normalizedImage : UIImage! = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if(normalizedImage == nil)
            {
                normalizedImage = image
            }
            
            if let data = normalizedImage.jpegData(compressionQuality: 0.5)//.pngData()
            {
                GroceryImage.cachedImages[self.filename] = UIImage(data: data)
            }
            else
            {
                GroceryImage.cachedImages[self.filename] = normalizedImage
            }
            
        }
    }
    
    func image() -> UIImage?//completion: @escaping (UIImage?)->Void )// -> UIImage?
    {
        if let image = GroceryImage.cachedImages[filename]
        {
            return image
        }
        
        return nil
    }
    
    func resetFilename(name: String)
    {
        if let image = GroceryImage.cachedImages[self.filename]
        {
            GroceryImage.cachedImages[name] = image
            GroceryImage.cachedImages.removeValue(forKey: self.filename)
            
            self.filename = name
        }
    }
    
    static func loadImage(filename: String) -> UIImage?
    {
        let fullFilename = getDocumentsDirectory().appendingPathComponent("\(filename).jpg")
        if let data = try? Data(contentsOf: fullFilename)
        {
            return UIImage(data: data)
        }
        
        return nil
    }
    
    static func saveImage(image: UIImage?, filename: String)
    {
        // file로 저장
        if let image = image,
           let data = image.jpegData(compressionQuality: 0.5)//.pngData()
        {
            let fullFilename = getDocumentsDirectory().appendingPathComponent("\(filename).jpg")
            try? data.write(to: fullFilename)
        }
    }
}
