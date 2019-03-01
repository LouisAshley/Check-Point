//
//  Category.swift
//  Check Point
//
//  Created by Lewis on 01/03/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
   @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
