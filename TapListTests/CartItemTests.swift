//
//  CartItemTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/22/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class CartItemTests: XCTestCase {
    
    func testAsDictionary1() {
        let sku = "00012345678900"
        let quantity = 4
        let specialInstructions = "Do the Hokey Pokey."
        
        let cartItem = CartItem(sku: sku, quantity: quantity, specialInstructions: specialInstructions)
        
        var expected: Dictionary<String, Any> = [CartItem.DataKey.quantity.rawValue: quantity,
                        CartItem.DataKey.specialInstructions.rawValue: specialInstructions]

        assertEqual(expected, cartItem.asDictionary)
        
        expected = [CartItem.DataKey.quantity.rawValue: quantity]
        assertNotEqual(expected, cartItem.asDictionary)
    }
    
    func testAsDictionary2() {
        let sku = "00012345678900"
        let quantity = 4
        
        let cartItem = CartItem(sku: sku, quantity: quantity)
        
        let expected: Dictionary<String, Any> = [CartItem.DataKey.quantity.rawValue: quantity]
        
        assertEqual(expected, cartItem.asDictionary)
    }
    
    func testConvenienceInit1() {
        let sku = "00012345678900"
        let quantity = 4
        let specialInstructions = "Do the Hokey Pokey."
        
        let data: Dictionary<String, Any> = [CartItem.DataKey.quantity.rawValue: quantity,
                                             CartItem.DataKey.specialInstructions.rawValue: specialInstructions]
        
        let cartItem = CartItem(sku: sku, data: data)
        let expected = CartItem(sku: sku, quantity: quantity, specialInstructions: specialInstructions)
        
        XCTAssertNotNil(cartItem)
        XCTAssertEqual(expected, cartItem)
    }
    
    func testConvenienceInit2() {
        let sku = "00012345678900"
        let specialInstructions = "Do the Hokey Pokey."
        
        let data: Dictionary<String, Any> = [CartItem.DataKey.specialInstructions.rawValue: specialInstructions]
        
        let cartItem = CartItem(sku: sku, data: data)
        
        XCTAssertNil(cartItem)
    }
    
    func testConvenienceInit3() {
        let sku = "00012345678900"
        let quantity = 4
        
        let data: Dictionary<String, Any> = [CartItem.DataKey.quantity.rawValue: quantity]
        
        let cartItem = CartItem(sku: sku, data: data)
        let expected = CartItem(sku: sku, quantity: quantity)
        
        XCTAssertNotNil(cartItem)
        XCTAssertEqual(expected, cartItem)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    
}

