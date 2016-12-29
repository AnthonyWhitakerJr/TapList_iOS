//
//  ProductImage.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/29/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

class ProductImage: UIImage {
    
    var direction: Direction
    var imageSize: Size
    
    enum Size: String {
        case small
        case medium
        case large
        
        static var values: Array<Size> {
            return [.small, .medium, .large]
        }
    }
    
    enum Direction: String {
        case front
        case back
        case left
        case right
        case top
        
        static var values: Array<Direction> {
            return [.front, .back, .left, .right, .top]
        }
    }
    
    init?(direction: Direction, size: Size, data: Data) {
        self.direction = direction
        self.imageSize = size
        super.init(data: data)
    }
    
    required convenience init(imageLiteralResourceName name: String) {
        fatalError("init(imageLiteralResourceName:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func ==(lhs: ProductImage, rhs: ProductImage) -> Bool {
        return lhs.direction == rhs.direction &&
            lhs.imageSize == rhs.imageSize &&
            lhs as UIImage == rhs as UIImage
    }

}
