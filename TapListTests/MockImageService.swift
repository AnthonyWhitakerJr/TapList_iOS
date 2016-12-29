//
//  MockImageService.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import Alamofire
@testable import TapList

class MockImageService: ImageService {
    override func image(for product: Product, size: ProductImage.Size = .medium, direction: ProductImage.Direction = .front, completion: @escaping (ProductImage?) -> ()) -> DataRequest? {
        completion(ProductImage(direction: direction, size: size, data: UIImagePNGRepresentation(#imageLiteral(resourceName: "TapListLogo"))!))
        return nil
    }
}
