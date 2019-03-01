//
//  Item.swift
//  Check Point
//
//  Created by Lewis on 01/03/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
