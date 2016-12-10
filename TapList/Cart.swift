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
}
