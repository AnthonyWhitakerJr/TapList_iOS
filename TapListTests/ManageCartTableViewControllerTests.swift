//
//  ManageCartTableViewControllerTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/29/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class ManageCartTableViewControllerTests: XCTestCase {
    
    var controller: ManageCartTableViewController!
    var dataService: DataService!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ManageCartTableViewController") as! ManageCartTableViewController
        
        dataService = MockDataService()
        controller.dataService = dataService
    }
    
    override func tearDown() {
        controller = nil
        dataService = nil
        super.tearDown()
    }
    
    func testStub() {
        XCTAssertNotNil(controller.view)
    }
    
}
