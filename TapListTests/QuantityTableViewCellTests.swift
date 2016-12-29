//
//  QuantityTableViewCellTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class QuantityTableViewCellTests: XCTestCase {
    
    func testConfigureCell() {
        let cell = QuantityTableViewCell()
        let quantityLabel = UILabel()
        cell.quantityLabel = quantityLabel
        
        let text = "5"
        cell.configureCell(label: text)
        
        XCTAssertEqual(text, cell.quantityLabel.text)
    }

    func testConfigureCell_Selected() {
        let cell = QuantityTableViewCell()
        let quantityLabel = UILabel()
        cell.quantityLabel = quantityLabel
        
        let text = "5"
        cell.configureCell(label: text, wasSelected: true)
        
        XCTAssertEqual(text, cell.quantityLabel.text)
        
        let expectedColor = UIColor.lightGray.withAlphaComponent(0.5)
        XCTAssertEqual(expectedColor, cell.backgroundColor)
    }
}
