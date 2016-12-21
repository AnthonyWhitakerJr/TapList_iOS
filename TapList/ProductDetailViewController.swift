//
//  ProductDetailViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/9/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import Alamofire

class ProductDetailViewController: UIViewController, ProductView {

    @IBOutlet weak var productImageCollectionView: UICollectionView!
    @IBOutlet weak var specialInstructionTextView: PlaceholderTextView!
    
    @IBOutlet weak var skuLabel: UILabel!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var eachLabel: UILabel!
    @IBOutlet weak var listPriceLabel: UILabel!
    @IBOutlet weak var offerPriceButton: UIButton!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cartQuantityLabel: UILabel!
    
    @IBOutlet weak var quantityEntryView: QuantityEntryView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var keyboardHandler: KeyboardHandler!
    var product: Product!
    var productImages = Array<UIImage>()
    var imageRequests = Array<DataRequest?>()
    var quantityInCart: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setImages()
        
        productImageCollectionView.delegate = self
        productImageCollectionView.dataSource = self
                
        keyboardHandler = KeyboardHandler(contextView: self.view, scrollView: scrollView, onlyScrollForKeyboard: true)
        keyboardHandler.startDismissingKeyboardOnTap()
        keyboardHandler.startObservingKeyboardEvents()
    }
    
    private func setImages() {
        for imageRequest in imageRequests {
            imageRequest?.cancel() // Cancel any ongoing image requests (can happen when user scrolls quickly).
        }
        
        imageRequests = ImageService.instance.imagesForAllDirections(for: product, size: .large) { images in
            self.productImages = images
            self.productImageCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let cartItem = DataService.instance.cart.cartItems[product.sku] {
            self.quantityInCart = cartItem.quantity
        } else {
            self.quantityInCart = 0
        }
        
        configureProductView()
        skuLabel.text = "SKU:\(product.sku)"
        
        if let cartItem = DataService.instance.cart.cartItems[product.sku] {
            if let specialInstructions = cartItem.specialInstructions {
                specialInstructionTextView.text = specialInstructions
                specialInstructionTextView.refresh()
            }
        }
        
        quantityEntryView.configureQuantityView(previousQuantity: quantityInCart)
        quantityEntryView.quantityButton.addTarget(self, action: #selector(quantityButtonTouched(_:)), for: .touchUpInside)
    }

    func quantityButtonTouched(_ sender: UIButton) {
        performSegue(withIdentifier: "quantityPopover", sender: sender)
    }
    
    
    @IBAction func updateCartPressed(_ sender: UIButton) {
        var specialInstructions: String? = nil
        if let newInstructions = specialInstructionTextView.text, !newInstructions.isEmpty {
            specialInstructions = newInstructions
        }
        
        quantityInCart = quantityEntryView.quantity
        updateCartQuantityLabel()
        
        let cartItem = CartItem(sku: product.sku, quantity: quantityEntryView.quantity, specialInstructions: specialInstructions)
        DataService.instance.update(cartItem: cartItem)
        
//        navigationController?.popViewController(animated: true) //FIXME: Executes before update finishes executing, causing stale data on previous controller.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "offerPopover" {
            guard let controller = segue.destination as? SalePriceViewController else {
                print("improper controller for this segue")
                return
            }
            
            controller.product = product
            preparePopover(for: controller, sender: sender)
        } else if segue.identifier == "quantityPopover" {
            guard let controller = segue.destination as? QuantityTableViewController else {
                print("improper controller for this segue")
                return
            }
            
            controller.delegate = quantityEntryView
            controller.previousQuantity = "\(quantityEntryView.quantity)"
            preparePopover(for: controller, sender: sender)
        } else if segue.identifier == "fullScreenImages" {
            guard let controller = segue.destination as? ProductImageCollectionViewController else {
                print("improper controller for this segue")
                return
            }
            
            controller.product = product
            if let index = sender as? IndexPath {
                controller.initialIndex = index
            }
        }
    }
    
    func preparePopover(for controller: UIViewController, sender: Any?) {
        controller.popoverPresentationController?.delegate = self
        
        // Set bounds for arrow placement.
        if let sender = sender as? UIButton {
            controller.popoverPresentationController?.sourceView = sender
            controller.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: sender.frame.width, height: sender.frame.height)
        }
        
        controller.modalPresentationStyle = .popover
    }

}

extension ProductDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

extension ProductDetailViewController: UICollectionViewDelegate {}

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = productImages[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productImage", for: indexPath) as? ImageCollectionViewCell {
            cell.configureCell(image: image)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fullScreenImages", sender: indexPath)
    }
}

extension ProductDetailViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
