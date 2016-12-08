//
//  ViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var products = Array<Product>()
    var productForSalePriceController: Product? // Certainly there is a better way of doing this...
    var indexPathForSalePriceController: IndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var product = Product(upc: "0021065600000", name: "Heritage Farm Boneless Skinless Chicken Breasts With Rib Meat (5-6 per Pack)", listPrice: 8.76, detail: "price $1.99/lb", soldBy: .weight, orderBy: .unit)
        products.append(product)
        product = Product(upc: "0001111016222", name: "Kroger Glazed Sour Cream Cake Donut Holes", listPrice: 2.49, offerPrice: 1.50, detail: "14 oz")
        products.append(product)
        product = Product(upc: "0001111041600", name: "Kroger 2% Reduced Fat Milk", listPrice: 1.69, offerPrice: 1.49, detail: "1/2 gal")
        products.append(product)
        product = Product(upc: "0001111060933", name: "Kroger Grade A Large Eggs", listPrice: 1.99, detail: "18 count")
        products.append(product)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "offerPopover" {
            guard let productForSalePriceController = productForSalePriceController else {
                print("product not set before segue to sale price controller.")
                return
            }
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
            
            controller.product = productForSalePriceController
            
            controller.modalPresentationStyle = .popover
        }
    }

}

extension ViewController: UICollectionViewDelegate {
    
}

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
        productForSalePriceController = product
        performSegue(withIdentifier: "offerPopover", sender: sender)
    }

}

extension ViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

