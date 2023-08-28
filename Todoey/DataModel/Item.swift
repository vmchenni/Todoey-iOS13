//
//  Item.swift
//  Todoey
//
//  Created by Vishwanath Chenni on 28/8/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
class Item: Encodable,Decodable{
    var title: String = ""
    var done : Bool = false
}
