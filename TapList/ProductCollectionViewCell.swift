//
//  ProductCollectionViewCell.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import Alamofire

class ProductCollectionViewCell: UICollectionViewCell {

    var product: Product!
    var imageRequest: DataRequest?
    var delegate: ProductCellDelegate?
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var eachLabel: UILabel!
    @IBOutlet weak var listPriceLabel: UILabel!
    @IBOutlet weak var offerPriceButton: UIButton!
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
        
        if product.soldBy == .weight, product.orderBy == .unit { //TODO: Refactor me: extract method.
            aboutLabel.isHidden = false
            eachLabel.isHidden = false
        } else {
            aboutLabel.isHidden = true
            eachLabel.isHidden = true
        }

        if let offerPrice = product.offerPrice {
            priceLabel.isHidden = true
            listPriceLabel.isHidden = false
            listPriceLabel.attributedText = NSAttributedString(string: formatter.string(from: NSNumber(value: product.listPrice!))!, attributes: [NSStrikethroughStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue])
            
            offerPriceButton.isHidden = false
            offerPriceButton.setTitle(formatter.string(from: NSNumber(value: offerPrice))!, for: .normal)
        } else {
            priceLabel.isHidden = false
            priceLabel.text = formatter.string(from: NSNumber(value: product.listPrice!))
            
            offerPriceButton.isHidden = true
            listPriceLabel.isHidden = true
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
            self.productImageView.image = image
        })
    }
    
    @IBAction func quantityChanged(_ sender: UIStepper) {
        quantityLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func offerButtonTapped(_ sender: UIButton) {
        delegate?.handleOfferButtonTapped(product: product, sender: sender)
    }

}

protocol ProductCellDelegate {
    func handleOfferButtonTapped(product: Product, sender: UIButton)
}
