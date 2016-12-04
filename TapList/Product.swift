//
//  Product.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Product {
    // 14 digit product upc. Stored as String to preserve preceeding zeros.
    var upc: String?
    var name: String?
    var regularPrice: Double?
    
    convenience init(upc: String, name: String) {
        self.init()
        self.upc = upc
        self.name = name
    }
}
