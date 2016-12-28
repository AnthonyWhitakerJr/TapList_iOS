//
//  QuantityTextFieldTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList
import UIKit

class QuantityTextFieldTests: XCTestCase {
    
    func testInit() {
        let textField = QuantityTextField()
        XCTAssertTrue(textField.delegate is QuantityTextFieldDelegate)
    }
    
    func testInit_Coder() {
        let textField = QuantityTextField(coder: NSKeyedUnarchiver(forReadingWith: Data()))
        XCTAssertTrue(textField?.delegate is QuantityTextFieldDelegate)
    }
    
    func testActionDelegate(){
        let textField = QuantityTextField()
        
        class TestActionDelegate: QuantityTextFieldActionDelegate {
            func quantityTextFieldValueChanged() {}
        }
        
        XCTAssertNil(textField.actionDelegate)
        
        let actionDelegate = TestActionDelegate()
        textField.actionDelegate = actionDelegate
        
        XCTAssertNotNil(textField.actionDelegate)
    }
    
    func testActionDelegate_WithoutQuantityTextFieldDelegate(){
        let textField = QuantityTextField()
        
        class TestActionDelegate: QuantityTextFieldActionDelegate {
            func quantityTextFieldValueChanged() {}
        }
        
        class TestTextDelegate: NSObject, UITextFieldDelegate{}
        
        textField.delegate = TestTextDelegate()
        
        XCTAssertNil(textField.actionDelegate)
        
        let actionDelegate = TestActionDelegate()
        textField.actionDelegate = actionDelegate
        
        XCTAssertNil(textField.actionDelegate)
    }
    
}
