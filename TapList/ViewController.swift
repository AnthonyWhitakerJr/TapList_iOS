//
//  ViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var products = Array<Product>()
    var productForSegue: Product? // Certainly there is a better way of doing this...
    var indexPathForSalePriceController: IndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProducts()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    // FIXME: Loads every product ever made. Limit to a subset.
    func loadProducts() {
        DataService.ref.product.observe(.value, with: {snapshot in
            if snapshot.value != nil { // FIXME: Potential to destabilize UI with numerous database updates.
                self.products.removeAll()
                
                if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snapshot in snapshots {
                        if let productData = snapshot.value as? Dictionary<String, Any> {
                            let productSku = snapshot.key
                            if let product = Product(sku: productSku, data: productData) {
                                self.products.append(product)
                            }
                        }
                    }
                }
                
                self.collectionView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "offerPopover" {
            guard let productForSegue = productForSegue else {
                print("product not set before segue to sale price controller.")
                return
            }
            guard let controller = segue.destination as? SalePriceViewController else {
                print("improper controller for this segue")
                return
            }
            
            controller.product = productForSegue
            preparePopover(for: controller, sender: sender)
        } else if segue.identifier == "productDetail" {
            guard let productForSegue = productForSegue else {
                print("product not set before segue to sale price controller.")
                return
            }
            guard let controller = segue.destination as? ProductDetailViewController else {
                print("improper controller for this segue")
                return
            }
            
            controller.product = productForSegue
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

extension ViewController: UICollectionViewDelegate {}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = products[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell {
            cell.configureCell(product: product)
            cell.delegate = self
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension ViewController: ProductCellDelegate {
    func handleOfferButtonTapped(product: Product, sender: UIButton) {
        productForSegue = product
        performSegue(withIdentifier: "offerPopover", sender: sender)
    }

    func handleProductImageButtonTapped(product: Product, sender: UIButton) {
        productForSegue = product
        performSegue(withIdentifier: "productDetail", sender: sender)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

