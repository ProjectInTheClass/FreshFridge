//
//  Grocery.swift
//  TableViewTest
//
//  Created by changae choi on 2020/12/26.
//

import Foundation
import UIKit

class GroceryHistory : Codable
{
    var title: String
    var category: Category
    var favorite: Bool
    var lastestPurchaseDate: Date
    var image: GroceryImage?
    
    init(title: String, category: Category, favorite: Bool , lastestPurchaseDate: Date)
    {
        self.title = title
        self.category = category
        self.favorite = favorite
        self.lastestPurchaseDate = lastestPurchaseDate
    }
    
    init(title: String, category: Category, favorite: Bool, lastestPurchaseDate: Date, image: GroceryImage)
    {
        self.title = title
        self.category = category
        self.favorite = favorite
        self.image = image
        self.lastestPurchaseDate = lastestPurchaseDate
    }
    
    enum Category: String, CaseIterable, Codable
    {
        case MeatsAndEggs = "정육.계란"
        case MarineProducts = "수산.해산물.건어물"
        case CookingAndSidedishes = "국.반찬.메인요리"
        case Vegetable = "채소"
        case Fruits = "과일"
        case DrinksAndSnacks = "음료.간식"
        case SeasonedAndOilAndSauce = "면.양념.오일"
        case ETC = "기타"
    }
    
    static let archiveURL = getDocumentsDirectory().appendingPathComponent("groceryHistory").appendingPathExtension("plist")
    static func loadGroceryHistory() -> [GroceryHistory]?
    {
        guard let codedGroceryHistory = try? Data(contentsOf: archiveURL) else { return nil }

        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<GroceryHistory>.self, from: codedGroceryHistory)
    }
    
    static func saveGroceryHistory(_ groceryHistories: [GroceryHistory])
    {
        let propertyListEncoder = PropertyListEncoder()
        let codedGroceryHistories = try? propertyListEncoder.encode(groceryHistories)
        try? codedGroceryHistories?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSampleGroceryHistory() -> [GroceryHistory]
    {
        return [
            GroceryHistory(title: "사과", category: .Fruits, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "배", category: .Fruits, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "바나나", category: .Fruits, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "귤", category: .Fruits, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "복숭아", category: .Fruits, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "감", category: .Fruits, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "파인애플", category: .Fruits, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "토마토", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "딸기", category: .Fruits, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "고등어", category: .MarineProducts, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "김치", category: .CookingAndSidedishes, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "바나나우유", category: .DrinksAndSnacks, favorite: false, lastestPurchaseDate: Date(), image: GroceryImage(image: UIImage(named: "dumyPicture1"))),
        GroceryHistory(title: "소고기", category: .MeatsAndEggs, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "돼지고기", category: .MeatsAndEggs, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "닭고기", category: .MeatsAndEggs, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "생선", category: .MarineProducts, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "양파", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "김치", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "대파", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "고추", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "마늘", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "무", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "당근", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "애호박", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "가지", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "브로콜리", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "상추", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "양배추", category: .Vegetable, favorite: true, lastestPurchaseDate: Date()),
        GroceryHistory(title: "파프리카", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "시금치", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "감자", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "고구마", category: .Vegetable, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "두부", category: .ETC, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "라면", category: .ETC, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "소면", category: .ETC, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "햄", category: .ETC, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "계란", category: .MeatsAndEggs, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "참치", category: .ETC, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "김", category: .ETC, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "밀가루", category: .ETC, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "우유", category: .DrinksAndSnacks, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "치즈", category: .DrinksAndSnacks, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "소금", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "참기름", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "마요네즈", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "진간장", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "국간장", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "후추", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "올리브유", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "포도씨유", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "카놀라유", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "식용유", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date()),
        GroceryHistory(title: "물엿", category: .SeasonedAndOilAndSauce, favorite: false, lastestPurchaseDate: Date())]
    }
}

class Grocery : Codable
{
    var info: GroceryHistory
    
    var count: Int
    var isPercentageCount: Bool
    
    var dueDate: DueDate
    
    var storage: Storage
    var fridgeName: String
    
    var notes: String?
    
    init(info: GroceryHistory, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Storage, fridgeName: String, notes: String?)
    {
        self.info = info
        self.count = count
        self.isPercentageCount = isPercentageCount
        self.dueDate = dueDate
        self.storage = storage
        self.fridgeName = fridgeName
        self.notes = notes
    }
    
    enum Storage: Int, CaseIterable, Codable
    {
        case Refrigeration = 0
        case Freezing = 1
        case Outdoor = 2
        
        var description: String
        {
            switch self
            {
            case .Refrigeration:
                return "냉장"
            case .Freezing:
                return "냉동"
            case .Outdoor:
                return "실외"
            }
        }
    }
    
    static let archiveURL = getDocumentsDirectory().appendingPathComponent("grocery").appendingPathExtension("plist")
    static func loadGrocery() -> [Grocery]?
    {
        guard let codedGrocery = try? Data(contentsOf: archiveURL) else { return nil }

        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Grocery>.self, from: codedGrocery)
    }
    
    static func saveGrocery(_ groceries: [Grocery])
    {
        let propertyListEncoder = PropertyListEncoder()
        let codedGrocery = try? propertyListEncoder.encode(groceries)
        try? codedGrocery?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSampleGrocery() -> [Grocery]
    {
        return [Grocery(info: getGroceryHistory(title: "양파", category: .Vegetable, updateDate: true), count: 5, isPercentageCount: false, dueDate: DueDate(2), storage: .Outdoor, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "양배추", category: .Vegetable, updateDate: true), count: 1, isPercentageCount: false, dueDate: DueDate(14), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "달걀", category: .MeatsAndEggs, updateDate: true), count: 30, isPercentageCount: false, dueDate: DueDate(-1), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "치즈", category: .DrinksAndSnacks, updateDate: true), count: 14, isPercentageCount: false, dueDate: DueDate(14), storage: .Refrigeration, fridgeName: selectedfrideName, notes: "아기 먹일 유기농 치즈"),
                Grocery(info: getGroceryHistory(title: "이유식용 소고기", category: .MeatsAndEggs, updateDate: true), count: 100, isPercentageCount: true, dueDate: DueDate(30), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "사과", category: .Fruits, updateDate: true), count: 5, isPercentageCount: false, dueDate: DueDate(8), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "고등어", category: .MarineProducts, updateDate: true), count: 3, isPercentageCount: false, dueDate: DueDate(3), storage: .Freezing, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "김치", category: .CookingAndSidedishes, updateDate: true), count: 30, isPercentageCount: true, dueDate: DueDate(60), storage: .Refrigeration, fridgeName: selectedfrideName, notes: "19년도 김장 김치"),
                Grocery(info: getGroceryHistory(title: "바나나우유", category: .DrinksAndSnacks, updateDate: true), count: 10, isPercentageCount: false, dueDate: DueDate(90), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "딸기", category: .Fruits, updateDate: true), count: 100, isPercentageCount: true, dueDate: DueDate(10), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "사과", category: .Fruits, updateDate: true), count: 8, isPercentageCount: false, dueDate: DueDate(5), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "바나나", category: .Fruits, updateDate: true), count: 6, isPercentageCount: false, dueDate: DueDate(2), storage: .Outdoor, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "요거트", category: .DrinksAndSnacks, updateDate: true), count: 6, isPercentageCount: false, dueDate: DueDate(7), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "당근", category: .Vegetable, updateDate: true), count: 3, isPercentageCount: false, dueDate: DueDate(10), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "바닐라 아이스크림", category: .DrinksAndSnacks, updateDate: true), count: 80, isPercentageCount: true, dueDate: DueDate(21), storage: .Freezing, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "진간장", category: .SeasonedAndOilAndSauce, updateDate: true), count: 40, isPercentageCount: true, dueDate: DueDate(180), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "멸치액젓", category: .SeasonedAndOilAndSauce, updateDate: true), count: 90, isPercentageCount: true, dueDate: DueDate(180), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "토마토케찹", category: .SeasonedAndOilAndSauce, updateDate: true), count: 10, isPercentageCount: true, dueDate: DueDate(210), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "냉동 돈까스", category: .MeatsAndEggs, updateDate: true), count: 8, isPercentageCount: false, dueDate: DueDate(60), storage: .Freezing, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "냉동 돈까스", category: .MeatsAndEggs, updateDate: true), count: 2, isPercentageCount: false, dueDate: DueDate(30), storage: .Freezing, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "참치캔", category: .MeatsAndEggs, updateDate: true), count: 15, isPercentageCount: false, dueDate: DueDate(210), storage: .Outdoor, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: getGroceryHistory(title: "쌀", category: .ETC, updateDate: true), count: 70, isPercentageCount: true, dueDate: DueDate(60), storage: .Outdoor, fridgeName: selectedfrideName, notes: nil)
        ]
    }
}

class CartGrocery: Codable
{
    var info: GroceryHistory
    var isPurchased: Bool = false
    var count: Int = 1
    var isPercentageCount: Bool = false
    
    init(info: GroceryHistory) {
        self.info = info
    }
    
    static let archiveURL = getDocumentsDirectory().appendingPathComponent("cartGrocery").appendingPathExtension("plist")
    static func loadCartGrocery() -> [CartGrocery]?
    {
        guard let codedCartGrocery = try? Data(contentsOf: archiveURL) else { return nil }

        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<CartGrocery>.self, from: codedCartGrocery)
    }
    
    static func saveCartGrocery(_ groceries: [CartGrocery])
    {
        let propertyListEncoder = PropertyListEncoder()
        let codedCartGrocery = try? propertyListEncoder.encode(cartGroceries)
        try? codedCartGrocery?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSampleCartGrocery() -> [CartGrocery]
    {
        return [ CartGrocery(info: getGroceryHistory(title: "양배추", category: .Vegetable, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "달걀", category: .MeatsAndEggs, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "양파", category: .Vegetable, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "고등어", category: .MarineProducts, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "김치", category: .CookingAndSidedishes, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "양파", category: .Vegetable, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "사과", category: .Fruits, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "바나나", category: .Fruits, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "요거트", category: .DrinksAndSnacks, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "당근", category: .Vegetable, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "바닐라 아이스크림", category: .DrinksAndSnacks, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "진간장", category: .SeasonedAndOilAndSauce, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "멸치액젓", category: .SeasonedAndOilAndSauce, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "토마토케찹", category: .SeasonedAndOilAndSauce, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "냉동 돈까스", category: .MeatsAndEggs, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "냉동 돈까스", category: .MeatsAndEggs, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "참치캔", category: .MeatsAndEggs, updateDate: true)),
                 CartGrocery(info: getGroceryHistory(title: "쌀", category: .ETC, updateDate: true))
        ]
    }
}

struct DueDate: Codable
{
    static let secondOfDay: Double = 60*60*24.0
    
    var date: Date
        
    init(_ addingDay: Int)
    {
        date = Date().addingTimeInterval(DueDate.secondOfDay*Double(addingDay))
    }
    
    mutating func addDays(_ addingDay: Int)
    {
        date.addTimeInterval(DueDate.secondOfDay*Double(addingDay))
    }
    
    mutating func addMonth()
    {
        let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: date)
        date = nextMonthDate ?? date
    }
    
    func getExpirationDay() -> String
    {
        let diffDate = date.timeIntervalSinceNow
        let diffDay = Int(diffDate/(DueDate.secondOfDay))
        return diffDay>=0 ? String("D-\(diffDay+1)") : String("D+\(-diffDay)")
    }
}

func getGroceryHistory(title: String, category: GroceryHistory.Category, updateDate: Bool) -> GroceryHistory
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
            }
        }
        
        return groceryHistory
    }
    else
    {
        let groceryHistory = GroceryHistory(title: title, category: category, favorite: .init(), lastestPurchaseDate: Date())
        groceryHistories.insert(groceryHistory, at: 0)
        return groceryHistory
    }
}

func findGroceryIndex(grocery: Grocery) -> EnumeratedSequence<[Grocery]>.Element?
{
    return groceries.enumerated().first(where: {$0.element === grocery})
}

func findGroceryHistoryIndex(groceryHistory: GroceryHistory) -> EnumeratedSequence<[GroceryHistory]>.Element? {
    return groceryHistories.enumerated().first(where: {$0.element === groceryHistory})
}

func findGroceryIndex(grocery: CartGrocery) -> EnumeratedSequence<[CartGrocery]>.Element?
{
    return cartGroceries.enumerated().first(where: {$0.element === grocery})
}

func getDocumentsDirectory() -> URL
{
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

let systemFont15 = UIFont.systemFont(ofSize: 15)


// 메인뷰 냉장고 이름 선택
var fridgeNames = ["신선한냉장고", "김치냉장고", "추가냉장고1", "추가냉장고2"]
var selectedFridgeIndex: [Int] = [0] // 다중 선택가능, fridgeNames index를 배열로 저장한다.
var selectedfrideName = fridgeNames[selectedFridgeIndex[0]] // 다중선택된 selectedFridgeIndex중 첫번째 것으로 할당

let defaultNames = [
    "소고기", "돼지고기", "닭고기", "생선",
    "양파", "김치", "대파", "고추",
    "마늘", "무", "당근", "애호박",
    "가지", "브로콜리", "상추", "양배추",
    "파프리카", "시금치", "감자", "고구마",
    "두부", "라면", "소면", "햄",
    "계란", "참치", "김", "밀가루",
    "우유", "소금", "참기름", "마요네즈",
    "진간장", "국간장", "후추", "올리브유",
    "포도씨유", "카놀라유", "식용유", "물엿"]

// 메인뷰의 필터링
typealias FridgeViewFilter = Grocery.Storage

// 메인뷰의 소팅
enum FridgeViewSort: Int, CaseIterable
{
    case CategoryFilter = 0
    
    var description: String
    {
        switch self
        {
        case .CategoryFilter:
            return "분류별"
        }
    }
}

var groceryHistories = [GroceryHistory]()
var groceries = [Grocery]()
var cartGroceries = [CartGrocery]()



