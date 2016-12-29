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
    
    func testCellForItemAt() {
        controller.product = MockDataService.TestProduct().regularPriced
        let indexPath = IndexPath(row: 0, section: 0)
        controller.initialIndex = indexPath
        XCTAssertNotNil(controller.view)
        
        // viewDidLoad does not have completion handler. Not a problem for running app, but makes testing convoluted.
        let hackToWaitForAsyncCall = expectation(description: "hackToWaitForAsyncCall")
        
//        _ = imageService.imagesForAllDirections(for: MockDataService.TestProduct().regularPriced, size: .large) { _ in
        
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
            let cell = self.controller.collectionView(self.controller.collectionView!, cellForItemAt: indexPath) as? ImageCollectionViewCell
            XCTAssertNotNil(cell?.imageView.image)
            hackToWaitForAsyncCall.fulfill()
        }
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("imageService took too long! \(error)")
            }
        }
    }
    
    func testImageRequests() {
        controller.product = MockDataService.TestProduct().regularPriced
        XCTAssertNotNil(controller.view)
        controller.viewWillDisappear(false)
        XCTAssertTrue(controller.imageRequests.isEmpty)
    }

}
