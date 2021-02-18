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
    var groceries = [Grocery]()
    
    static let nilGroceryHistory = GroceryHistory()
    
    static let shared = DataManager()
    private init()
    {
        langStr = Locale.current.languageCode ?? ""
    }

    func loadAll()
    {
    }
    
    func removeAllGroceryHistories()
    {
        groceryHistories.removeAll()
    }
    
    func removeAllCartGroceries()
    {
        cartGroceries.removeAll()
    }
    
    func removeAllFridgeGroceries()
    {
        groceries.removeAll()
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
    
    func getGroceryHistory(title: String, category: GroceryHistory.Category, updateDate: Bool) -> GroceryHistory
    {
        if let groceryHistory = groceryHistories.first(where: {$0.title == title && $0.category == category})
        {
            return groceryHistory
        }
        else
        {
            return DataManager.nilGroceryHistory
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
        //let groceryHistory = GroceryHistory(title: product.title, category: GroceryHistory.Category(rawValue: product.category) ?? GroceryHistory.Category.ETC, favorite: product.favorite, lastestPurchaseDate: Date(timeIntervalSince1970: TimeInterval(product.updatedAt)))
        //groceryHistory.id = product.id
        //groceryHistory.image
        //groceryHistories.insert(groceryHistory, at: 0)
        
        //saveGroceryHistory()
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
    func getGroceries() -> [Grocery] {
        return groceries
    }
    
    func isExistGrocery(title: String, category: GroceryHistory.Category) -> Bool
    {
        if groceries.first(where: {$0.info.title == title && $0.info.category == category}) != nil
        {
            return true
        }
        else
        {
            return false
        }
    }

    func findGroceryIndex(grocery: Grocery) -> EnumeratedSequence<[Grocery]>.Element?
    {
        return groceries.enumerated().first(where: {$0.element === grocery})
    }
    
    func findGrocery(id: UUID) -> Grocery?
    {
        return groceries.first(where: {$0.id == id})
    }
    
    func saveGrocery()
    {
        Grocery.saveGrocery(groceries)
    }
    
    func loadGrocery()
    {
        if let savedGroceries = Grocery.loadGrocery()
        {
            groceries = savedGroceries
        }
        else
        {
            if(Locale.current.languageCode == "ko")
            {
                groceries = Grocery.loadSampleGrocery()
            }
        }
    }
    
    func addGrocery(title: String, category: GroceryHistory.Category, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Grocery.Storage, fridgeName: String, notes: String, image: GroceryImage?) -> Grocery
    {
        let newGrocery = Grocery(info: DataManager.shared.addGroceryHistory(title: title, category: category, updateDate: true), count: count, isPercentageCount: isPercentageCount, dueDate: dueDate, storage: storage, fridgeName: fridgeName, notes: notes)
        if(image != nil)
        {
            newGrocery.info.image = image
        }
        groceries.insert(newGrocery, at: 0)
        
        saveGrocery()
        
        return newGrocery
    }
    
    func removeGrocery(id: UUID)
    {
        if let grocery = findGrocery(id: id),
        let selectedIndex = findGroceryIndex(grocery: grocery)
        {
            groceries.remove(at: selectedIndex.offset)
            Grocery.saveGrocery(groceries)
        }
    }
    
    func moveGrocery(fromGrocery: Grocery, toGrocery: Grocery)
    {
        if let fromIndex = findGroceryIndex(grocery: fromGrocery),
           let toIndex = findGroceryIndex(grocery: toGrocery)
        {
            groceries.remove(at: fromIndex.offset)
            groceries.insert(fromGrocery, at: toIndex.offset)
            
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: UUID, count: Int)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.count = count
            saveGrocery()
        }
    }
    
    func updateGrocery(id: UUID, isPercentageCount: Bool)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.isPercentageCount = isPercentageCount
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: UUID, dueDate: DueDate)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.dueDate = dueDate
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: UUID, storage: Grocery.Storage)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.storage = storage
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: UUID, fridgeName: String)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.fridgeName = fridgeName
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: UUID, notes:String?)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.notes = notes
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: UUID, title: String)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.info.title = title
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: UUID, category: GroceryHistory.Category)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.info.category = category
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: UUID, image: GroceryImage?)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.info.image = image
            Grocery.saveGrocery(groceries)
        }
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
    
    func addCartGrocery(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, count: Int = 1, isPercentageCount: Bool = false, isPurchased: Bool = false)
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
    
    func updateCartGrocery(id: UUID, count: Int)
    {
        if let foundCartGrocery = findCartGrocery(id: id)
        {
            foundCartGrocery.count = count
            saveCartGrocery()
        }
    }
    
    func updateCartGrocery(id: UUID, isPercentage: Bool)
    {
        if let foundCartGrocery = findCartGrocery(id: id)
        {
            foundCartGrocery.isPercentageCount = isPercentage
            saveCartGrocery()
        }
    }
    
    func updateCartGrocery(id: UUID, title: String)
    {
        if let foundCartGrocery = findCartGrocery(id: id)
        {
            foundCartGrocery.info.title = title
            saveCartGrocery()
            saveGroceryHistory()
        }
    }
    
    func updateCartGrocery(id: UUID, category: GroceryHistory.Category)
    {
        if let foundCartGrocery = findCartGrocery(id: id)
        {
            foundCartGrocery.info.category = category
            saveCartGrocery()
            saveGroceryHistory()
        }
    }
    
    func updateCartGrocery(id: UUID, image: GroceryImage)
    {
        if let foundCartGrocery = findCartGrocery(id: id)
        {
            foundCartGrocery.info.image = image
            saveCartGrocery()
            saveGroceryHistory()
        }
    }
}
