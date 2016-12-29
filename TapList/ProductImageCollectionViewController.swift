//
//  ProductImageCollectionViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/16/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import Alamofire

class ProductImageCollectionViewController: UICollectionViewController {

    var product: Product!
    var initialIndex: IndexPath?
    var productImages = Array<UIImage>()
    var imageRequests = Array<DataRequest?>()
    
    var imageService = ImageService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setImages()
    }
    
    private func setImages() {
        for imageRequest in imageRequests {
            imageRequest?.cancel() // Cancel any ongoing image requests (can happen when user scrolls quickly).
        }
        self.imageRequests.removeAll()
        
        
        imageRequests = imageService.imagesForAllDirections(for: product, size: .large) { images in
            self.productImages = images
            self.collectionView?.reloadData()
            self.scrollToInitialCell()
        }
    }
    
    func scrollToInitialCell() {
        if let initialIndex = initialIndex {
            collectionView?.scrollToItem(at: initialIndex, at: .centeredHorizontally, animated: false)
        }
        initialIndex = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = productImages[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productImage", for: indexPath) as? ImageCollectionViewCell {
            cell.configureCell(image: image)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension ProductImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
