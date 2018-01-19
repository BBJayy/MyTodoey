//
//  File.swift
//  MyTodoey
//
//  Created by Рома Сорока on 17.01.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

class CellInfo {
    var name : String = ""
    var isCheked : Bool = false
    
    init() {}
    init(text: String, cheked: Bool) {
        name = text
        isCheked = cheked
    }
}
