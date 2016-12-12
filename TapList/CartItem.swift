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
    
    enum DataKey: String {
        case quantity
        case specialInstructions
    }
    
    init(sku: String, quantity: Int, specialInstructions: String? = nil) {
        self.sku = sku
        self.quantity = quantity
        self.specialInstructions = specialInstructions
    }
    
    convenience init?(sku: String, data: Dictionary<String, Any>) {
        let quantity = data[DataKey.quantity.rawValue] as? Int
        let specialInstructions = data[DataKey.specialInstructions.rawValue] as? String

        if let quantity = quantity {
           self.init(sku: sku, quantity: quantity, specialInstructions: specialInstructions)
        } else {
            return nil
        }
    }

}

extension CartItem: CustomStringConvertible {
    var description: String {
        return "sku: \(sku), quantity: \(quantity), specialInstructions: \(specialInstructions)"
    }
}
