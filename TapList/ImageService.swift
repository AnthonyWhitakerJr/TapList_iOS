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
    

    
    static let instance = ImageService()
    
    let baseUrl = "https://www.kroger.com/product/images"
    
    private let imageCache = NSCache<NSString, ProductImage>()
        
    /// Asynchronus request for product image.
    /// - completion: Code to be executed once image has been retrieved.  If image does not exist, completion block provide `nil`.
    /// - returns: The request used to feth the image. Can be used to prematurely cancel if image is no longer needed.
    func image(for product: Product, size: ProductImage.Size = .medium, direction: ProductImage.Direction = .front, completion: @escaping (ProductImage?) -> ()) -> DataRequest? {
        let sku = product.sku
        
        var request: DataRequest? = nil
        
        if let image = imageCache.object(forKey: "\(size.rawValue)/\(direction.rawValue)/\(sku)" as NSString) {
            completion(image)
        } else {
            let url = "\(baseUrl)/\(size.rawValue)/\(direction.rawValue)/\(sku)"
            request = Alamofire.request(url).validate(contentType: ["image/*"]).responseData(completionHandler: { responseData in
                if let data = responseData.data {
                    if let image = ProductImage(direction: direction, size: size, data: data) {
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
    
    func imagesForAllDirections(for product: Product, size: ProductImage.Size = .medium, completion: @escaping (Array<ProductImage>) -> ()) -> Array<DataRequest?> {
        var imageRequests = Array<DataRequest?>()
        var imagesByDirection = Dictionary<ProductImage.Direction, ProductImage>()
        let imageDispatch = DispatchGroup()
        
        for direction in ProductImage.Direction.values {
            imageDispatch.enter()
            let request = image(for: product, size: .large, direction: direction, completion: { image in
                if let image = image {
                    imagesByDirection[direction] = image
                }
                imageDispatch.leave()
            })
            
            imageRequests.append(request)
        }
        
        imageDispatch.notify(queue: .main) {
            var productImages = Array<ProductImage>()
            for direction in ProductImage.Direction.values { // Provides predetermined order, vs order of fetches finishing. Filters out missing pictures.
                if let image = imagesByDirection[direction] {
                    productImages.append(image)
                }
            }
            completion(productImages)
        }
        
        return imageRequests
    }
    
    /// Empties the image cache.
    func clearCache() {
        imageCache.removeAllObjects()
    }
}
