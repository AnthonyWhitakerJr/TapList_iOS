//
//  ProductImageCollectionViewControllerTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/29/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class ProductImageCollectionViewControllerTests: XCTestCase {
    
    var controller: ProductImageCollectionViewController!
    var imageService: ImageService!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ProductImageCollectionViewController") as! ProductImageCollectionViewController
        
        imageService = MockImageService()
        controller.imageService = imageService
    }
    
    func testStub() {
        XCTAssertNotNil(controller.view)
    }
    
}
