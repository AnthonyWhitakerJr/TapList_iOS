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
    override func image(for product: Product, size: Size = .medium, direction: Direction = .front, completion: @escaping (UIImage?) -> ()) -> DataRequest? {
        completion(#imageLiteral(resourceName: "TapListLogo"))
        return nil
    }
}
