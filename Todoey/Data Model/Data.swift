//
//  Data.swift
//  Todoey
//
//  Created by Cody on 10/29/18.
//  Copyright © 2018 Codyo. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
