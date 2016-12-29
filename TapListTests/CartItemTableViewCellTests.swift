//
//  CartItemTableViewCellTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class CartItemTableViewCellTests: XCTestCase {
    
    func testConfigureCell_RegularPrice() {
        let cell = CartItemTableViewCell()
        let cartItem = CartItem(sku: "0001234567890", quantity: 2)
        
        let productImageView = UIImageView()
        let productNameLabel = UILabel()
        let priceLabel = UILabel()
        let detailLabel = UILabel()
        let quantityEntryView = QuantityEntryView()
        let offerPriceButton = UIButton()
        
        cell.productImageView = productImageView
        cell.productNameLabel = productNameLabel
        cell.priceLabel = priceLabel
        cell.detailLabel = detailLabel
        cell.quantityEntryView = quantityEntryView
        cell.offerPriceButton = offerPriceButton
        
        cell.dataService = MockDataService()
        cell.imageService = MockImageService()
        
        let contract = expectation(description: "configureCell")
        
        cell.configureCell(cartItem: cartItem) {
            XCTAssertNotNil(cell.cartItem)
            XCTAssertEqual(2, cell.quantityEntryView.quantity)
            
            XCTAssertNotNil(cell.product)
            
            XCTAssertEqual(#imageLiteral(resourceName: "TapListLogo"), cell.productImageView.image)
            
            XCTAssertEqual("Regular price product", cell.productNameLabel.text)
            
            XCTAssertFalse(cell.priceLabel.isHidden)
            XCTAssertTrue(cell.offerPriceButton.isHidden)
            
            XCTAssertEqual("$9.98", cell.priceLabel.text)
            
            XCTAssertEqual("$4.99 each", cell.detailLabel.text)
            
            contract.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("configureCell took too long! \(error)")
            }
        }
    }
    
    func testConfigureCell_WithSale() {
        let cell = CartItemTableViewCell()
        let cartItem = CartItem(sku: "0009876543210", quantity: 5)
        
        let productImageView = UIImageView()
        let productNameLabel = UILabel()
        let priceLabel = UILabel()
        let detailLabel = UILabel()
        let quantityEntryView = QuantityEntryView()
        let offerPriceButton = UIButton()
        
        cell.productImageView = productImageView
        cell.productNameLabel = productNameLabel
        cell.priceLabel = priceLabel
        cell.detailLabel = detailLabel
        cell.quantityEntryView = quantityEntryView
        cell.offerPriceButton = offerPriceButton
        
        cell.dataService = MockDataService()
        cell.imageService = MockImageService()
        
        let contract = expectation(description: "configureCell")
        
        cell.configureCell(cartItem: cartItem) {
            XCTAssertNotNil(cell.cartItem)
            XCTAssertEqual(5, cell.quantityEntryView.quantity)
            
            XCTAssertNotNil(cell.product)
            
            XCTAssertEqual(#imageLiteral(resourceName: "TapListLogo"), cell.productImageView.image)
            
            XCTAssertEqual("Sale item", cell.productNameLabel.text)
            
            XCTAssertTrue(cell.priceLabel.isHidden)
            XCTAssertFalse(cell.offerPriceButton.isHidden)
            
            XCTAssertEqual("$9.95", cell.offerPriceButton.currentTitle)
            
            XCTAssertEqual("14 oz", cell.detailLabel.text)
            
            contract.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("configureCell took too long! \(error)")
            }
        }
    }
    
}
