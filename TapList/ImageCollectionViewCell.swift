//
//  ImageCollectionViewCell.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/9/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(image: UIImage) {
        imageView.image = image
    }
}
