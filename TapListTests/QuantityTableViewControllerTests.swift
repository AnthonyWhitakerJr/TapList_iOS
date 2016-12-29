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
    
    func testCellForRow() {
        controller.previousQuantity = "4"
        for i in 0...9 {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = controller.tableView(controller.tableView, cellForRowAt: indexPath) as? QuantityTableViewCell
            
            switch i {
            case 9:
                XCTAssertEqual("10+", cell?.quantityLabel.text)
            case 3:
                XCTAssertEqual("4", cell?.quantityLabel.text)
                XCTAssertEqual(UIColor.lightGray.withAlphaComponent(0.5), cell?.backgroundColor)
            default:
                XCTAssertEqual("\(i + 1)", cell?.quantityLabel.text)
            }
        }
    }
    
    func testCellForRow_SanityCheck() {
        let controller = QuantityTableViewController()
        let indexPath = IndexPath(row: 0, section: 0)
        controller.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "quantityCell")
        let cell = controller.tableView(controller.tableView, cellForRowAt: indexPath)
        
        XCTAssertNotNil(cell)
        XCTAssertFalse(cell is QuantityTableViewCell)
    }
    
    func testRowSelection() {
        class TestDelegate: QuantityTableViewControllerDelegate {
            var quantity: String?
            func update(selectedQuantity: String) {
                quantity = selectedQuantity
            }
        }
        
        let delegate = TestDelegate()
        controller.delegate = delegate
        
        XCTAssertEqual(10, controller.tableView.numberOfRows(inSection: 0)) // Initialize table.
        
        let indexPath = IndexPath(row: 6, section: 0)
        controller.tableView(controller.tableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual("7", delegate.quantity)
    }
    
    func testSize() {
        controller.viewWillAppear(false)
        let expectedSize = CGSize(width: 375, height: 440)
        
        XCTAssertEqual(expectedSize, controller.view.frame.size)
    }
    
}
