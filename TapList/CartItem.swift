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
    
    var asDictionary: Dictionary<String, Any> {
        var result: Dictionary<String, Any> = [
            DataKey.quantity.rawValue: quantity
        ]
        
        if let specialInstructions = specialInstructions {
            result[DataKey.specialInstructions.rawValue] = specialInstructions
        }
        
        return result
    }
    
    enum DataKey: String {
        case quantity
        case specialInstructions
    }
    
    enum UnitPriceType {
        case offerPrice
        case listPrice
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
    
    // Fetches most up-to-date price for this item.
    func unitPrice(completion: @escaping (Double, UnitPriceType) -> ()) {
        DataService.instance.product(for: sku, completion: { product in
            if let product = product {
                if let offerPrice = product.offerPrice {
                    completion(offerPrice, UnitPriceType.offerPrice)
                } else if let listPrice = product.listPrice {
                    completion(listPrice, UnitPriceType.listPrice)
                }
            }
        })
    }
    
    func itemTotal(completion: @escaping (Double) -> ()) {
        unitPrice { unitPrice, _ in
            let result = unitPrice * Double(self.quantity)
            completion(result)
        }
    }
    
    

}

extension CartItem: CustomStringConvertible {
    var description: String {
        return "sku: \(sku), quantity: \(quantity), specialInstructions: \(specialInstructions)"
    }
}
