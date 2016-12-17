//
//  ImageService.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

class ImageService {
    
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
    
    static let instance = ImageService()
    
    let baseUrl = "https://www.kroger.com/product/images"
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init(){}
    
    /// Asynchronus request for product image. If image does not exist, completion block will NOT be executed.
    /// - completion: Code to be executed once image has been retrieved.
    /// - returns: The request used to feth the image. Can be used to prematurely cancel if image is no longer needed.
    func image(for product: Product, size: Size = .medium, direction: Direction = .front, completion: @escaping (UIImage?) -> ()) -> DataRequest? {
        let sku = product.sku
        
        var request: DataRequest? = nil
        
        if let image = imageCache.object(forKey: "\(size.rawValue)/\(direction.rawValue)/\(sku)" as NSString) {
            completion(image)
        } else {
            let url = "\(baseUrl)/\(size.rawValue)/\(direction.rawValue)/\(sku)"
            request = Alamofire.request(url).validate(contentType: ["image/*"]).responseData(completionHandler: { responseData in
                if let data = responseData.data {
                    if let image = UIImage(data: data) {
                        self.imageCache.setObject(image, forKey: url as NSString)
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }
            })
        }

        return request
    }
    
    /// Empties the image cache.
    func clearCache() {
        imageCache.removeAllObjects()
    }
}
