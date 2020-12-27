//
//  Grocery.swift
//  TableViewTest
//
//  Created by changae choi on 2020/12/26.
//

import Foundation

enum Category: String, CaseIterable {
    case ETC = "ETC"
    case MeatsAndEggs = "MeatsAndEggs"
    case MarineProducts = "MarineProducts"
    case CookingAndSidedishes = "CookingAndSidedishes"
    case Vegetable = "Vegetable"
    case Fruits = "Fruits"
    case DrinksAndSnacks = "DrinksAndSnacks"
    case SeasonedAndOilAndSauce = "SeasonedAndOilAndSauce"
}

enum Storage
{
    case Refrigeration
    case Freezing
    case Outdoor
}

struct Grocery {
    var title: String
    var category: Category
    var count: Int
    var dueDate: Date
    var saveDate: Date
    var notes: String
    var storage: Storage
}

let secondOfDay: Double = 60*60*24.0

enum FridgeFilter: String
{
    case CategoryFilter = "분류별"
    case RefrigerationFilter = "냉장"
    case FreezingFilter = "냉동"
    case OutdoorFilter = "실외"
}
