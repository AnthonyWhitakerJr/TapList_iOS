//
//  CartTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/24/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class CartTests: XCTestCase {
    
    var expectedCartItems = Dictionary<String, CartItem>()

    override func setUp() {
        super.setUp()
        let cartItem1 = CartItem(sku: "0001234567890", quantity: 2)
        let cartItem2 = CartItem(sku: "0009876543210", quantity: 3)
        let cartItem3 = CartItem(sku: "0001234543210", quantity: 4)
        
        expectedCartItems = [cartItem1.sku: cartItem1,
                             cartItem2.sku: cartItem2,
                             cartItem3.sku: cartItem3]
    }
    
    func testConvenienceInit() {
        var dict = Dictionary<String, Dictionary<String, Any>>()
        for (sku, item) in expectedCartItems {
            dict[sku] = item.asDictionary
        }
        
        let data = ["cartItems": dict]
        let cart = Cart(data: data)
        XCTAssertEqual(expectedCartItems, cart.cartItems)
    }
    
    func testConvenienceInit_malformedData1() {
        let cart = Cart(data: expectedCartItems)
        XCTAssertTrue(cart.cartItems.isEmpty)
    }
    
    func testConvenienceInit_malformedData2() {
        var data = Dictionary<String, Dictionary<String, Any>>()
        for (sku, item) in expectedCartItems {
            data[sku] = item.asDictionary
        }
        
        let cart = Cart(data: data)
        XCTAssertTrue(cart.cartItems.isEmpty)
    }
    
    func testQuantityTotal() {
        let cart = Cart(cartItems: expectedCartItems)
        XCTAssertEqual(9, cart.quantityTotal)
    }
    
    func testSubtotal() {
        let mockDataService = MockDataService()
        for (_, item) in expectedCartItems {
            item.dataService = mockDataService
        }
        let cart = Cart(cartItems: expectedCartItems)
        
        let contract = expectation(description: "Subtotal")
        cart.subtotal { subtotal in
            XCTAssertEqual(49.91, subtotal)
            contract.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("Subtotal took too long! \(error)")
            }
        }
    }
    
    func testDescription() {
        let cart = Cart(cartItems: expectedCartItems)
        XCTAssertNotNil(cart.description)
    }
    
}
