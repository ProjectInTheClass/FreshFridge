//
//  Grocery.swift
//  TableViewTest
//
//  Created by changae choi on 2020/12/26.
//

import Foundation
import UIKit

struct DueDate: Codable
{
    static let secondOfDay: Double = 60*60*24.0
    
    var date: Date
    
    init(_ addingDay: Int)
    {
        date = Date().addingTimeInterval(DueDate.secondOfDay*Double(addingDay))
    }
}

class TypedImage: Codable
{
    var filename: String
    var fileExtension: String = "png"
    
    init(filename: String)
    {
        self.filename = filename
    }
    
    init(image: UIImage?)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM_dd_yyyy_HH_mm_ss_SSS"
        filename = dateFormatter.string(from: Date())
        
        if let image = image
        {
            makeImage(uiImage: image)
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

func getDocumentsDirectory() -> URL
{
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

class GroceryHistory : Codable
{
    var title: String
    var category: Category
    var favorite: Bool = false
    var lastestPurchaseDate: Date
    var image: TypedImage?
    
    init(title: String, category: Category, lastestPurchaseDate: Date)
    {
        self.title = title
        self.category = category
        self.lastestPurchaseDate = lastestPurchaseDate
    }
    
    init(title: String, category: Category, lastestPurchaseDate: Date, image: TypedImage)
    {
        self.title = title
        self.category = category
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
            GroceryHistory(title: "사과", category: .Fruits, lastestPurchaseDate: Date()),
        GroceryHistory(title: "배", category: .Fruits, lastestPurchaseDate: Date()),
        GroceryHistory(title: "바나나", category: .Fruits, lastestPurchaseDate: Date()),
        GroceryHistory(title: "귤", category: .Fruits, lastestPurchaseDate: Date()),
        GroceryHistory(title: "복숭아", category: .Fruits, lastestPurchaseDate: Date()),
        GroceryHistory(title: "감", category: .Fruits, lastestPurchaseDate: Date()),
        GroceryHistory(title: "파인애플", category: .Fruits, lastestPurchaseDate: Date()),
        GroceryHistory(title: "토마토", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "딸기", category: .Fruits, lastestPurchaseDate: Date()),
        GroceryHistory(title: "고등어", category: .MarineProducts, lastestPurchaseDate: Date()),
        GroceryHistory(title: "김치", category: .CookingAndSidedishes, lastestPurchaseDate: Date()),
        GroceryHistory(title: "바나나우유", category: .DrinksAndSnacks, lastestPurchaseDate: Date(), image: TypedImage(image: UIImage(named: "dumyPicture1"))),
        GroceryHistory(title: "소고기", category: .MeatsAndEggs, lastestPurchaseDate: Date()),
        GroceryHistory(title: "돼지고기", category: .MeatsAndEggs, lastestPurchaseDate: Date()),
        GroceryHistory(title: "닭고기", category: .MeatsAndEggs, lastestPurchaseDate: Date()),
        GroceryHistory(title: "생선", category: .MarineProducts, lastestPurchaseDate: Date()),
        GroceryHistory(title: "양파", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "김치", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "대파", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "고추", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "마늘", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "무", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "당근", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "애호박", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "가지", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "브로콜리", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "상추", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "양배추", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "파프리카", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "시금치", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "감자", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "고구마", category: .Vegetable, lastestPurchaseDate: Date()),
        GroceryHistory(title: "두부", category: .ETC, lastestPurchaseDate: Date()),
        GroceryHistory(title: "라면", category: .ETC, lastestPurchaseDate: Date()),
        GroceryHistory(title: "소면", category: .ETC, lastestPurchaseDate: Date()),
        GroceryHistory(title: "햄", category: .ETC, lastestPurchaseDate: Date()),
        GroceryHistory(title: "계란", category: .MeatsAndEggs, lastestPurchaseDate: Date()),
        GroceryHistory(title: "참치", category: .ETC, lastestPurchaseDate: Date()),
        GroceryHistory(title: "김", category: .ETC, lastestPurchaseDate: Date()),
        GroceryHistory(title: "밀가루", category: .ETC, lastestPurchaseDate: Date()),
        GroceryHistory(title: "우유", category: .DrinksAndSnacks, lastestPurchaseDate: Date()),
        GroceryHistory(title: "치즈", category: .DrinksAndSnacks, lastestPurchaseDate: Date()),
        GroceryHistory(title: "소금", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date()),
        GroceryHistory(title: "참기름", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date()),
        GroceryHistory(title: "마요네즈", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date()),
        GroceryHistory(title: "진간장", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date()),
        GroceryHistory(title: "국간장", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date()),
        GroceryHistory(title: "후추", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date()),
        GroceryHistory(title: "올리브유", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date()),
        GroceryHistory(title: "포도씨유", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date()),
        GroceryHistory(title: "카놀라유", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date()),
        GroceryHistory(title: "식용유", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date()),
        GroceryHistory(title: "물엿", category: .SeasonedAndOilAndSauce, lastestPurchaseDate: Date())]
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
        return [Grocery(info: getGroceryHistory(title: "양파", category: .Vegetable), count: 5, isPercentageCount: false, dueDate: DueDate(2), storage: .Outdoor, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "양배추", category: .Vegetable), count: 1, isPercentageCount: false, dueDate: DueDate(14), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "달걀", category: .MeatsAndEggs), count: 30, isPercentageCount: false, dueDate: DueDate(-1), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "치즈", category: .DrinksAndSnacks), count: 14, isPercentageCount: false, dueDate: DueDate(14), storage: .Refrigeration, fridgeName: selectedfrideName, notes: "아기 먹일 유기농 치즈"),
        Grocery(info: getGroceryHistory(title: "이유식용 소고기", category: .MeatsAndEggs), count: 100, isPercentageCount: true, dueDate: DueDate(30), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "사과", category: .Fruits), count: 5, isPercentageCount: false, dueDate: DueDate(8), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "고등어", category: .MarineProducts), count: 3, isPercentageCount: false, dueDate: DueDate(3), storage: .Freezing, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "김치", category: .CookingAndSidedishes), count: 30, isPercentageCount: true, dueDate: DueDate(60), storage: .Refrigeration, fridgeName: selectedfrideName, notes: "19년도 김장 김치"),
        Grocery(info: getGroceryHistory(title: "바나나우유", category: .DrinksAndSnacks), count: 10, isPercentageCount: false, dueDate: DueDate(90), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "딸기", category: .Fruits), count: 100, isPercentageCount: true, dueDate: DueDate(10), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "사과", category: .Fruits), count: 8, isPercentageCount: false, dueDate: DueDate(5), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "바나나", category: .Fruits), count: 6, isPercentageCount: false, dueDate: DueDate(2), storage: .Outdoor, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "요거트", category: .DrinksAndSnacks), count: 6, isPercentageCount: false, dueDate: DueDate(7), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "당근", category: .Vegetable), count: 3, isPercentageCount: false, dueDate: DueDate(10), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "바닐라 아이스크림", category: .DrinksAndSnacks), count: 80, isPercentageCount: true, dueDate: DueDate(21), storage: .Freezing, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "진간장", category: .SeasonedAndOilAndSauce), count: 40, isPercentageCount: true, dueDate: DueDate(180), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "멸치액젓", category: .SeasonedAndOilAndSauce), count: 90, isPercentageCount: true, dueDate: DueDate(180), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "토마토케찹", category: .SeasonedAndOilAndSauce), count: 10, isPercentageCount: true, dueDate: DueDate(210), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "냉동 돈까스", category: .MeatsAndEggs), count: 8, isPercentageCount: false, dueDate: DueDate(60), storage: .Freezing, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "냉동 돈까스", category: .MeatsAndEggs), count: 2, isPercentageCount: false, dueDate: DueDate(30), storage: .Freezing, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "참치캔", category: .MeatsAndEggs), count: 15, isPercentageCount: false, dueDate: DueDate(210), storage: .Outdoor, fridgeName: selectedfrideName, notes: nil),
        Grocery(info: getGroceryHistory(title: "쌀", category: .ETC), count: 70, isPercentageCount: true, dueDate: DueDate(60), storage: .Outdoor, fridgeName: selectedfrideName, notes: nil)
        ]
    }
}

class CartGrocery: Codable
{
    var info: GroceryHistory
    var isPurchased: Bool = false
    
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
        return [ CartGrocery(info: getGroceryHistory(title: "양배추", category: .Vegetable)),
            CartGrocery(info: getGroceryHistory(title: "달걀", category: .MeatsAndEggs)),
            CartGrocery(info: getGroceryHistory(title: "양파", category: .Vegetable)),
            CartGrocery(info: getGroceryHistory(title: "고등어", category: .MarineProducts)),
            CartGrocery(info: getGroceryHistory(title: "김치", category: .CookingAndSidedishes)),
        ]
    }
}


func getGroceryHistory(title: String, category: GroceryHistory.Category) -> GroceryHistory
{
    if let groceryHistory = groceryHistories.first(where: {$0.title == title && $0.category == category})
    {
        return groceryHistory
    }
    else
    {
        let groceryHistory = GroceryHistory(title: title, category: category, lastestPurchaseDate: Date())
        groceryHistories.append(groceryHistory)
        return groceryHistory
    }
}


// 메인뷰 냉장고 이름 선택
var fridgeNames = ["신선한냉장고", "김치냉장고", "추가냉장고1", "추가냉장고2"]
var selectedFridgeIndex: [Int] = [0] // 다중 선택가능, fridgeNames index를 배열로 저장한다.
var selectedfrideName = fridgeNames[selectedFridgeIndex[0]] // 다중선택된 selectedFridgeIndex중 첫번째 것으로 할당

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


//var groceryHistories: [GroceryHistory] = []
//var groceries: [Grocery] = []
//var cartGroceries: [CartGerocery] = []

// adding dumy data
var groceryHistories = [GroceryHistory]()
var groceries = [Grocery]()
var cartGroceries = [CartGrocery]()



