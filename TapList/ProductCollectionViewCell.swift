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
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var eachLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var cartQuantityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configureCell(product: Product, quantityInCart: Int = 0) {
        self.product = product
        setImage()
        productNameLabel.text = product.name
        
        if product.soldBy == Product.TempName1.weight, product.orderBy == Product.TempName2.unit { //TODO: Refactor me: extract method.
            aboutLabel.isHidden = false
            eachLabel.isHidden = false
        } else {
            aboutLabel.isHidden = true
            eachLabel.isHidden = true
        }
        
        priceLabel.text = "$\(product.price!)"
        
        detailLabel.text = product.detail
        
        if quantityInCart == 0 {
            cartQuantityLabel.isHidden = true
        } else {
            cartQuantityLabel.text = "\(quantityInCart) in Cart"
        }
    }
    
    private func setImage() {
        if let imageRequest = imageRequest {
            imageRequest.cancel() // Cancel any ongoing image requests (can happen when user scrolls quickly).
        }
        
        self.productImageView.image = nil // TODO: Replace with placeholder image.
        imageRequest = ImageService.instance.image(for: product, completion: {image in
            if let image = image {
                self.productImageView.image = image
            }
        })
    }
    
    @IBAction func quantityChanged(_ sender: UIStepper) {
        quantityLabel.text = "\(Int(sender.value))"
    }

}
