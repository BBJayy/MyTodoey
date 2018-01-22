//
//  Category.swift
//  MyTodoey
//
//  Created by Рома Сорока on 21.01.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
