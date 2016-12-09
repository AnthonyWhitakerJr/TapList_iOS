//
//  PlaceholderTextView.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/8/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

//FIXME: Making this IBDesignable will cause IB & Xcode to crash. Xcode bug??
//@IBDesignable
class PlaceholderTextView: UITextView {

    var placeholder = UILabel() //: PlaceholderLabel?
    
    @IBInspectable var placeHolderText: String? {
        get {
            return placeholder.text
        }
        set {
            placeholder.text = newValue
            placeholder.sizeToFit()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        placeholder.numberOfLines = 0
        placeholder.font = UIFont.italicSystemFont(ofSize: (self.font?.pointSize)!)
        placeholder.frame = CGRect(x: 5, y: (self.font?.pointSize)! / 2, width: self.frame.width - 10, height: self.frame.height - (self.font?.pointSize)!)
//        placeholder.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
        placeholder.textColor = UIColor(white: 0, alpha: 0.3)
        self.addSubview(placeholder)
        placeholder.isHidden = !self.text.isEmpty
//

        
//        placeholder = PlaceholderLabel(textView: self)
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        placeholder.isHidden = !self.text.isEmpty
//    }
 

    class PlaceholderLabel: UILabel {
        let textView: PlaceholderTextView
        
        init(textView: PlaceholderTextView) {
            self.textView = textView
            super.init(frame: textView.frame)
            self.numberOfLines = 0
            self.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
            self.frame = CGRect(x: 5, y: (textView.font?.pointSize)! / 2, width: textView.frame.width - 10, height: textView.frame.height - (textView.font?.pointSize)!)
            self.textColor = UIColor(white: 0, alpha: 0.3)
            textView.addSubview(self)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }
    
}
