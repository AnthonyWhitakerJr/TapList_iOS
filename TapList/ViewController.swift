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
        
        let product = Product(upc: "0021065600000", name: "Heritage Farm Boneless Skinless Chicken Breasts With Rib Meat (5-6 per Pack)", price: 8.76, detail: "price $1.99/lb", soldBy: .weight, orderBy: .unit)
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

