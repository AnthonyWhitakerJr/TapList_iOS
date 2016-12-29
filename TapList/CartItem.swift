//
//  CartItem.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/5/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class CartItem {
    
    /// Product SKU.
    var sku: String
    
    /// Quantity of product in cart.
    var quantity: Int
    
    /// Order customization options.
    var specialInstructions: String?
    
    var dataService = DataService.instance
    
    /// Dictionary representation of this `CartItem`.
    var asDictionary: Dictionary<String, Any> {
        var result: Dictionary<String, Any> = [
            DataKey.quantity.rawValue: quantity
        ]
        
        if let specialInstructions = specialInstructions {
            result[DataKey.specialInstructions.rawValue] = specialInstructions
        }
        
        return result
    }
    
    /// Keys used for dictionary representation of `CartItem`.
    enum DataKey: String {
        case quantity
        case specialInstructions
    }
    
    /// Denotes type of unit price. Useful when configuring UI.
    enum UnitPriceType {
        case offerPrice
        case listPrice
    }
    
    init(sku: String, quantity: Int, specialInstructions: String? = nil) {
        self.sku = sku
        self.quantity = quantity
        self.specialInstructions = specialInstructions
    }
    
    /// Creates a `CartItem` from a dictionary.
    /// - returns: A `CartItem` with given sku, based on given dictionary.
    /// Returns `nil` if given dictionary does not provide all required parameters.
    convenience init?(sku: String, data: Dictionary<String, Any>) {
        let quantity = data[DataKey.quantity.rawValue] as? Int
        let specialInstructions = data[DataKey.specialInstructions.rawValue] as? String

        if let quantity = quantity {
           self.init(sku: sku, quantity: quantity, specialInstructions: specialInstructions)
        } else {
            return nil
        }
    }
    
    /// Fetches most up-to-date price for this item.
    func unitPrice(completion: @escaping (Double, UnitPriceType) -> ()) {
        self.dataService.product(for: sku, completion: { product in
            if let product = product {
                if let offerPrice = product.offerPrice {
                    completion(offerPrice, UnitPriceType.offerPrice)
                } else if let listPrice = product.listPrice {
                    completion(listPrice, UnitPriceType.listPrice)
                }
            }
        })
    }
    
    /// Total price for quantity of this item in the cart.
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

extension CartItem: Equatable {
    static func ==(lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.sku == rhs.sku &&
            lhs.quantity == rhs.quantity &&
            lhs.specialInstructions == rhs.specialInstructions
    }
}
