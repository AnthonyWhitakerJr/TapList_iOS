//
//  ProductDetailViewControllerTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/29/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class ProductDetailViewControllerTests: XCTestCase {
    
    var controller: ProductDetailViewController!
    var dataService: DataService!
    var imageService: ImageService!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        
        dataService = MockDataService()
        imageService = MockImageService()
        controller.dataService = dataService
        controller.imageService = imageService
    }
    
    override func tearDown() {
        controller = nil
        dataService = nil
        imageService = nil
        super.tearDown()
    }
    
    func testStub() {
        XCTAssertNotNil(controller.view)
    }
    
}
