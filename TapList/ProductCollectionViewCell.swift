//
//  ProductCollectionViewCell.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import Alamofire

@IBDesignable
class ProductCollectionViewCell: UICollectionViewCell {

    var product: Product!
    var imageRequest: DataRequest?
    
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(product: Product) {
        self.product = product
        setImage()
    }
    
    private func setImage() {
        if let imageRequest = imageRequest {
            imageRequest.cancel()
        }
        
        self.productImageView.image = nil // TODO: Replace with placeholder image.
        imageRequest = ImageService.instance.image(for: product, completion: {image in
            if let image = image {
                self.productImageView.image = image
            }
        })
    }

}
