//
//  Cart.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/10/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Cart {
    
    var cartItems: Dictionary<String, CartItem>
    
    var quantityTotal: Int {
        var total: Int = 0
        for (_, cartItem) in cartItems {
            total += cartItem.quantity
        }
        return total
    }
    
    init(cartItems: Dictionary<String, CartItem> = Dictionary<String, CartItem>()) {
        self.cartItems = cartItems
    }
    
    convenience init(data: Dictionary<String, Any>) {
        let cartItemData = data["cartItems"] as? Dictionary<String, Dictionary<String, Any>>
        
        var cartItemDict = Dictionary<String, CartItem>()
        for item in cartItemData! {
            let cartItem = CartItem(sku: item.key, data: item.value)
            if let cartItem = cartItem {
                cartItemDict[cartItem.sku] = cartItem
            }
        }
        
        self.init(cartItems: cartItemDict)

    }
    
    func subtotal(completion: @escaping (Double) -> ()) {
        var subtotal: Double = 0
        let subtotalDispatch = DispatchGroup()
        
        for (_, cartItem) in cartItems {
            subtotalDispatch.enter()
            cartItem.itemTotal(completion: { itemTotal in
                subtotal += itemTotal
                subtotalDispatch.leave()
            })
        }
        
        subtotalDispatch.notify(queue: DispatchQueue.main, execute: {
            completion(subtotal)
        })
    }
    

}

extension Cart: CustomStringConvertible {
    var description: String {
        return "subtotal: \(subtotal), quantityTotal: \(quantityTotal), cartItems: \(cartItems)"
    }
}
