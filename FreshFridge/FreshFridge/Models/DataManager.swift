//
//  DataManager.swift
//  FreshFridge
//
//  Created by changae choi on 2021/02/16.
//

import Foundation
import UIKit

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
        saveGroceryHistory()
    }
    
    func removeAllCartGroceries()
    {
        cartGroceries.removeAll()
        saveCartGrocery()
    }
    
    func removeAllFridgeGroceries()
    {
        for grocery in groceries
        {
            getRequestManager().removeAlarm(grocery: grocery)
        }
        groceries.removeAll()
        saveGrocery()
    }
    
    ///
    // GroceryHistory
    func getGroceryHistories() -> [GroceryHistory]
    {
        return groceryHistories
    }
    
    
    func findGroceryHistoryIndex(id: AutoIncreasedID) -> EnumeratedSequence<[GroceryHistory]>.Element?
    {
        return groceryHistories.enumerated().first(where: {$0.element.id == id})
    }
    
    func findGroceryHistory(id: AutoIncreasedID) -> GroceryHistory?
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
            groceryHistories = GroceryHistory.loadSampleGroceryHistory()
        }
        
        for groceryHistory in groceryHistories
        {
            if let image = groceryHistory.image
            {
                if let uiImage = GroceryImage.loadImage(filename: image.filename)
                {
                    groceryHistory.image = GroceryImage(image: uiImage, filename: image.filename)
                }
            }
        }
    }
    
    func getGroceryHistory(title: String, category: GroceryHistory.Category) -> GroceryHistory?
    {
        if let groceryHistory = groceryHistories.first(where: {$0.title == title && $0.category == category})
        {
            return groceryHistory
        }
        else
        {
            return nil
        }
    }
    
    func moveToTheFrontGroceryHistory(groceryHistory: GroceryHistory, date: Date? = nil)
    {
        if let index = groceryHistories.enumerated().first(where: {$0.element.title == groceryHistory.title && $0.element.category == groceryHistory.category})
        {
            if let date = date
            {
                groceryHistory.lastestPurchaseDate = date
            }
            else
            {
                groceryHistory.lastestPurchaseDate = Date()
            }
            
            groceryHistory.isDeleted = false
            groceryHistories.remove(at: index.offset)
            groceryHistories.insert(groceryHistory, at: 0)
            
            saveGroceryHistory()
        }
    }

    func insertGroceryHistory(id: Int, title: String, category: GroceryHistory.Category, image: GroceryImage?, updateDate: Bool)
    {
        if let groceryHistory = findGroceryHistory(id: AutoIncreasedID(id))
        {
            // 최신순으로 업데이트가 필요한 경우, 배열에서 찾아서 삭제하고 맨앞에 새로 추가함
            if(updateDate)
            {
                moveToTheFrontGroceryHistory(groceryHistory: groceryHistory)
            }
        }
        else
        {
            let groceryHistory = GroceryHistory(title: title, category: category, favorite: false, lastestPurchaseDate: Date())
            groceryHistory.id = AutoIncreasedID(id)
            if let image = image
            {
                groceryHistory.image = image
                GroceryImage.saveImage(image: image.image(), filename: image.filename)
            }
            
            groceryHistories.insert(groceryHistory, at: 0)
            
            saveGroceryHistory()
        }
    }
    
    func removeGroceryHistory(id: AutoIncreasedID)
    {
        if let selectedIndex = findGroceryHistoryIndex(id: id)
        {
            //groceryHistories.remove(at: selectedIndex.offset)
            selectedIndex.element.isDeleted = true
            saveGroceryHistory() // 로컬에 저장하기
        }
    }
    
    func updateGroceryHistory(id: AutoIncreasedID, title: String)
    {
        if let foundGroceryHistory = findGroceryHistory(id: id)
        {
            foundGroceryHistory.title = title
            
            saveGroceryHistory()
        }
    }
    
    func updateGroceryHistory(id: AutoIncreasedID, category: GroceryHistory.Category)
    {
        if let foundGroceryHistory = findGroceryHistory(id: id)
        {
            foundGroceryHistory.category = category
            saveGroceryHistory()
        }
    }
    
    func updateGroceryHistory(id: AutoIncreasedID, image: GroceryImage?)
    {
        if let foundGroceryHistory = findGroceryHistory(id: id),
           let image = image
        {
            foundGroceryHistory.image = image
            GroceryImage.saveImage(image: image.image(), filename: image.filename)
            saveGroceryHistory()
        }
    }
    
    func updateGroceryHistory(id: AutoIncreasedID, favorite: Bool)
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

    func findGroceryIndex(id: AutoIncreasedID) -> EnumeratedSequence<[Grocery]>.Element?
    {
        return groceries.enumerated().first(where: {$0.element.id == id})
    }
    
    func findGrocery(id: AutoIncreasedID) -> Grocery?
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
            groceries = Grocery.loadSampleGrocery()
        }
    }
    
    func insertGrocery(id: Int, title: String, category: GroceryHistory.Category, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Grocery.Storage, fridgeName: String, notes: String, image: GroceryImage?)
    {
        if let groceryHistory = DataManager.shared.getGroceryHistory(title: title, category: category)
        {
            let newGrocery = Grocery(info: groceryHistory, id: id, count: count, isPercentageCount: isPercentageCount, dueDate: dueDate, storage: storage, fridgeName: fridgeName, notes: notes)
            if(image != nil)
            {
                newGrocery.info.image = image
            }
            
            groceries.insert(newGrocery, at: 0)
            
            saveGrocery()
            getRequestManager().resetAlarm(grocery: newGrocery)
        }
        
    }
    
    func removeGrocery(id: AutoIncreasedID)
    {
        if let selectedIndex = findGroceryIndex(id: id)
        {
            groceries.remove(at: selectedIndex.offset)
            
            Grocery.saveGrocery(groceries)
            getRequestManager().removeAlarm(grocery: selectedIndex.element)
        }
    }
    
    func moveGrocery(fromGrocery: Grocery, toGrocery: Grocery)
    {
        if let fromIndex = findGroceryIndex(id: fromGrocery.id),
           let toIndex = findGroceryIndex(id: toGrocery.id)
        {
            groceries.remove(at: fromIndex.offset)
            groceries.insert(fromGrocery, at: toIndex.offset)
            
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, count: Int)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.count = count
            
            saveGrocery()
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, isPercentageCount: Bool)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.isPercentageCount = isPercentageCount
            
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, dueDate: DueDate)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.dueDate = dueDate
            
            Grocery.saveGrocery(groceries)
            getRequestManager().resetAlarm(grocery: foundGrocery)
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, storage: Grocery.Storage)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.storage = storage
            
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, fridgeName: String)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.fridgeName = fridgeName
            
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, notes:String?)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.notes = notes
            
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, title: String)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.info.title = title
            Grocery.saveGrocery(groceries)
            
            getRequestManager().resetAlarm(grocery: foundGrocery)
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, category: GroceryHistory.Category)
    {
        if let foundGrocery = findGrocery(id: id)
        {
            foundGrocery.info.category = category
            
            Grocery.saveGrocery(groceries)
        }
    }
    
    func updateGrocery(id: AutoIncreasedID, image: GroceryImage?)
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

//    func findCartGroceryIndex(cartGrocery: CartGrocery) -> EnumeratedSequence<[CartGrocery]>.Element?
//    {
//        return cartGroceries.enumerated().first(where: {$0.element === cartGrocery})
//    }
    
    func findCartGroceryIndex(id: AutoIncreasedID) -> EnumeratedSequence<[CartGrocery]>.Element?
    {
        return cartGroceries.enumerated().first(where: {$0.element.id == id})
    }
    
    func findCartGrocery(id: AutoIncreasedID) -> CartGrocery?
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
            cartGroceries = CartGrocery.loadSampleCartGrocery()
        }
    }
    
    // grocery history를 추가하지 않음
    func insertCartGrocery(title: String, category: GroceryHistory.Category, image: GroceryImage? = nil, id: Int, count: Int = 1, isPercentageCount: Bool = false, isPurchased: Bool = false)
    {
        if let _ = findCartGrocery(id: AutoIncreasedID(id)) { return }
        
        if let groceryHistory = DataManager.shared.getGroceryHistory(title: title, category: category)
        {
            let newCartGrocery: CartGrocery
            if(id == -1)
            {
                newCartGrocery = CartGrocery(info: groceryHistory)
            }
            else
            {
                newCartGrocery = CartGrocery(info: groceryHistory, id: id)
            }
            newCartGrocery.count = count
            newCartGrocery.isPercentageCount = isPercentageCount
            newCartGrocery.isPurchased = isPurchased
            cartGroceries.insert(newCartGrocery, at: 0)
            
            saveCartGrocery()
        }
    }
    
    func removeCartGrocery(id: AutoIncreasedID)
    {
        if let selectedIndex = findCartGroceryIndex(id: id)
        {
            cartGroceries.remove(at: selectedIndex.offset)
            saveCartGrocery()
        }
    }
    
    func updateCartGrocery(id: AutoIncreasedID, isPurchased: Bool)
    {
        if let foundCartGrocery = findCartGrocery(id: id)
        {
            foundCartGrocery.isPurchased = isPurchased
            saveCartGrocery()
        }
    }
    
    func updateCartGrocery(id: AutoIncreasedID, count: Int)
    {
        if let foundCartGrocery = findCartGrocery(id: id)
        {
            foundCartGrocery.count = count
            saveCartGrocery()
        }
    }
    
    func updateCartGrocery(id: AutoIncreasedID, isPercentage: Bool)
    {
        if let foundCartGrocery = findCartGrocery(id: id)
        {
            foundCartGrocery.isPercentageCount = isPercentage
            saveCartGrocery()
        }
    }
}
