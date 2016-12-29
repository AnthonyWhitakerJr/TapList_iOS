//
//  OrderSummaryTableViewCellTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class OrderSummaryTableViewCellTests: XCTestCase {
    
    func testConfigureCell() {
        let cell = OrderSummaryTableViewCell()
        let itemsInOrderLabel = UILabel()
        let subtotalLabel = UILabel()
        let serviceFeeLabel = UILabel()
        let estimatedTotalLabel = UILabel()
        
        cell.itemsInOrderLabel = itemsInOrderLabel
        cell.subtotalLabel = subtotalLabel
        cell.serviceFeeLabel = serviceFeeLabel
        cell.estimatedTotalLabel = estimatedTotalLabel
        
        let dataService = MockDataService()
        
        let cartItem1 = CartItem(sku: "0001234567890", quantity: 2)
        let cartItem2 = CartItem(sku: "0009876543210", quantity: 3)
        let cartItem3 = CartItem(sku: "0001234543210", quantity: 4)
        
        dataService.cart.cartItems = [cartItem1.sku: cartItem1,
                             cartItem2.sku: cartItem2,
                             cartItem3.sku: cartItem3]
        
        for (_, item) in dataService.cart.cartItems {
            item.dataService = dataService
        }
        
        cell.dataService = dataService
        
        let contract = expectation(description: "Configuration")

        cell.configureCell() {
            XCTAssertEqual("9", cell.itemsInOrderLabel.text)
            XCTAssertEqual("$49.91", cell.subtotalLabel.text)
            XCTAssertEqual("$54.86", cell.estimatedTotalLabel.text)
            contract.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("configureCell() took too long! \(error)")
            }
        }
    }
    
}
