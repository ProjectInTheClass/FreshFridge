//
//  StringExtension.swift
//  FreshFridge
//
//  Created by changae choi on 2021/02/01.
//

import Foundation

extension String {

    /// Fetches a localized String
    ///
    /// - Returns: return value(String) for key
    public func localized() -> String
    {
        return (Bundle.main.localizedString(forKey: self, value: nil, table: nil))
    }


    /// Fetches a localised String Arguments
    ///
    /// - Parameter arguments: parameters to be added in a string
    /// - Returns: localized string
    public func localized(with arguments: [CVarArg]) -> String
    {
        return String(format: self.localized(), arguments: arguments)
    }
    
    
    public func getLocalizedKey(with value: String)
    {
        let stringsPath = Bundle.main.path(forResource: "Localizable", ofType: "strings")
        let dictionary = NSDictionary (contentsOfFile: stringsPath ?? "")

        if let temp = dictionary?.allValues.filter({$0 as? String == value}), temp.count > 0
        {
                print("nice found")
        }
    }

}

