//
//  ImageCollectionViewCellTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList

class ImageCollectionViewCellTests: XCTestCase {
    
    func testConfigureCell() {
        let cell = ImageCollectionViewCell()
        let imageView = UIImageView()
        cell.imageView = imageView
        
        cell.configureCell(image: #imageLiteral(resourceName: "PlaceholderImage"))
        
        XCTAssertEqual(#imageLiteral(resourceName: "PlaceholderImage"), cell.imageView.image)
    }
    
}
