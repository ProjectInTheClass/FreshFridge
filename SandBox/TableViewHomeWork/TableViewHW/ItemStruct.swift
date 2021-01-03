//
//  ItemStruct.swift
//  TableViewHW
//
//  Created by iM27 on 2020/12/31.
//

import Foundation

struct ItemStruct {
    var symbol: String
    var name: String
    var memo: String
    var quantity: Int
    
    init(symbol: String, name: String, memo: String, quantity: Int) {
        self.symbol = symbol
        self.name = name
        self.memo = memo
        self.quantity = quantity
        
    }

}
