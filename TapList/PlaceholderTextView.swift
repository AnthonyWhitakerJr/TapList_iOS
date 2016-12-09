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
    
    private(set) var placeholder: PlaceholderLabel!
    
    @IBInspectable var placeHolderText: String? {
        get {
            return placeholder.text
        }
        set {
            placeholder.text = newValue
            placeholder.sizeToFit()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        placeholder = PlaceholderLabel(textView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        placeholder = PlaceholderLabel(textView: self)
    }
    
}

class PlaceholderLabel: UILabel {
    let textView: PlaceholderTextView
    
    init(textView: PlaceholderTextView) {
        self.textView = textView
        super.init(frame: CGRect(x: 5, y: (textView.font?.pointSize)! / 2, width: textView.frame.width - 10, height: textView.frame.height - (textView.font?.pointSize)!))
        self.numberOfLines = 0
        self.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        self.textColor = UIColor(white: 0, alpha: 0.3)
        textView.addSubview(self)
        self.isHidden = !textView.text.isEmpty
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
