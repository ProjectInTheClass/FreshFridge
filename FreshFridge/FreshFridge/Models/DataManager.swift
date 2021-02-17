//
//  DataManager.swift
//  FreshFridge
//
//  Created by changae choi on 2021/02/16.
//

import Foundation

class DataManager
{
    var langStr: String// = Locale.current.languageCode
    
    var groceryHistories = [GroceryHistory]()
    var cartGroceries = [CartGrocery]()
    
    static let shared = DataManager()
    private init()
    {
        langStr = Locale.current.languageCode ?? ""
    }

    func loadAll()
    {
    }
    
    func removeAll()
    {
        groceryHistories.removeAll()
    }
    
    ///
    // GroceryHistory
    func getGroceryHistories() -> [GroceryHistory]
    {
        return groceryHistories
    }
    
    func findGroceryHistoryIndex(groceryHistory: GroceryHistory) -> EnumeratedSequence<[GroceryHistory]>.Element?
    {
        return groceryHistories.enumerated().first(where: {$0.element === groceryHistory})
    }
    
    func findGroceryHistory(id: UUID) -> GroceryHistory?
    {
        return groceryHistories.first(where: {$0.id == id})
    }
    
    func saveGroceryHistory()
    {
        GroceryHistory.saveGroceryHistory(groceryHistories)
    }
    
    func loadGroceryHistory()
    {
        if let savedGroceryHistories = GroceryHistory.loadGroceryHistory()
        {
            groceryHistories = savedGroceryHistories
        }
        else
        {
            if(langStr == "ko")
            {
                groceryHistories = GroceryHistory.loadSampleGroceryHistory()
            }
        }
    }
    
    func addGroceryHistory(title: String, category: GroceryHistory.Category, updateDate: Bool) -> GroceryHistory
    {
        if let groceryHistory = groceryHistories.first(where: {$0.title == title && $0.category == category})
        {
            // 최신순으로 업데이트가 필요한 경우, 배열에서 찾아서 삭제하고 맨앞에 새로 추가함
            if(updateDate)
            {
                if let index = groceryHistories.enumerated().first(where: {$0.element.title == title && $0.element.category == category})
                {
                    groceryHistories.remove(at: index.offset)
                    groceryHistories.insert(groceryHistory, at: 0)
                    
                    saveGroceryHistory()
                }
            }
            
            return groceryHistory
        }
        else
        {
            let groceryHistory = GroceryHistory(title: title, category: category, favorite: false, lastestPurchaseDate: Date())
            groceryHistories.insert(groceryHistory, at: 0)
            
            saveGroceryHistory()
            
            return groceryHistory
        }
        
        
    }
    
    func addProduct(product: ShareManager.Product)
    {
        let groceryHistory = GroceryHistory(title: product.title, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC, favorite: product.favorite, lastestPurchaseDate: Date(timeIntervalSince1970: TimeInterval(product.updatedAt)))
        //groceryHistory.id = product.id
        //groceryHistory.image
        groceryHistories.insert(groceryHistory, at: 0)
        
        saveGroceryHistory()
    }
    
    func removeGroceryHistory(groceryHistory: GroceryHistory)
    {
        if let selectedIndex = findGroceryHistoryIndex(groceryHistory: groceryHistory)
        {
            groceryHistories.remove(at: selectedIndex.offset)
            saveGroceryHistory() // 로컬에 저장하기
        }
    }
    
    func updateGroceryHistory(id: UUID, favorite: Bool)
    {
        if let foundGroceryHistory = findGroceryHistory(id: id)
        {
            foundGroceryHistory.favorite = favorite
            saveGroceryHistory()
        }
    }
    
    // Grocery
    func saveGrocery()
    {
    }
    
    func loadGrocery() {
    }
    
    func addGrocery()
    {
    }
    
    func removeGrocery()
    {
    }
    
    // CartGrocery
    
    func getCartGroceries() -> [CartGrocery]
    {
        return cartGroceries
    }
    
    func isExistCartGrocery(title: String, category: GroceryHistory.Category) -> Bool
    {
        if cartGroceries.first(where: {$0.info.title == title && $0.info.category == category}) != nil
        {
            return true
        }
        else
        {
            return false
        }
    }

    func findCartGroceryIndex(cartGrocery: CartGrocery) -> EnumeratedSequence<[CartGrocery]>.Element?
    {
        return cartGroceries.enumerated().first(where: {$0.element === cartGrocery})
    }
    
    func findCartGrocery(id: UUID) -> CartGrocery?
    {
        return cartGroceries.first(where: {$0.id == id})
    }
    
    func saveCartGrocery()
    {
        CartGrocery.saveCartGrocery(cartGroceries)
    }
    
    func loadCartGrocery()
    {
        if let savedCartGroceries = CartGrocery.loadCartGrocery()
        {
            cartGroceries = savedCartGroceries
        }
        else
        {
           if(langStr == "ko")
           {
               cartGroceries = CartGrocery.loadSampleCartGrocery()
           }
        }
    }
    
    func addCartGrocery(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, count: Int = 1, isPercentageCount: Bool = false)
    {
        let newCartGrocery = CartGrocery(info: DataManager.shared.addGroceryHistory(title: title, category: category, updateDate: true))
        if let image = image
        {
            newCartGrocery.info.image = image
        }
        newCartGrocery.count = count
        newCartGrocery.isPercentageCount = isPercentageCount
        cartGroceries.insert(newCartGrocery, at: 0)
        
        saveCartGrocery()
    }
    
    func removeCartGrocery(cartGrocery: CartGrocery)
    {
        if let selectedIndex = findCartGroceryIndex(cartGrocery: cartGrocery)
        {
            cartGroceries.remove(at: selectedIndex.offset)
            saveCartGrocery()
        }
    }
    
    func updateCartGrocery(id: UUID, isPurchased: Bool)
    {
        if let foundCartGrocery = findCartGrocery(id: id)
        {
            foundCartGrocery.isPurchased = isPurchased
            saveCartGrocery()
        }
    }
}
