//
//  Item.swift
//  
//
//  Created by Рома Сорока on 21.01.2018.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Double = 0.0
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
