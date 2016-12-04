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
    }
    
    enum Direction: String {
        case front
        case back
        case left
        case top
    }
    
    let instance = ImageService()
    
    let baseUrl = "https://www.kroger.com/product/images/"
    
    let imageCache = NSCache<NSString, UIImage>()
    
    private init(){}
    
    func image(for product: Product, size: Size = .medium, direction: Direction = .front, completion: @escaping (UIImage?) -> ()) -> DataRequest? {
        guard let id = product.id else {
            completion(nil)
            return nil
        }
        
        var request: DataRequest? = nil
        
        if let image = imageCache.object(forKey: id as NSString) {
            completion(image)
        } else {
            let url = "\(baseUrl)/\(size.rawValue)/\(direction.rawValue)/\(id)"
            request = Alamofire.request(url).validate(contentType: ["image/*"]).responseData(completionHandler: { responseData in
                if let data = responseData.data {
                    if let image = UIImage(data: data) {
                        self.imageCache.setObject(image, forKey: url as NSString)
                        completion(image)
                    }
                }
            })
        }
        
        return request
    }
}
