//
//  Grocery.swift
//  TableViewTest
//
//  Created by changae choi on 2020/12/26.
//

import Foundation
import UIKit

struct DueDate
{
    static let secondOfDay: Double = 60*60*24.0
    
    var date: Date
    
    init(_ addingDay: Int)
    {
        date = Date().addingTimeInterval(DueDate.secondOfDay*Double(addingDay))
    }
}

class TypedImage
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
    
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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

class GroceryHistory
{
    var title: String
    var category: Category
    var favorite: Bool = false
    var lastestPurchaseDate: Date = Date() // 냉장고에 추가 될때 갱신하도록
    var image: TypedImage?
    
    init(title: String, category: Category)
    {
        self.title = title
        self.category = category
    }
    
    init(title: String, category: Category, image: TypedImage)
    {
        self.title = title
        self.category = category
        self.image = image
    }
    
    enum Category: String, CaseIterable
    {
        case ETC = "ETC"
        case MeatsAndEggs = "MeatsAndEggs"
        case MarineProducts = "MarineProducts"
        case CookingAndSidedishes = "CookingAndSidedishes"
        case Vegetable = "Vegetable"
        case Fruits = "Fruits"
        case DrinksAndSnacks = "DrinksAndSnacks"
        case SeasonedAndOilAndSauce = "SeasonedAndOilAndSauce"
    }
}



class Grocery
{
    var info: GroceryHistory
    
    var count: Double
    var isPercentageCount: Bool
    
    var dueDate: DueDate
    
    var storage: Storage
    var fridgeName: String
    
    var notes: String?
    
    init(info: GroceryHistory, count: Double, isPercentageCount: Bool, dueDate: DueDate, storage: Storage, fridgeName: String, notes: String?)
    {
        self.info = info
        self.count = count
        self.isPercentageCount = isPercentageCount
        self.dueDate = dueDate
        self.storage = storage
        self.fridgeName = fridgeName
        self.notes = notes
    }
    
    enum Storage: Int, CaseIterable 
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
}

class CartGerocery
{
    var info: GroceryHistory
    var isPurchased: Bool = false
    
    init(info: GroceryHistory) {
        self.info = info
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
        let groceryHistory = GroceryHistory(title: title, category: category)
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
var groceryHistories = [
    GroceryHistory(title: "양파", category: .Vegetable),
    GroceryHistory(title: "양배추", category: .Vegetable),
    GroceryHistory(title: "달걀", category: .MeatsAndEggs),
    GroceryHistory(title: "치즈", category: .MeatsAndEggs),
    GroceryHistory(title: "이유식용 소고기", category: .MeatsAndEggs),
    GroceryHistory(title: "사과", category: .Fruits),
    GroceryHistory(title: "고등어", category: .MarineProducts),
    GroceryHistory(title: "김치", category: .CookingAndSidedishes),
    GroceryHistory(title: "바나나우유", category: .CookingAndSidedishes, image: TypedImage(image: UIImage(named: "dumyPicture1")) ),
    GroceryHistory(title: "면사랑)해물볶음우동370g(냉동)", category: .CookingAndSidedishes)
]

var groceries = [
    Grocery(info: getGroceryHistory(title: "양파", category: .Vegetable), count: 5, isPercentageCount: false, dueDate: DueDate(2), storage: .Outdoor, fridgeName: selectedfrideName, notes: nil),
    Grocery(info: getGroceryHistory(title: "양배추", category: .Vegetable), count: 1, isPercentageCount: false, dueDate: DueDate(14), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
    Grocery(info: getGroceryHistory(title: "달걀", category: .MeatsAndEggs), count: 30, isPercentageCount: false, dueDate: DueDate(-1), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
    Grocery(info: getGroceryHistory(title: "치즈", category: .CookingAndSidedishes), count: 14, isPercentageCount: false, dueDate: DueDate(14), storage: .Refrigeration, fridgeName: selectedfrideName, notes: "아기 먹일 유기농 치즈"),
    Grocery(info: getGroceryHistory(title: "이유식용 소고기", category: .MeatsAndEggs), count: 1, isPercentageCount: true, dueDate: DueDate(30), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
    Grocery(info: getGroceryHistory(title: "사과", category: .Fruits), count: 5, isPercentageCount: false, dueDate: DueDate(8), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
    Grocery(info: getGroceryHistory(title: "고등어", category: .MarineProducts), count: 3, isPercentageCount: false, dueDate: DueDate(3), storage: .Freezing, fridgeName: selectedfrideName, notes: nil),
    Grocery(info: getGroceryHistory(title: "김치", category: .CookingAndSidedishes), count: 0.3, isPercentageCount: true, dueDate: DueDate(60), storage: .Refrigeration, fridgeName: selectedfrideName, notes: "19년도 김장 김치"),
    Grocery(info: getGroceryHistory(title: "바나나우유", category: .CookingAndSidedishes), count: 10, isPercentageCount: false, dueDate: DueDate(90), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
    Grocery(info: getGroceryHistory(title: "면사랑)해물볶음우동370g(냉동)", category: .CookingAndSidedishes), count: 5, isPercentageCount: false, dueDate: DueDate(30), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil)
    ]

var cartGroceries: [CartGerocery] = [
    CartGerocery(info: getGroceryHistory(title: "양배추", category: .Vegetable)),
    CartGerocery(info: getGroceryHistory(title: "달걀", category: .MeatsAndEggs)),
    CartGerocery(info: getGroceryHistory(title: "양파", category: .Vegetable)),
    CartGerocery(info: getGroceryHistory(title: "고등어", category: .MarineProducts)),
    CartGerocery(info: getGroceryHistory(title: "김치", category: .CookingAndSidedishes)),
]


