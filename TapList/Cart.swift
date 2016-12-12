//
//  Cart.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/10/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Cart {
    
    var cartItems: Array<CartItem>
    var quantityTotal: Int
    var subtotal: Double
    
    init(cartItems: Array<CartItem> = Array<CartItem>(), quantityTotal: Int = 0, subtotal: Double = 0) {
        self.cartItems = cartItems
        self.quantityTotal = quantityTotal
        self.subtotal = subtotal
    }
    
    convenience init(data: Dictionary<String, Any>) {
        let quantityTotal = data["quantityTotal"] as? Int
        let subtotal = data["subtotal"] as? Double
        let cartItemDict = data["cartItems"] as? Dictionary<String, Dictionary<String, Any>>
        
        var cartItemArray = Array<CartItem>()
        for item in cartItemDict! {
            let cartItem = CartItem(sku: item.key, data: item.value)
            if let cartItem = cartItem {
                cartItemArray.append(cartItem)
            }
        }
        if let quantityTotal = quantityTotal, let subtotal = subtotal {
            self.init(cartItems: cartItemArray, quantityTotal: quantityTotal, subtotal: subtotal)
        } else {
            self.init()
        }
        
    }
}

extension Cart: CustomStringConvertible {
    var description: String {
        return "subtotal: \(subtotal), quantityTotal: \(quantityTotal), cartItems: \(cartItems)"
    }
}
