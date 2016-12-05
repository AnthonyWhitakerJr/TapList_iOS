//
//  CartItem.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/5/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class CartItem {
    
    var sku: String
    var quantity: Int
    var specialInstructions: String?
    
    init(sku: String, quantity: Int, specialInstructions: String? = nil) {
        self.sku = sku
        self.quantity = quantity
        self.specialInstructions = specialInstructions
    }
}
