//
//  Item.swift
//  Todoey
//
//  Created by Cody on 10/22/18.
//  Copyright © 2018 Codyo. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title:String = ""
    var done:Bool = false
}
