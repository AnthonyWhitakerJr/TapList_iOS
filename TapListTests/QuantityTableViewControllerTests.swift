//
//  QuantityTableViewControllerTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class QuantityTableViewControllerTests: XCTestCase {
    
    var controller: QuantityTableViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "QuantityTableViewController") as! QuantityTableViewController
        XCTAssertNotNil(controller.view) // Triggers loading of view.
    }
    
    override func tearDown() {
        controller = nil
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertNotNil(controller)
    }
    
}
