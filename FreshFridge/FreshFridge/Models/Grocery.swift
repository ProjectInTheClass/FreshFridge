//
//  Grocery.swift
//  TableViewTest
//
//  Created by changae choi on 2020/12/26.
//

import Foundation
import UIKit

class AutoIncreasedID: Codable, Equatable
{
    let id: Int
    var string: String
    {
        return "\(id)"
    }
    
    init(_ id: Int)
    {
        if id == -1
        {
            self.id = AutoIncreasedID.generateID()
        }
        else
        {
            self.id = id
        }
    }
    
    init()
    {
        self.id = AutoIncreasedID.generateID()
    }
    
    static func == (lhs: AutoIncreasedID, rhs: AutoIncreasedID) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func generateID() -> Int
    {
        var generated = UserDefaults.standard.integer(forKey: "generatedAutoIncreasedID")
        generated += 1
        UserDefaults.standard.set(generated, forKey: "generatedAutoIncreasedID")
        UserDefaults.standard.synchronize()
        return generated
    }
}

class GroceryHistory : Codable
{
    static func == (lhs: GroceryHistory, rhs: GroceryHistory) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: AutoIncreasedID
    var title: String
    var category: Category
    var favorite: Bool
    var lastestPurchaseDate: Date
    var image: GroceryImage?
    var isDeleted: Bool = false
    
    init()
    {
        self.id = AutoIncreasedID()
        self.title = ""
        self.category = Category.ETC
        self.favorite = false
        self.lastestPurchaseDate = Date()
    }
    
    init(title: String, category: Category, image: GroceryImage)
    {
        self.id = AutoIncreasedID()
        self.title = title
        self.category = category
        self.favorite = false
        self.lastestPurchaseDate = Date()
        self.image = image
    }
    
    init(title: String, category: Category, favorite: Bool , lastestPurchaseDate: Date)
    {
        self.id = AutoIncreasedID()
        self.title = title
        self.category = category
        self.favorite = favorite
        self.lastestPurchaseDate = lastestPurchaseDate
    }
    
    init(title: String, category: Category, favorite: Bool, lastestPurchaseDate: Date, image: GroceryImage)
    {
        self.id = AutoIncreasedID()
        self.title = title
        self.category = category
        self.favorite = favorite
        self.image = image
        self.lastestPurchaseDate = lastestPurchaseDate
    }
    
    enum Category: Int, CaseIterable, Codable
    {
        case MeatsAndEggs = 0
        case MarineProducts = 1
        case CookingAndSidedishes = 2
        case Vegetable = 3
        case Fruits = 4
        case Milk = 5
        case DrinksAndSnacks = 6
        case SeasonedAndOilAndSauce = 7
        case GrainAndNuts = 8
        case ETC = 9
        
        var description: String
        {
            switch self
            {
            case .MeatsAndEggs:
                return "정육.계란".localized()
            case .Milk:
                return "우유.유제품".localized()
            case .MarineProducts:
                return "수산.해산물.건어물".localized()
            case .CookingAndSidedishes:
                return "국.반찬.메인요리".localized()
            case .Vegetable:
                return "채소".localized()
            case .Fruits:
                return "과일".localized()
            case .DrinksAndSnacks:
                return "음료.간식".localized()
            case .SeasonedAndOilAndSauce:
                return "면.양념.오일".localized()
            case .GrainAndNuts:
                return "쌀.잡곡.견과류".localized()
            case .ETC:
                return "기타".localized()
            }
        }
        
        var systemName: String
        {
            switch self
            {
            case .MeatsAndEggs:
                return "Meat, Eggs"
            case .Milk:
                return "Milk, Dairy products"
            case .MarineProducts:
                return "Marine Products"
            case .CookingAndSidedishes:
                return "Main Dish, Side Dish"
            case .Vegetable:
                return "Vegetable"
            case .Fruits:
                return "Fruit"
            case .DrinksAndSnacks:
                return "Drinks, Snacks"
            case .SeasonedAndOilAndSauce:
                return "Noodles, Seasoning, Oil"
            case .GrainAndNuts:
                return "Grains, Nuts"
            case .ETC:
                return "Etc"
            }
        }
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
        return []
    }
}

class Grocery : Codable
{
    var id: AutoIncreasedID
    
    var info: GroceryHistory
    
    var count: Int
    var isPercentageCount: Bool
    
    var dueDate: DueDate
    
    var storage: Storage
    var fridgeName: String
    
    var notes: String?
    
    init(info: GroceryHistory, id: Int, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Storage, fridgeName: String, notes: String?)
    {
        self.id = AutoIncreasedID(id)
        self.info = info
        self.count = count
        self.isPercentageCount = isPercentageCount
        self.dueDate = dueDate
        self.storage = storage
        self.fridgeName = fridgeName
        self.notes = notes
    }
    
    init(info: GroceryHistory, count: Int, isPercentageCount: Bool, dueDate: DueDate, storage: Storage, fridgeName: String, notes: String?)
    {
        self.id = AutoIncreasedID()
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
                return "냉장".localized()
            case .Freezing:
                return "냉동".localized()
            case .Outdoor:
                return "실외".localized()
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
        let id = -1
        //사과 - 냉장보관 - 6개 - D-5
        //아이스크림 - 냉동보관 - 40% - D-50
        //양파 - 실외보관 - 2개 - D-2
        if nil == DataManager.shared.getGroceryHistory(title: "사과".localized(), category: .Fruits)
        {
            let image = GroceryImage(image: UIImage(named: "사과"))
            DataManager.shared.insertGroceryHistory(id: id, title: "사과".localized(), category: .Fruits, image: image, updateDate: false)
            //GroceryImage.saveImage(image: image.image(), filename: image.filename)
            
        }
        
        if( nil == DataManager.shared.getGroceryHistory(title: "아이스크림".localized(), category: .DrinksAndSnacks))
        {
            let image = GroceryImage(image: UIImage(named: "아이스크림"))
            DataManager.shared.insertGroceryHistory(id: id, title: "아이스크림".localized(), category: .DrinksAndSnacks, image: image, updateDate: false)
            //GroceryImage.saveImage(image: image.image(), filename: image.filename)
        }
        
        if( nil == DataManager.shared.getGroceryHistory(title: "양파".localized(), category: .Vegetable) )
        {
            let image = GroceryImage(image: UIImage(named: "양파"))
            DataManager.shared.insertGroceryHistory(id: id, title: "양파".localized(), category: .Vegetable, image: image, updateDate: false)
            //GroceryImage.saveImage(image: image.image(), filename: image.filename)
        }
        
        return [Grocery(info: DataManager.shared.getGroceryHistory(title: "사과".localized(), category: .Fruits)!, count: 6, isPercentageCount: false, dueDate: DueDate(5), storage: .Refrigeration, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: DataManager.shared.getGroceryHistory(title: "아이스크림".localized(), category: .DrinksAndSnacks)!, count: 40, isPercentageCount: true, dueDate: DueDate(50), storage: .Freezing, fridgeName: selectedfrideName, notes: nil),
                Grocery(info: DataManager.shared.getGroceryHistory(title: "양파".localized(), category: .Vegetable)!, count: 2, isPercentageCount: false, dueDate: DueDate(2), storage: .Outdoor, fridgeName: selectedfrideName, notes: nil)
        ]
    }
}

class CartGrocery: Codable
{
    var id: AutoIncreasedID
    
    var info: GroceryHistory
    
    var isPurchased: Bool = false
    var count: Int = 1
    var isPercentageCount: Bool = false
    
    init(info: GroceryHistory)
    {
        self.id = AutoIncreasedID()
        self.info = info
    }
    
    init(info: GroceryHistory, id: Int)
    {
        self.id = AutoIncreasedID(id)
        self.info = info
    }
    
    static let archiveURL = getDocumentsDirectory().appendingPathComponent("cartGrocery").appendingPathExtension("plist")
    static func loadCartGrocery() -> [CartGrocery]?
    {
        guard let codedCartGrocery = try? Data(contentsOf: archiveURL) else { return nil }

        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<CartGrocery>.self, from: codedCartGrocery)
    }
    
    static func saveCartGrocery(_ cartGroceries: [CartGrocery])
    {
        let propertyListEncoder = PropertyListEncoder()
        let codedCartGrocery = try? propertyListEncoder.encode(cartGroceries)
        try? codedCartGrocery?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSampleCartGrocery() -> [CartGrocery]
    {
        //let id = -1
        //DataManager.shared.insertGroceryHistory(id: id, title: "양배추", category: .Vegetable, image: nil, updateDate: true)
        //DataManager.shared.insertGroceryHistory(id: id, title: "달걀", category: .MeatsAndEggs, image: nil, updateDate: true)
        //return [ CartGrocery(info: DataManager.shared.getGroceryHistory(title: "양배추", category: .Vegetable)!),
        //         CartGrocery(info: DataManager.shared.getGroceryHistory(title: "달걀", category: .MeatsAndEggs)!)
        //]
        return []
    }
}

struct DueDate: Codable
{
    static let secondOfDay: Double = 60*60*24.0
    
    var date: Date
    
    init(date: Date)
    {
        self.date = Calendar.current.startOfDay(for: date)
    }
        
    init(_ addingDay: Int)
    {
        date = Calendar.current.startOfDay(for: Date())
        //date.addingTimeInterval(DueDate.secondOfDay*Double(addingDay))
        self.addDays(addingDay)
    }
    
    init(timeIntervalSince1970MS: Int)
    {
        date = Date(timeIntervalSince1970: TimeInterval(timeIntervalSince1970MS / 1000))
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
    
    func getExpiration() -> Int
    {
        let todayMidnight = Calendar.current.startOfDay(for: Date())//.date(bySettingHour: 9, minute: 0, second: 0, of: date)!
        let diffDate = date.timeIntervalSince(todayMidnight)
        let diffDay : Double = (diffDate/(DueDate.secondOfDay))
        return Int(-diffDay)
    }
    
    func getExpirationDay() -> String
    {
        let diffDay = getExpiration()
        return diffDay<0 ? String("D\(diffDay)") : String("D+\(diffDay)")
    }
    
    func getTimeIntervalSince1970MS() -> Int
    {
        return Int(date.timeIntervalSince1970) * 1000
    }
    
    static func getTimeIntervalSince1970MS(date: Date) -> Int
    {
        return Int(date.timeIntervalSince1970) * 1000
    }
}


func presentAlertOkCancel(title: String, message: String = "", parent: UIViewController, okHandler: @escaping ((UIAlertAction) -> Void))
{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let ok = UIAlertAction(title: "Ok".localized(), style: .default, handler: okHandler)
    alert.addAction(ok)
    
    let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel)
    alert.addAction(cancel)
    
    parent.present(alert, animated: true, completion: nil)
}

func presentAlertOk(title: String, message: String = "", parent: UIViewController)
{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "Ok".localized(), style: .default, handler: nil)
    alert.addAction(ok)
    
    parent.present(alert, animated: true, completion: nil)
}

func presentAlertYesNoCancel(title: String, message: String = "", parent: UIViewController, yes: UIAlertAction, no: UIAlertAction)
{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(yes)
    alert.addAction(no)
    
    parent.present(alert, animated: true, completion: nil)
}



func getDocumentsDirectory() -> URL
{
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

let systemFont18 = UIFont.systemFont(ofSize: 18)
let systemFont10 = UIFont.systemFont(ofSize: 10)


// 메인뷰 냉장고 이름 선택
var fridgeNames = ["신선한냉장고", "김치냉장고", "추가냉장고1", "추가냉장고2"]
var selectedFridgeIndex: [Int] = [0, 1, 2, 3] // 다중 선택가능, fridgeNames index를 배열로 저장한다.
var selectedfrideName = fridgeNames[selectedFridgeIndex[0]] // 다중선택된 selectedFridgeIndex중 첫번째 것으로 할당



var defaultNames : [String:GroceryHistory.Category] = [:]
func getDefaultNames() -> [String:GroceryHistory.Category]
{
    let langStr = Locale.current.languageCode
    switch(langStr)
    {
    case "en": // reference : https://www.loveandlemons.com/what-is-fennel/
        return [
            "Soda":.DrinksAndSnacks, "Milk":.DrinksAndSnacks, "Bread":.DrinksAndSnacks, "Beer":.DrinksAndSnacks,
            "Olive oil":.SeasonedAndOilAndSauce, "Flour":.GrainAndNuts, "Butter":.Milk, "Chicken":.MeatsAndEggs,
            "Sugar":.SeasonedAndOilAndSauce, "Salt":.SeasonedAndOilAndSauce, "Egg":.MeatsAndEggs, "Rice":.GrainAndNuts,
            "Pork":.MeatsAndEggs, "Beef":.MeatsAndEggs, "Cheese":.Milk, "Garlic":.Vegetable,
            "Orange":.Fruits, "Turkey":.MeatsAndEggs, "Onion":.Vegetable, "Corn":.Vegetable,
            "Whole milk":.Milk, "Mayonnaise":.SeasonedAndOilAndSauce, "Chiles":.SeasonedAndOilAndSauce,
            "Almonds":.GrainAndNuts, "Bacon":.MeatsAndEggs, "Mushrooms":.Vegetable, "Coconut":.Fruits,
            "Beets":.Vegetable, "Strawberries":.Fruits, "Fennel":.Vegetable, "Lamb":.MeatsAndEggs,
            "Apple":.Fruits, "Shrimp":.MarineProducts, "Vegetable oil":.SeasonedAndOilAndSauce, "Fish":.MarineProducts
        ]
    case "ko":
        return [
        "쇠고기":.MeatsAndEggs, "돼지고기":.MeatsAndEggs, "닭고기":.MeatsAndEggs, "햄":.MeatsAndEggs, "계란":.MeatsAndEggs,
        "김치":.CookingAndSidedishes,
        "양파":.Vegetable, "대파":.Vegetable, "고추":.Vegetable,
        "마늘":.Vegetable, "무":.Vegetable, "당근":.Vegetable, "애호박":.Vegetable,
        "가지":.Vegetable, "브로콜리":.Vegetable, "상추":.Vegetable, "양배추":.Vegetable,
        "파프리카":.Vegetable, "시금치":.Vegetable, "감자":.Vegetable, "고구마":.Vegetable,
        "두부":.ETC, "라면소면":.ETC,
        "생선":.MarineProducts, "참치":.MarineProducts, "김":.MarineProducts, "밀가루":.GrainAndNuts,
        "우유":.DrinksAndSnacks,
        "소금":.SeasonedAndOilAndSauce, "참기름":.SeasonedAndOilAndSauce, "마요네즈":.SeasonedAndOilAndSauce,
        "간장":.SeasonedAndOilAndSauce, "후추":.SeasonedAndOilAndSauce, "올리브유":.SeasonedAndOilAndSauce, "식용유":.SeasonedAndOilAndSauce,
        "사과":.Fruits,"수박":.Fruits,"포도":.Fruits,"귤":.Fruits,"복숭아":.Fruits,"배":.Fruits,"바나나":.Fruits,
            "쌀":.GrainAndNuts, "생수":.DrinksAndSnacks, "콩나물":.Vegetable, "딸기":.Fruits, "방울토마토":.Fruits, "토마토":.Fruits
        ]
    default:
        return [
            "Soda":.DrinksAndSnacks, "Milk":.DrinksAndSnacks, "Bread":.DrinksAndSnacks, "Beer":.DrinksAndSnacks,
            "Olive oil":.SeasonedAndOilAndSauce, "Flour":.GrainAndNuts, "Butter":.Milk, "Chicken":.MeatsAndEggs,
            "Sugar":.SeasonedAndOilAndSauce, "Salt":.SeasonedAndOilAndSauce, "Egg":.MeatsAndEggs, "Rice":.GrainAndNuts,
            "Pork":.MeatsAndEggs, "Beef":.MeatsAndEggs, "Cheese":.Milk, "Garlic":.Vegetable,
            "Orange":.Fruits, "Turkey":.MeatsAndEggs, "Onion":.Vegetable, "Corn":.Vegetable,
            "Whole milk":.Milk, "Mayonnaise":.SeasonedAndOilAndSauce, "Chiles":.SeasonedAndOilAndSauce,
            "Almonds":.GrainAndNuts, "Bacon":.MeatsAndEggs, "Mushrooms":.Vegetable, "Coconut":.Fruits,
            "Beets":.Vegetable, "Strawberries":.Fruits, "Fennel":.Vegetable, "Lamb":.MeatsAndEggs,
            "Apple":.Fruits, "Shrimp":.MarineProducts, "Vegetable oil":.SeasonedAndOilAndSauce, "Fish":.MarineProducts
        ]
    }
        
}

let imageNames: [String:String]
    = [ "Milk" : "우유",
        "Olive oil" : "올리브유",
        "Flour" : "밀가루",
        "Chicken": "닭고기",
        "Salt": "소금",
        "Egg" : "계란",
        "Rice" : "쌀",
        "Pork" : "돼지고기",
        "Beef" : "쇠고기",
        "Garlic" : "마늘",
        "Onion" : "양파",
        "Whole milk" : "우유",
        "Mayonnaise" : "마요네즈",
        "Chiles" : "고추",
        "Strawberries" : "딸기",
        "Apple" : "사과",
        "Vegetable oil" : "식용유",
        "Fish" : "생선",
        "Icecream" : "아이스크림"]

func getDefaultItemNames() -> [GroceryHistory]
{
    if(Locale.current.languageCode == "ko")
    {
        return [
            GroceryHistory(title: "쇠고기", category:.MeatsAndEggs, image: GroceryImage(image: UIImage(named: "쇠고기"))),
            GroceryHistory(title: "돼지고기", category:.MeatsAndEggs, image: GroceryImage(image: UIImage(named: "돼지고기"))),
            GroceryHistory(title: "닭고기", category:.MeatsAndEggs, image: GroceryImage(image: UIImage(named: "닭고기"))),
            GroceryHistory(title: "햄", category:.MeatsAndEggs, image: GroceryImage(image: UIImage(named: "햄"))),
            GroceryHistory(title: "계란", category:.MeatsAndEggs, image: GroceryImage(image: UIImage(named: "계란"))),
            GroceryHistory(title: "김치", category:.CookingAndSidedishes, image: GroceryImage(image: UIImage(named: "김치"))),
            GroceryHistory(title: "양파", category:.Vegetable, image: GroceryImage(image: UIImage(named: "양파"))),
            GroceryHistory(title: "대파", category:.Vegetable, image: GroceryImage(image: UIImage(named: "대파"))),
            GroceryHistory(title: "고추", category:.Vegetable, image: GroceryImage(image: UIImage(named: "고추"))),
            GroceryHistory(title: "마늘", category:.Vegetable, image: GroceryImage(image: UIImage(named: "마늘"))),
            GroceryHistory(title: "무", category:.Vegetable, image: GroceryImage(image: UIImage(named: "무"))),
            GroceryHistory(title: "당근", category:.Vegetable, image: GroceryImage(image: UIImage(named: "당근"))),
            GroceryHistory(title: "애호박", category:.Vegetable, image: GroceryImage(image: UIImage(named: "애호박"))),
            GroceryHistory(title: "가지", category:.Vegetable, image: GroceryImage(image: UIImage(named: "가지"))),
            GroceryHistory(title: "브로콜리", category:.Vegetable, image: GroceryImage(image: UIImage(named: "브로콜리"))),
            GroceryHistory(title: "상추", category:.Vegetable, image: GroceryImage(image: UIImage(named: "상추"))),
            GroceryHistory(title: "양배추", category:.Vegetable, image: GroceryImage(image: UIImage(named: "양배추"))),
            GroceryHistory(title: "파프리카", category:.Vegetable, image: GroceryImage(image: UIImage(named: "파프리카"))),
            GroceryHistory(title: "시금치", category:.Vegetable, image: GroceryImage(image: UIImage(named: "시금치"))),
            GroceryHistory(title: "감자", category:.Vegetable, image: GroceryImage(image: UIImage(named: "감자"))),
            GroceryHistory(title: "고구마", category:.Vegetable, image: GroceryImage(image: UIImage(named: "고구마"))),
            GroceryHistory(title: "두부", category:.CookingAndSidedishes, image: GroceryImage(image: UIImage(named: "두부"))),
            GroceryHistory(title: "라면소면", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "라면소면"))),
            GroceryHistory(title: "생선", category:.MarineProducts, image: GroceryImage(image: UIImage(named: "생선"))),
            GroceryHistory(title: "참치", category:.MarineProducts, image: GroceryImage(image: UIImage(named: "참치"))),
            GroceryHistory(title: "김", category:.MarineProducts, image: GroceryImage(image: UIImage(named: "김"))),
            GroceryHistory(title: "밀가루", category:.GrainAndNuts, image: GroceryImage(image: UIImage(named: "밀가루"))),
            GroceryHistory(title: "우유", category:.Milk, image: GroceryImage(image: UIImage(named: "우유"))),
            GroceryHistory(title: "소금", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "소금"))),
            GroceryHistory(title: "참기름", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "참기름"))),
            GroceryHistory(title: "마요네즈", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "마요네즈"))),
            GroceryHistory(title: "간장", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "간장"))),
            GroceryHistory(title: "후추", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "후추"))),
            GroceryHistory(title: "올리브유", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "올리브유"))),
            GroceryHistory(title: "식용유", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "식용유"))),
            GroceryHistory(title: "사과", category:.Fruits, image: GroceryImage(image: UIImage(named: "사과"))),
            GroceryHistory(title: "수박", category:.Fruits, image: GroceryImage(image: UIImage(named: "수박"))),
            GroceryHistory(title: "포도", category:.Fruits, image: GroceryImage(image: UIImage(named: "포도"))),
            GroceryHistory(title: "귤", category:.Fruits, image: GroceryImage(image: UIImage(named: "귤"))),
            GroceryHistory(title: "복숭아", category:.Fruits, image: GroceryImage(image: UIImage(named: "복숭아"))),
            GroceryHistory(title: "배", category:.Fruits, image: GroceryImage(image: UIImage(named: "배"))),
            GroceryHistory(title: "바나나", category:.Fruits, image: GroceryImage(image: UIImage(named: "바나나"))),
            GroceryHistory(title: "쌀", category:.GrainAndNuts, image: GroceryImage(image: UIImage(named: "쌀"))),
            GroceryHistory(title: "생수", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "생수"))),
            GroceryHistory(title: "콩나물", category:.Vegetable, image: GroceryImage(image: UIImage(named: "콩나물"))),
            GroceryHistory(title: "딸기", category:.Fruits, image: GroceryImage(image: UIImage(named: "딸기"))),
            GroceryHistory(title: "방울토마토", category:.Vegetable, image: GroceryImage(image: UIImage(named: "방울토마토"))),
            GroceryHistory(title: "토마토", category:.Vegetable, image: GroceryImage(image: UIImage(named: "토마토"))),
            GroceryHistory(title: "빵", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "빵"))),
            GroceryHistory(title: "시리얼", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "시리얼"))),
            GroceryHistory(title: "치즈", category:.Milk, image: GroceryImage(image: UIImage(named: "치즈"))),
            GroceryHistory(title: "설탕", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "설탕"))),
            GroceryHistory(title: "식초", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "식초"))),
            GroceryHistory(title: "초코릿", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "초코릿"))),
            GroceryHistory(title: "스낵", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "스낵"))),
            GroceryHistory(title: "사탕", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "사탕"))),
            GroceryHistory(title: "두유", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "두유"))),
            GroceryHistory(title: "요거트", category:.Milk, image: GroceryImage(image: UIImage(named: "요거트"))),
            GroceryHistory(title: "콜라", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "콜라"))),
            GroceryHistory(title: "사이다", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "사이다"))),
            GroceryHistory(title: "오렌지주스", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "오렌지주스"))),
            GroceryHistory(title: "케찹", category:.SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "케찹"))),
            GroceryHistory(title: "아이스크림", category:.DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "아이스크림")))
        ]
    }
    else
    {
        return [
            GroceryHistory(title: "Soda", category: .DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "Soda"))),
            GroceryHistory(title: "Milk", category: .DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "우유"))),
            GroceryHistory(title: "Bread", category: .DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "Bread"))),
            GroceryHistory(title: "Beer", category: .DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "Beer"))),
            GroceryHistory(title: "Olive oil", category: .SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "올리브유"))),
            GroceryHistory(title: "Flour", category: .GrainAndNuts, image: GroceryImage(image: UIImage(named: "밀가루"))),
            GroceryHistory(title: "Butter", category: .Milk, image: GroceryImage(image: UIImage(named: "Butter"))),
            GroceryHistory(title: "Chicken", category: .MeatsAndEggs, image: GroceryImage(image: UIImage(named: "닭고기"))),
            GroceryHistory(title: "Sugar", category: .SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "Sugar"))),
            GroceryHistory(title: "Salt", category: .SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "소금"))),
            GroceryHistory(title: "Egg", category: .MeatsAndEggs, image: GroceryImage(image: UIImage(named: "계란"))),
            GroceryHistory(title: "Rice", category: .GrainAndNuts, image: GroceryImage(image: UIImage(named: "쌀"))),
            GroceryHistory(title: "Pork", category: .MeatsAndEggs, image: GroceryImage(image: UIImage(named: "돼지고기"))),
            GroceryHistory(title: "Beef", category: .MeatsAndEggs, image: GroceryImage(image: UIImage(named: "쇠고기"))),
            GroceryHistory(title: "Cheese", category: .Milk, image: GroceryImage(image: UIImage(named: "Cheese"))),
            GroceryHistory(title: "Garlic", category: .Vegetable, image: GroceryImage(image: UIImage(named: "마늘"))),
            GroceryHistory(title: "Orange", category: .Fruits, image: GroceryImage(image: UIImage(named: "Orange"))),
            GroceryHistory(title: "Turkey", category: .MeatsAndEggs, image: GroceryImage(image: UIImage(named: "Turkey"))),
            GroceryHistory(title: "Onion", category: .Vegetable, image: GroceryImage(image: UIImage(named: "양파"))),
            GroceryHistory(title: "Corn", category: .Vegetable, image: GroceryImage(image: UIImage(named: "Corn"))),
            GroceryHistory(title: "Whole milk", category: .Milk, image: GroceryImage(image: UIImage(named: "우유"))),
            GroceryHistory(title: "Mayonnaise", category: .SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "마요네즈"))),
            GroceryHistory(title: "Chiles", category: .SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "고추"))),
            GroceryHistory(title: "Almonds", category: .GrainAndNuts, image: GroceryImage(image: UIImage(named: "Almonds"))),
            GroceryHistory(title: "Bacon", category: .MeatsAndEggs, image: GroceryImage(image: UIImage(named: "Bacon"))),
            GroceryHistory(title: "Mushrooms", category: .Vegetable, image: GroceryImage(image: UIImage(named: "Mushrooms"))),
            GroceryHistory(title: "Coconut", category: .Fruits, image: GroceryImage(image: UIImage(named: "Coconut"))),
            GroceryHistory(title: "Beets", category: .Vegetable, image: GroceryImage(image: UIImage(named: "Beets"))),
            GroceryHistory(title: "Strawberries", category: .Fruits, image: GroceryImage(image: UIImage(named: "딸기"))),
            GroceryHistory(title: "Fennel", category: .Vegetable, image: GroceryImage(image: UIImage(named: "Fennel"))),
            GroceryHistory(title: "Lamb", category: .MeatsAndEggs, image: GroceryImage(image: UIImage(named: "Lamb"))),
            GroceryHistory(title: "Apple", category: .Fruits, image: GroceryImage(image: UIImage(named: "사과"))),
            GroceryHistory(title: "Shrimp", category: .MarineProducts, image: GroceryImage(image: UIImage(named: "Shrimp"))),
            GroceryHistory(title: "Vegetable oil", category: .SeasonedAndOilAndSauce, image: GroceryImage(image: UIImage(named: "식용유"))),
            GroceryHistory(title: "Fish", category: .MarineProducts, image: GroceryImage(image: UIImage(named: "생선"))),
            GroceryHistory(title: "Icecream", category: .DrinksAndSnacks, image: GroceryImage(image: UIImage(named: "아이스크림")))
        ]
    }
    /*
    let langStr = Locale.current.languageCode
    switch(langStr)
    {
    case "en": // reference : https://www.loveandlemons.com/what-is-fennel/
        return [
            GroceryHistory(title: "Soda", category: .DrinksAndSnacks),
            GroceryHistory(title: "Milk", category: .DrinksAndSnacks),
            GroceryHistory(title: "Bread", category: .DrinksAndSnacks),
            GroceryHistory(title: "Beer", category: .DrinksAndSnacks),
            GroceryHistory(title: "Olive oil", category: .SeasonedAndOilAndSauce),
            GroceryHistory(title: "Flour", category: .GrainAndNuts),
            GroceryHistory(title: "Butter", category: .Milk),
            GroceryHistory(title: "Chicken", category: .MeatsAndEggs),
            GroceryHistory(title: "Sugar", category: .SeasonedAndOilAndSauce),
            GroceryHistory(title: "Salt", category: .SeasonedAndOilAndSauce),
            GroceryHistory(title: "Egg", category: .MeatsAndEggs),
            GroceryHistory(title: "Rice", category: .GrainAndNuts),
            GroceryHistory(title: "Pork", category: .MeatsAndEggs),
            GroceryHistory(title: "Beef", category: .MeatsAndEggs),
            GroceryHistory(title: "Cheese", category: .Milk),
            GroceryHistory(title: "Garlic", category: .Vegetable),
            GroceryHistory(title: "Orange", category: .Fruits),
            GroceryHistory(title: "Turkey", category: .MeatsAndEggs),
            GroceryHistory(title: "Onion", category: .Vegetable),
            GroceryHistory(title: "Corn", category: .Vegetable),
            GroceryHistory(title: "Whole milk", category: .Milk),
            GroceryHistory(title: "Mayonnaise", category: .SeasonedAndOilAndSauce),
            GroceryHistory(title: "Chiles", category: .SeasonedAndOilAndSauce),
            GroceryHistory(title: "Almonds", category: .GrainAndNuts),
            GroceryHistory(title: "Bacon", category: .MeatsAndEggs),
            GroceryHistory(title: "Mushrooms", category: .Vegetable),
            GroceryHistory(title: "Coconut", category: .Vegetable),
            GroceryHistory(title: "Beets", category: .Vegetable),
            GroceryHistory(title: "Strawberries", category: .Fruits),
            GroceryHistory(title: "Fennel", category: .Vegetable),
            GroceryHistory(title: "Lamb", category: .MeatsAndEggs),
            GroceryHistory(title: "Apple", category: .Fruits),
            GroceryHistory(title: "Shrimp", category: .MarineProducts),
            GroceryHistory(title: "Vegetable oil", category: .SeasonedAndOilAndSauce),
            GroceryHistory(title: "Fish", category: .MarineProducts)
        ]
    case "ko":
        return [
        "쇠고기":.MeatsAndEggs, "돼지고기":.MeatsAndEggs, "닭고기":.MeatsAndEggs, "햄":.MeatsAndEggs, "계란":.MeatsAndEggs,
        "김치":.CookingAndSidedishes,
        "양파":.Vegetable, "대파":.Vegetable, "고추":.Vegetable,
        "마늘":.Vegetable, "무":.Vegetable, "당근":.Vegetable, "애호박":.Vegetable,
        "가지":.Vegetable, "브로콜리":.Vegetable, "상추":.Vegetable, "양배추":.Vegetable,
        "파프리카":.Vegetable, "시금치":.Vegetable, "감자":.Vegetable, "고구마":.Vegetable,
        "두부":.ETC, "라면소면":.ETC,
        "생선":.MarineProducts, "참치":.MarineProducts, "김":.MarineProducts, "밀가루":.GrainAndNuts,
        "우유":.DrinksAndSnacks,
        "소금":.SeasonedAndOilAndSauce, "참기름":.SeasonedAndOilAndSauce, "마요네즈":.SeasonedAndOilAndSauce,
        "간장":.SeasonedAndOilAndSauce, "후추":.SeasonedAndOilAndSauce, "올리브유":.SeasonedAndOilAndSauce, "식용유":.SeasonedAndOilAndSauce,
        "사과":.Fruits,"수박":.Fruits,"포도":.Fruits,"귤":.Fruits,"복숭아":.Fruits,"배":.Fruits,"바나나":.Fruits
        ]
    default:
        return [
            "Soda":.DrinksAndSnacks, "Milk":.DrinksAndSnacks, "Bread":.DrinksAndSnacks, "Beer":.DrinksAndSnacks,
            "Olive oil":.SeasonedAndOilAndSauce, "Flour":.GrainAndNuts, "Butter":.Milk, "Chicken":.MeatsAndEggs,
            "Sugar":.SeasonedAndOilAndSauce, "Salt":.SeasonedAndOilAndSauce, "Egg":.MeatsAndEggs, "Rice":.GrainAndNuts,
            "Pork":.MeatsAndEggs, "Beef":.MeatsAndEggs, "Cheese":.Milk, "Garlic":.Vegetable,
            "Orange":.Fruits, "Turkey":.MeatsAndEggs, "Onion":.Vegetable, "Corn":.Vegetable,
            "Whole milk":.Milk, "Mayonnaise":.SeasonedAndOilAndSauce, "Chiles":.SeasonedAndOilAndSauce,
            "Almonds":.GrainAndNuts, "Bacon":.MeatsAndEggs, "Mushrooms":.Vegetable, "Coconut":.Vegetable,
            "Beets":.Vegetable, "Strawberries":.Fruits, "Fennel":.Vegetable, "Lamb":.MeatsAndEggs,
            "Apple":.Fruits, "Shrimp":.MarineProducts, "Vegetable oil":.SeasonedAndOilAndSauce, "Fish":.MarineProducts
        ]
    }
        */
}



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
            return "분류별".localized()
        }
    }
}

class BarcodeData
{
    let barcodeGTIN: String
    let barcodeGLN: String
    let name: String
    let imageLink1: String
    let imageLink2: String
    let imageLink3: String
    let imageLink4: String
    
    init(_ barcode1: String, _ barcode2: String, _ name: String, _ image1: String, _ image2: String, _ image3: String, _ image4: String)
    {
        barcodeGTIN = barcode1
        barcodeGLN = barcode2
        self.name = name
        imageLink1 = image1
        imageLink2 = image2
        imageLink3 = image3
        imageLink4 = image4
    }
}



var barcodeData = [BarcodeData]()

// 저장을 쉽게 하기위해 전역 변수로 옮김
var isFridgeAlarmButtonOn = true
var isFridgeCategoryButtonOn = false
var isFridgeNameSortButtonOn = false
var isFridgeSortByDueDateButtonOn = false

var isFridgeStorageAllOn = true
var isFridgeFrigerationButtonOn = true
var isFridgeFreezingButtonOn = true
var isFridgeOutdoorButtonOn = true


//처음에는 아래 기본값이지만 사용자가 바꿀수 있고 바뀐 그 값은 저장됨
var isPurchaseRecordCategorySortButtonOn = false
var isPurchaseRecordFavoriteSortButtonOn = true
var isPurchaseRecordRecentSortButtonOn = false

var isShopingCartCategoryButtonOn = true
var isShopingCartLatestButtonOn = false
