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
    
    func findGroceryHistoryIndex(id: UUID) -> GroceryHistory?
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
        if let foundGroceryHistory = findGroceryHistoryIndex(id: id)
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
    func saveCartGrocery()
    {
    }
    
    func loadCartGrocery()
    {
    }
    
    func addCartGrocery()
    {
    }
    
    func removeCartGrocery()
    {
    }
}
