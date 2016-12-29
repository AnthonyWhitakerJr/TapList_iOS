//
//  TapListUITests.swift
//  TapListUITests
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class TapListUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func _testAddToCartButton() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let cell = collectionViewsQuery.children(matching: .cell).element(boundBy: 1)
        let addToCartButton = cell.buttons["Add To Cart"]
        
        addToCartButton.tap()
        XCTAssertTrue(cell.otherElements.containing(.staticText, identifier:"1 in Cart").children(matching: .button).element(boundBy: 0).exists)
        
        addToCartButton.tap()
        XCTAssertTrue(cell.otherElements.containing(.staticText, identifier:"2 in Cart").children(matching: .button).element(boundBy: 0).exists)
        
    }
    
    func _testPlaceholderTextView() {
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.button, identifier:"Add To Cart").children(matching: .button).element(boundBy: 0).tap()
        
        let scrollViewsQuery = app.scrollViews
        let anySpecialInstructionsForThisItemCustomizeYourOrderByUsingCommentsLikeGreenBananasOr12LbThinnlySlicedHamStaticText = scrollViewsQuery.otherElements.textViews.staticTexts["Any special instructions for this item? Customize your order by using comments like \"green bananas\" or \"1/2 lb. thinnly sliced ham.\""]
        anySpecialInstructionsForThisItemCustomizeYourOrderByUsingCommentsLikeGreenBananasOr12LbThinnlySlicedHamStaticText.tap()
        anySpecialInstructionsForThisItemCustomizeYourOrderByUsingCommentsLikeGreenBananasOr12LbThinnlySlicedHamStaticText.tap()
        
        let textView = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Bananas").children(matching: .textView).element
        textView.typeText("Text here")
        
        let bananasElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Bananas").element
        bananasElement.tap()
        textView.tap()
        textView.press(forDuration: 1.8);
        
        let deleteKey = app.keys["delete"]
        deleteKey.tap()
        deleteKey.tap()
        bananasElement.tap()
        
    }
    
}
