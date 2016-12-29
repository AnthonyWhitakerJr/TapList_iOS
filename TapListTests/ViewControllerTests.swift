//
//  ViewControllerTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class ViewControllerTests: XCTestCase {
    
    var controller: ViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        controller = navigationController.topViewController as! ViewController
        
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(controller.view)
    }
    
    override func tearDown() {
        controller = nil
        super.tearDown()
    }
    
    // Use button.sendAction to test button presses.
    func testExample() {
        XCTAssertNotNil(controller)
    }
    
}
