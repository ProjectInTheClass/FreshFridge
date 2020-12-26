//
//  Grocery.swift
//  TableViewTest
//
//  Created by changae choi on 2020/12/26.
//

import Foundation

enum Category {
    case ETC
    case MeatsAndEggs
    case MarineProducts
    case CookingAndSidedishes
    case Vegetable
    case Fruits
    case DrinksAndSnacks
    case SeasonedAndOilAndSauce
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
