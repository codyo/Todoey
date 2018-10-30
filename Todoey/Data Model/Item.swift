//
//  Item.swift
//  
//
//  Created by Cody on 10/29/18.
//

import Foundation
import RealmSwift

class Item:Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCatagory = LinkingObjects(fromType: Catagory.self, property: "items")
}
