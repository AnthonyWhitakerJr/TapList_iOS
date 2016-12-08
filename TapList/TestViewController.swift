//
//  TestViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/7/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var tiledView: UIView!
    @IBOutlet weak var soloImage: UIImageView!
    
    @IBOutlet weak var tiledView2: UIView!
    @IBOutlet weak var soloImage2: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        configure(image: #imageLiteral(resourceName: "donutHoles"), imageView: soloImage, view: tiledView)
        configure(image: #imageLiteral(resourceName: "banana"), imageView: soloImage2, view: tiledView2)
    }
    
    func configure(image: UIImage, imageView: UIImageView, view: UIView) {
        view.backgroundColor = UIColor(patternImage: image)
        imageView.image = image
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
//        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
//        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyEffectView.frame = view.bounds
//        vibrancyEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
//        blurEffectView.addSubview(vibrancyEffectView)
        view.addSubview(blurEffectView)
    }
}
