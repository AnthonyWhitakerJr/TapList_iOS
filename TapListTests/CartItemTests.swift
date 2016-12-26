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
    
    func testAsDictionary() {
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
    
    func testAsDictionary_noSpecialInstructions() {
        let sku = "00012345678900"
        let quantity = 4
        
        let cartItem = CartItem(sku: sku, quantity: quantity)
        
        let expected: Dictionary<String, Any> = [CartItem.DataKey.quantity.rawValue: quantity]
        
        assertEqual(expected, cartItem.asDictionary)
    }
    
    func testConvenienceInit() {
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
    
    func testConvenienceInit_noQuantity() {
        let sku = "00012345678900"
        let specialInstructions = "Do the Hokey Pokey."
        
        let data: Dictionary<String, Any> = [CartItem.DataKey.specialInstructions.rawValue: specialInstructions]
        
        let cartItem = CartItem(sku: sku, data: data)
        
        XCTAssertNil(cartItem)
    }
    
    func testConvenienceInit_noSpecialInstructions() {
        let sku = "00012345678900"
        let quantity = 4
        
        let data: Dictionary<String, Any> = [CartItem.DataKey.quantity.rawValue: quantity]
        
        let cartItem = CartItem(sku: sku, data: data)
        let expected = CartItem(sku: sku, quantity: quantity)
        
        XCTAssertNotNil(cartItem)
        XCTAssertEqual(expected, cartItem)
    }
    
    func testUnitPrice_listPrice() {
        let dataService = MockDataService()
        let cartItem = CartItem(sku: "0001234567890", quantity: 6)
        cartItem.dataService = dataService
        
        let contract = expectation(description: "Unit Price")
        cartItem.unitPrice { (price, priceType) in
            XCTAssertEqual(4.99, price)
            XCTAssertEqual(CartItem.UnitPriceType.listPrice, priceType)
            contract.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("Unit price took too long! \(error)")
            }
        }
    }
    
    func testUnitPrice_offerPrice() {
        let dataService = MockDataService()
        let cartItem = CartItem(sku: "0009876543210", quantity: 4)
        cartItem.dataService = dataService
        
        let contract = expectation(description: "Unit Price")
        cartItem.unitPrice { (price, priceType) in
            XCTAssertEqual(1.99, price)
            XCTAssertEqual(CartItem.UnitPriceType.offerPrice, priceType)
            contract.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("Unit price took too long! \(error)")
            }
        }
    }
    
    func testItemTotal() {
        let dataService = MockDataService()
        let cartItem = CartItem(sku: "0001234567890", quantity: 6)
        cartItem.dataService = dataService
        
        let contract = expectation(description: "Unit Price")
        cartItem.itemTotal { total in
            XCTAssertEqual(29.94, total)
            contract.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("Item total took too long! \(error)")
            }
        }
    }
    
}

