//
//  Catagory.swift
//  
//
//  Created by Cody on 10/29/18.
//

import Foundation
import RealmSwift

class Catagory:Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
