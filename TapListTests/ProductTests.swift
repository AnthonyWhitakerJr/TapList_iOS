//
//  ProductTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/24/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class ProductTests: XCTestCase {
    
    func testConvenienceInit1() {
        let sku = "0001234567890"
        let name = "Some product"
        let listPrice = 4.99
        let detail = "12 0z"
        
        let data: Dictionary<String, Any> = [Product.DataKey.name.rawValue: name,
                                             Product.DataKey.listPrice.rawValue: listPrice,
                                             Product.DataKey.detail.rawValue: detail]
        
        let product = Product(sku: sku, data: data)
        
        XCTAssertNotNil(product)
        XCTAssertEqual(sku, product!.sku)
        XCTAssertEqual(name, product!.name)
        XCTAssertEqual(listPrice, product!.listPrice)
        XCTAssertEqual(detail, product!.detail)
    }
    
    func testConvenienceInit2() {
        let sku = "0001234567890"
        let name = "Some product"
        let detail = "12 0z"
        
        let data: Dictionary<String, Any> = [Product.DataKey.name.rawValue: name,
                                             Product.DataKey.detail.rawValue: detail]
        
        let product = Product(sku: sku, data: data)
        
        XCTAssertNil(product)
    }
    
    func testConvenienceInit3() {
        let sku = "0001234567890"
        let name = "Some product"
        let listPrice = 4.99
        let offerPrice = 2.50
        let detail = "12 0z"
        let orderBy = Product.OrderBy.unit
        let soldBy = Product.SoldBy.weight
        
        let data: Dictionary<String, Any> = [Product.DataKey.name.rawValue: name,
                                             Product.DataKey.listPrice.rawValue: listPrice,
                                             Product.DataKey.offerPrice.rawValue: offerPrice,
                                             Product.DataKey.detail.rawValue: detail,
                                             Product.DataKey.soldBy.rawValue: soldBy.rawValue,
                                             Product.DataKey.orderBy.rawValue: orderBy.rawValue]
        
        let product = Product(sku: sku, data: data)
        
        XCTAssertNotNil(product)
        XCTAssertEqual(sku, product!.sku)
        XCTAssertEqual(name, product!.name)
        XCTAssertEqual(listPrice, product!.listPrice)
        XCTAssertEqual(offerPrice, product!.offerPrice)
        XCTAssertEqual(detail, product!.detail)
        XCTAssertEqual(orderBy, product!.orderBy)
        XCTAssertEqual(soldBy, product!.soldBy)
    }
}
