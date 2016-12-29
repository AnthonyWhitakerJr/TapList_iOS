//
//  PlaceholderTextViewTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/26/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class PlaceholderTextViewTests: XCTestCase {
    
    func testInit_NoParameters() {
        let placeholderTextView = PlaceholderTextView()
        XCTAssertNotNil(placeholderTextView.placeholder)
        XCTAssertTrue(placeholderTextView.delegate is PlaceholderTextViewDelegate)
        XCTAssertNotNil(placeholderTextView.font)
    }
    
    func testMaliciousInit() {
        let placeholderTextView = PlaceholderTextView()
        placeholderTextView.font = nil
        XCTAssertNil(PlaceholderLabel(textView: placeholderTextView))
    }
    
    func testPlaceholderLabelCoderInit() {
        XCTAssertNil(PlaceholderLabel(coder: NSCoder()))
    }
    
    func testFontChange_HasItalic() {
        let fontSize: CGFloat = 16
        let placeholderTextView = PlaceholderTextView()
        placeholderTextView.font = UIFont(name: "Arial", size: fontSize)
        let expectedFont = UIFont(name: "Arial-ItalicMT", size: fontSize)
        
        XCTAssertEqual(placeholderTextView.font?.pointSize, placeholderTextView.placeholder.font.pointSize)
        XCTAssertEqual(expectedFont, placeholderTextView.placeholder.font)
    }
    
    func testFontChange_NoItalic() {
        let fontSize: CGFloat = 15
        let placeholderTextView = PlaceholderTextView()
        placeholderTextView.font = UIFont(name: "AmericanTypewriter", size: fontSize)
        let expectedFont = UIFont.italicSystemFont(ofSize: fontSize)
        
        XCTAssertEqual(placeholderTextView.font?.pointSize, placeholderTextView.placeholder.font.pointSize)
        XCTAssertEqual(expectedFont, placeholderTextView.placeholder.font)
    }
}
