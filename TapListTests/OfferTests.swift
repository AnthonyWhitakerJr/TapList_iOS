//
//  OfferTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/24/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class OfferTests: XCTestCase {
    
    func testConvenienceInit1() {
        let productSku = "0001234567890"
        let offerDescription = "Buy this thing"
        
        let data: Dictionary<String, Any> = [Offer.DataKey.offerDescription.rawValue: offerDescription]
        
        let offer = Offer(productSku: productSku, data: data)
        
        XCTAssertNotNil(offer)
        XCTAssertEqual(productSku, offer?.productSku)
        XCTAssertEqual(offerDescription, offer?.offerDescription)
    }
    
    func testConvenienceInit2() {
        let productSku = "0001234567890"
        let endDate = "02/14/2017"
        let offerDescription = "Buy this thing"
        
        let data: Dictionary<String, Any> = [Offer.DataKey.endDate.rawValue: endDate,
                                             Offer.DataKey.offerDescription.rawValue: offerDescription]
        
        let offer = Offer(productSku: productSku, data: data)
        
        XCTAssertNotNil(offer)
        XCTAssertEqual(productSku, offer?.productSku)
        XCTAssertEqual(endDate, offer?.endDate)
        XCTAssertEqual(offerDescription, offer?.offerDescription)
    }
    
    func testConvenienceInit3() {
        let productSku = "0001234567890"
        let endDate = "02/14/2017"
        let offerDescription = "Buy this thing"
        let shortDescription = "Very nice thing"
        let offerType = Offer.OfferType.n
        let offerQuantity = 2
        let offerPriceTitle = "3"
        
        let data: Dictionary<String, Any> = [Offer.DataKey.endDate.rawValue: endDate,
                                             Offer.DataKey.offerType.rawValue: offerType.rawValue,
                                             Offer.DataKey.offerQuantity.rawValue: offerQuantity,
                                             Offer.DataKey.offerPriceTitle.rawValue: offerPriceTitle,
                                             Offer.DataKey.offerDescription.rawValue: offerDescription,
                                             Offer.DataKey.offerShortDescription.rawValue: shortDescription]
        
        let offer = Offer(productSku: productSku, data: data)
        
        XCTAssertNotNil(offer)
        XCTAssertEqual(productSku, offer?.productSku)
        XCTAssertEqual(endDate, offer?.endDate)
        XCTAssertEqual(offerType, offer?.offerType)
        XCTAssertEqual(offerQuantity, offer?.offerQuantity)
        XCTAssertEqual(offerPriceTitle, offer?.offerPriceTitle)
        XCTAssertEqual(offerDescription, offer?.offerDescription)
        XCTAssertEqual(shortDescription, offer?.offerShortDescription)
    }
    
}
