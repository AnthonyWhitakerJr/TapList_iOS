//
//  SalePriceViewControllerTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/29/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class SalePriceViewControllerTests: XCTestCase {
    
    var controller: SalePriceViewController!
    var dataService: DataService!
    
    var saleTitleLabel: UILabel!
    var offerDescriptionLabel: UILabel!
    var offerShortDescriptionLabel: UILabel!
    var expirationDateLabel: UILabel!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "SalePriceViewController") as! SalePriceViewController
        
        dataService = MockDataService()
        controller.dataService = dataService
        
        saleTitleLabel = UILabel()
        offerDescriptionLabel = UILabel()
        offerShortDescriptionLabel = UILabel()
        expirationDateLabel = UILabel()
    }
    
    override func tearDown() {
        saleTitleLabel = nil
        offerDescriptionLabel = nil
        offerShortDescriptionLabel = nil
        expirationDateLabel = nil
        
        controller = nil
        dataService = nil
        
        super.tearDown()
    }
    
    func testConfiguration_OnSale() {
        let product = MockDataService.TestProduct().onSale
        let expectedOffer = MockDataService.TestOffer().onSale

        controller.product = product
        XCTAssertNotNil(controller.view) // Load view
        
        XCTAssertEqual("$\(product.offerPrice!)", controller.saleTitleLabel.text)
        XCTAssertEqual(expectedOffer.offerDescription, controller.offerDescriptionLabel.text)
        XCTAssertTrue(controller.offerShortDescriptionLabel.isHidden)
        
        XCTAssertFalse(controller.expirationDateLabel.isHidden)
        XCTAssertEqual("exp \(expectedOffer.endDate!)", controller.expirationDateLabel.text)
    }
    
    func testConfiguration_OnSaleIndefinetly() {
        let product = MockDataService.TestProduct().onSaleIndefinetly
        let expectedOffer = MockDataService.TestOffer().onSaleIndefinetly
        
        controller.product = product
        XCTAssertNotNil(controller.view) // Load view
        
        XCTAssertEqual("$\(product.offerPrice!)", controller.saleTitleLabel.text)
        XCTAssertEqual(expectedOffer.offerDescription, controller.offerDescriptionLabel.text)
        XCTAssertTrue(controller.offerShortDescriptionLabel.isHidden)
        XCTAssertTrue(controller.expirationDateLabel.isHidden)
    }
    
    func testConfiguration_OnSale4For5() {
        let product = MockDataService.TestProduct().onSale4For5
        let expectedOffer = MockDataService.TestOffer().onSale4For5
        
        controller.product = product
        XCTAssertNotNil(controller.view) // Load view
        
        XCTAssertEqual("\(expectedOffer.offerQuantity!)/$\(expectedOffer.offerPriceTitle!)", controller.saleTitleLabel.text)
        XCTAssertEqual(expectedOffer.offerDescription, controller.offerDescriptionLabel.text)
        XCTAssertFalse(controller.offerShortDescriptionLabel.isHidden)
        XCTAssertEqual(expectedOffer.offerShortDescription, controller.offerShortDescriptionLabel.text)
        
        XCTAssertFalse(controller.expirationDateLabel.isHidden)
        XCTAssertEqual("exp \(expectedOffer.endDate!)", controller.expirationDateLabel.text)
    }
    
    func testConfiguration_NoOffer() {
        let product = MockDataService.TestProduct().regularPriced
        
        controller.product = product
        XCTAssertNotNil(controller.view) // Load view
        
        // No errors == test pass
    }
    
    func testConfiguration_UnexpectedType() {
        let product = MockDataService.TestProduct().onSaleTypeB
        
        controller.product = product
        XCTAssertNotNil(controller.view) // Load view
        
        // No errors == test pass; behaviour undefined.
    }
    
}
