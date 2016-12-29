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
    var productImages = Array<ProductImage>()
    var imageRequests = Array<DataRequest?>()
    
    var imageService = ImageService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        clearImageRequests()
    }
    
    private func setImages() {
        clearImageRequests()
        imageRequests = imageService.imagesForAllDirections(for: product, size: .large) { images in
            self.productImages = images
            self.collectionView?.reloadData()
            self.scrollToInitialCell()
        }
    }
    
    private func clearImageRequests() {
        for imageRequest in imageRequests {
            imageRequest?.cancel() // Cancel any ongoing image requests (useful if user navigates away quickly).
        }
        self.imageRequests.removeAll()
    }
    
    private func scrollToInitialCell() {
        if let initialIndex = initialIndex {
            collectionView?.scrollToItem(at: initialIndex, at: .centeredHorizontally, animated: false)
        }
        initialIndex = nil
    }

    // MARK: UICollectionViewDataSource

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
