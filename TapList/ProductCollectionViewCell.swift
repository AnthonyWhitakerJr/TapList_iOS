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
    @IBOutlet weak var listPriceLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var cartQuantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configureCell(product: Product, quantityInCart: Int = 0) {
        self.product = product
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        setImage()
        
        productNameLabel.text = product.name
        
        if product.soldBy == Product.TempName1.weight, product.orderBy == Product.TempName2.unit { //TODO: Refactor me: extract method.
            aboutLabel.isHidden = false
            eachLabel.isHidden = false
        } else {
            aboutLabel.isHidden = true
            eachLabel.isHidden = true
        }
        
        if let price = product.price {
            priceLabel.isHidden = false
            priceLabel.text = formatter.string(from: NSNumber(value: price))
        } else {
            priceLabel.isHidden = true
        }
        
        if let listPrice = product.listPrice {
            listPriceLabel.isHidden = false
            listPriceLabel.attributedText = NSAttributedString(string: formatter.string(from: NSNumber(value: listPrice))!,
                                                               attributes: [NSStrikethroughStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue])
        } else {
            listPriceLabel.isHidden = true
        }
        
        if let offerPrice = product.offerPrice {
            offerPriceLabel.isHidden = false
            offerPriceLabel.text = formatter.string(from: NSNumber(value: offerPrice))!
        } else {
            offerPriceLabel.isHidden = true
        }
        
        detailLabel.text = product.detail
        
        if quantityInCart == 0 {
            cartQuantityLabel.isHidden = true
        } else {
            cartQuantityLabel.isHidden = false
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
