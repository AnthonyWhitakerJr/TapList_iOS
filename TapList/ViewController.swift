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

        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            return cell
        }
        
        return UICollectionViewCell()
    }
}

