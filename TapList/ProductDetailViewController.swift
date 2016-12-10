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
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var cartQuantityLabel: UILabel!
    
    var product: Product!
    var productImages = Array<UIImage>()
    
    var imageRequests = Array<DataRequest?>()
    
    var quantityInCart: Int! = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setImages()
        
        productImageCollectionView.delegate = self
        productImageCollectionView.dataSource = self
        
        specialInstructionTextView.delegate = self
    }
    
    private func setImages() {
        for imageRequest in imageRequests {
            imageRequest?.cancel() // Cancel any ongoing image requests (can happen when user scrolls quickly).
        }
        self.imageRequests.removeAll()
        
        
        var imagesByDirection = Dictionary<ImageService.Direction, UIImage>()
        
        for direction in ImageService.Direction.values {
            let request = ImageService.instance.image(for: product, size: .large, direction: direction, completion: { image in
                imagesByDirection[direction] = image
                
                //TODO: Refactor to use semaphores.
                // After all images have been fetched:
//                if imagesByDirection.count == ImageService.Direction.values.count { //FIXME: Failed requests do NOT return nil ergo this does not work as expected.
                    self.productImages.removeAll()
                    for direction in ImageService.Direction.values { // Provides predetermined order, vs order of fetches finishing. Filters out missing pictures.
                        if let image = imagesByDirection[direction] {
                            self.productImages.append(image)
                        }
                    }
                    self.productImageCollectionView.reloadData()
//                }
                
            })
            
            imageRequests.append(request)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureProductView()
        skuLabel.text = "SKU:\(product.sku)"
    }
    
    @IBAction func quantityChanged(_ sender: UIStepper) {
        quantityLabel.text = "\(Int(sender.value))"
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
            
            controller.popoverPresentationController?.delegate = self
            
            // Set bounds for arrow placement.
            if let sender = sender as? UIButton {
                controller.popoverPresentationController?.sourceView = sender
                controller.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: sender.frame.width, height: sender.frame.height)
            }
            
            controller.product = product
            
            controller.modalPresentationStyle = .popover
        }
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
}

extension ProductDetailViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if let textView = textView as? PlaceholderTextView {
            textView.placeholder.isHidden = !textView.text.isEmpty
        }
    }
}

extension ProductDetailViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
