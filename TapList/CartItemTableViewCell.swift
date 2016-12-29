//
//  CartItemTableViewCell.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/16/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import Alamofire

class CartItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var quantityEntryView: QuantityEntryView!
    @IBOutlet weak var offerPriceButton: UIButton!
    
    var delegate: CartCellDelegate?
    var imageRequest: DataRequest?
    var cartItem: CartItem!
    var product: Product!
    
    var dataService = DataService.instance
    var imageService = ImageService.instance

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 1
        layer.masksToBounds = true
    }
    
    func configureCell(cartItem: CartItem, completion: (() -> ())? = nil) {
        self.cartItem = cartItem
        
        quantityEntryView.configureQuantityView(previousQuantity: cartItem.quantity)
        quantityEntryView.delegate = self
        
        dataService.product(for: cartItem.sku) { product in
            if let product = product {
                self.product = product
                
                self.setImage()
                
                self.productNameLabel.text = product.name
                
                let formatter = NumberFormatter()
                formatter.numberStyle = .currency
                
                if let offerPrice = product.offerPrice {
                    self.priceLabel.isHidden = true
                    self.offerPriceButton.isHidden = false
                    
                    let totalPrice = offerPrice * Double(cartItem.quantity)
                    self.offerPriceButton.setTitle(formatter.string(from: NSNumber(value: totalPrice))!, for: .normal)
                } else {
                    self.priceLabel.isHidden = false
                    self.offerPriceButton.isHidden = true
                    
                    let totalPrice = product.listPrice! * Double(cartItem.quantity)
                    self.priceLabel.text = formatter.string(from: NSNumber(value: totalPrice))
                }
                
                self.detailLabel.text = product.detail
                
                completion?()
            }
        }
    }
    
    private func setImage() {
        if let imageRequest = imageRequest {
            imageRequest.cancel() // Cancel any ongoing image requests (can happen when user scrolls quickly).
        }
        
        self.productImageView.image = #imageLiteral(resourceName: "PlaceholderImage")
        imageRequest = imageService.image(for: product, completion: {image in
            if let image = image {
                self.productImageView.image = image
            }
        })
    }
    
    @IBAction func offerButtonTapped(_ sender: UIButton) {
        guard let product = product else { return }
        
        delegate?.handleOfferButtonTapped(product: product, sender: sender)
    }
    
    @IBAction func productImageButtonPressed(_ sender: UIButton) {
        guard let product = product else { return }
        
        delegate?.handleProductImageButtonTapped(product: product, sender: sender)
    }
    
    @IBAction func quantityUpdated(_ sender: QuantityEntryView) {
        delegate?.handleQuantityUpdate(cell: self, newQuantity: sender.quantity)
    }
}

extension CartItemTableViewCell: QuantityEntryViewDelegate {
    func segueToQuantityPopover(_ sender: UIButton) {
        delegate?.handleSegueToQuantityPopover(quantityEntryView: quantityEntryView, sender: sender)
    }
}

protocol CartCellDelegate: ProductCellDelegate {
    func handleQuantityUpdate(cell: CartItemTableViewCell, newQuantity: Int)
    func handleSegueToQuantityPopover(quantityEntryView: QuantityEntryView, sender: UIButton)
}
