//
//  QuantityTextFieldDelegateTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList
import UIKit

class QuantityTextFieldDelegateTests: XCTestCase {
    func testShouldChangeCharacters_OnlyAcceptNumbers() {
        let delegate = QuantityTextFieldDelegate()
        let textField = UITextField()
        let range = NSRange(location: 0, length: 0)
        
        XCTAssertTrue(textField.text!.isEmpty)
        
        var enteredText = "a"
        XCTAssertFalse(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
        
        enteredText = "."
        XCTAssertFalse(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
        
        enteredText = "U"
        XCTAssertFalse(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
        
        enteredText = "1"
        XCTAssertTrue(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
        
        enteredText = "0"
        XCTAssertTrue(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
        
        enteredText = "5"
        XCTAssertTrue(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
    }
    
    func testShouldChangeCharacters_OnlyAcceptTwoNumbers() {
        let delegate = QuantityTextFieldDelegate()
        let textField = UITextField()
        
        XCTAssertTrue(textField.text!.isEmpty)
        
        // Type '1'
        var enteredText = "1"
        var range = NSRange(location: 0, length: 0)
        XCTAssertTrue(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
        
        // Type '0' to make '10'
        textField.text = "1"
        enteredText = "0"
        range = NSRange(location: 1, length: 0)
        XCTAssertTrue(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
        
        // Type '5', should not work with '10' already in the field.
        textField.text = "10"
        enteredText = "5"
        range = NSRange(location: 2, length: 0)
        XCTAssertFalse(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
        
        // Move cursor and try to type '5' again.
        textField.text = "10"
        enteredText = "5"
        range = NSRange(location: 1, length: 0)
        XCTAssertFalse(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
        
        // Try to backspace '1' from '10'
        textField.text = "10"
        enteredText = ""
        range = NSRange(location: 1, length: 0)
        XCTAssertTrue(delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: enteredText))
    }
    
    func testTextFieldShouldReturn(){
        let delegate = QuantityTextFieldDelegate()
        let textField = UITextField()
        
        XCTAssertTrue(delegate.textFieldShouldReturn(textField))
    }
    
    func testTextFieldDidBeginEditing_DidSelectAll(){
        let delegate = QuantityTextFieldDelegate()
        let textField = UITextField()
        textField.text = "13"
        delegate.textFieldDidBeginEditing(textField)
        
        XCTAssertEqual(textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument), textField.selectedTextRange)
    }
    
    func testTextFieldDidEndEditing() {
        let delegate = QuantityTextFieldDelegate()
        let textField = UITextField()
        textField.text = "2"
        class TestActionDelegate: QuantityTextFieldActionDelegate {
            var valueChangedCalled = false
            
            func quantityTextFieldValueChanged() {
                valueChangedCalled = true
            }
        }
        
        let actionDelegate = TestActionDelegate()
        delegate.actionDelegate = actionDelegate
        delegate.textFieldDidEndEditing(textField)
        XCTAssertEqual("2", textField.text)
        XCTAssertTrue(actionDelegate.valueChangedCalled)
    }
    
    func testTextFieldDidEndEditing_DidDefaultText() {
        let delegate = QuantityTextFieldDelegate()
        let textField = UITextField()
        
        XCTAssertTrue(textField.text!.isEmpty)
        class TestActionDelegate: QuantityTextFieldActionDelegate {
            var valueChangedCalled = false
            
            func quantityTextFieldValueChanged() {
                valueChangedCalled = true
            }
        }
        
        let actionDelegate = TestActionDelegate()
        delegate.actionDelegate = actionDelegate
        delegate.textFieldDidEndEditing(textField)
        XCTAssertEqual("0", textField.text)
        XCTAssertTrue(actionDelegate.valueChangedCalled)
    }
    
    func testNilTextDoesNotCauseErrors() {
        let delegate = QuantityTextFieldDelegate()
        class NilTextField: UITextField {
            var _text: String? = nil
            override var text: String? {
                get{ return _text }
                set{ _text = newValue }
            }
        }
        
        let textField = NilTextField()
        
        XCTAssertNil(textField.text)
        
        XCTAssertTrue(delegate.textField(textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "1"))
        XCTAssertTrue(delegate.textFieldShouldReturn(textField))
        
        delegate.textFieldDidBeginEditing(textField)
        delegate.textFieldDidEndEditing(textField)
        XCTAssertNil(textField.text)
    }
}
