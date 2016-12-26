//
//  RoundedButtonTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/26/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class RoundedButtonTests: XCTestCase {
    
    
    func testCornerRadius() {
        var expectedRadius: CGFloat = 5
        let button = RoundedButton()
        button.cornerRadius = expectedRadius
        
        XCTAssertEqual(expectedRadius, button.cornerRadius)
        XCTAssertEqual(expectedRadius, button.layer.cornerRadius)
        XCTAssertTrue(button.layer.masksToBounds)
        
        expectedRadius = 0
        button.cornerRadius = expectedRadius
        
        XCTAssertEqual(expectedRadius, button.cornerRadius)
        XCTAssertEqual(expectedRadius, button.layer.cornerRadius)
        XCTAssertFalse(button.layer.masksToBounds)
    }
    
}
