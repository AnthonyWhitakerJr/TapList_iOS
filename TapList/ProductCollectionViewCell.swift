//
//  ProductCollectionViewCell.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import Alamofire

class ProductCollectionViewCell: UICollectionViewCell, ProductView {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var eachLabel: UILabel!
    @IBOutlet weak var listPriceLabel: UILabel!
    @IBOutlet weak var offerPriceButton: UIButton!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cartQuantityLabel: UILabel!
    
    var delegate: ProductCellDelegate?
    var imageRequest: DataRequest?
    var product: Product!
    var quantityInCart: Int = 0
    
    var dataService = DataService.instance
    var imageService = ImageService.instance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 1
    }
    
    func configureCell(product: Product) {
        self.product = product
        
        if let cartItem = dataService.cart.cartItems[product.sku] {
            self.quantityInCart = cartItem.quantity
        } else {
            self.quantityInCart = 0
        }
        
        setImage()
        configureProductView()
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
        delegate?.handleOfferButtonTapped(product: product, sender: sender)
    }
    
    @IBAction func productImageButtonPressed(_ sender: UIButton) {
        delegate?.handleProductImageButtonTapped(product: product, sender: sender)
    }
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
        self.quantityInCart = quantityInCart + 1
        updateCartQuantityLabel()
        
        dataService.addToCart(productSku: product.sku)
    }
    

}

protocol ProductCellDelegate {
    func handleOfferButtonTapped(product: Product, sender: UIButton)
    func handleProductImageButtonTapped(product: Product, sender: UIButton)
}
