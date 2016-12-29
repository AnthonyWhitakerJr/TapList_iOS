//
//  QuantityEntryViewTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList
import UIKit

class QuantityEntryViewTests: XCTestCase {
    
    var valueChanged: Bool = false

    override func tearDown() {
        valueChanged = false
        super.tearDown()
    }
    
    
    func testInit() {
        let view = QuantityEntryView()
        XCTAssertNotNil(view.quantityButton)
        XCTAssertNotNil(view.quantityTextField)
        XCTAssertNotNil(view.quantityTextField.actionDelegate)
        XCTAssertFalse(view.quantityTextField.isEnabled)
    }
    
    func testInit_Coder() {
        let view = QuantityEntryView(coder: NSKeyedUnarchiver(forReadingWith: Data()))
        XCTAssertNotNil(view)
        XCTAssertNotNil(view!.quantityButton)
        XCTAssertNotNil(view!.quantityTextField)
        XCTAssertNotNil(view!.quantityTextField.actionDelegate)
        XCTAssertFalse(view!.quantityTextField.isEnabled)
    }
    
    func testConfigureQuantityView_Under10() {
        let view = QuantityEntryView()
        let previousQuantity = 4
        view.configureQuantityView(previousQuantity: previousQuantity)
        
        XCTAssertFalse(view.quantityButton.isHidden)
        XCTAssertEqual("\(previousQuantity)", view.quantityButton.currentTitle)
        
        XCTAssertFalse(view.quantityTextField.isEnabled)
        XCTAssertTrue(view.quantityTextField.text!.isEmpty)
        
        XCTAssertEqual(previousQuantity, view.quantity)
    }
    
    func testConfigureQuantityView_Over10() {
        let view = QuantityEntryView()
        let previousQuantity = 14
        view.configureQuantityView(previousQuantity: previousQuantity)
        
        XCTAssertTrue(view.quantityButton.isHidden)
        
        XCTAssertEqual("\(previousQuantity)", view.quantityTextField.text)
        XCTAssertTrue(view.quantityTextField.isEnabled)
        
        XCTAssertEqual(previousQuantity, view.quantity)
    }
    
    func testUpdate_SelectLessThan10() {
        XCTAssertFalse(valueChanged, "Sanity check failed.")
        let view = QuantityEntryView()
        let quantity = 4

        view.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        
        view.configureQuantityView(previousQuantity: 2)
     
        XCTAssertEqual(2, view.quantity)
        
        view.update(selectedQuantity: "\(quantity)")
        
        XCTAssertEqual(quantity, view.quantity)
        XCTAssertTrue(valueChanged)
    }
    
    func testUpdate_Select10() {
        XCTAssertFalse(valueChanged, "Sanity check failed.")
        let view = QuantityEntryView()
        
        view.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        
        view.configureQuantityView(previousQuantity: 2)
        
        XCTAssertEqual(2, view.quantity)
        
        view.update(selectedQuantity: "10+")
        view.quantityTextField.delegate?.textFieldDidEndEditing!(view.quantityTextField)
        
        XCTAssertEqual(10, view.quantity)
        XCTAssertTrue(valueChanged)
    }
    
    func valueChanged(_ sender: Any) {
        valueChanged = true
    }
    
    func testQuantity_NilText() {
        let view = QuantityEntryView()
        view.configureQuantityView()
        
        XCTAssertEqual(1, view.quantity)
        view.quantityButton.setTitle(nil, for: .normal)
        XCTAssertEqual(0, view.quantity)
    }
    
    func testBaselines() {
        let view = QuantityEntryView()

        XCTAssertEqual(view.forFirstBaselineLayout, view.quantityTextField.forFirstBaselineLayout)
        XCTAssertEqual(view.forLastBaselineLayout, view.quantityTextField.forLastBaselineLayout)
    }
    
    func testPrepareForInterfaceBuilder() {
        let view = QuantityEntryView()
        
        XCTAssertEqual(nil, view.quantityButton.title(for: .normal))
        view.prepareForInterfaceBuilder()
        XCTAssertEqual("1", view.quantityButton.title(for: .normal))
    }
    
    func testLayoutSubviews() {
        let view = QuantityEntryView(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
        view.layoutSubviews()
        
        let expectedSize = CGSize(width: 45, height: 30)
        XCTAssertEqual(expectedSize, view.quantityButton.frame.size)
        XCTAssertEqual(expectedSize, view.quantityTextField.frame.size)
    }
}
