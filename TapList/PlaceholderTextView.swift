//
//  PlaceholderTextView.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/8/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

@IBDesignable
class PlaceholderTextView: UITextView {

    var placeholder = UILabel()
    
    @IBInspectable var placeHolderText: String? {
        get {
            return placeholder.text
        }
        set {
            placeholder.text = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        placeholder.numberOfLines = 0
        placeholder.font = UIFont.italicSystemFont(ofSize: (self.font?.pointSize)!)
        placeholder.sizeToFit()
        placeholder.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
        placeholder.textColor = UIColor(white: 0, alpha: 0.3)
        self.addSubview(placeholder)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("Drawing")
        placeholder.isHidden = !self.text.isEmpty
    }
 

}
