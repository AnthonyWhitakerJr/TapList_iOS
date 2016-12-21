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
    
    private(set) var placeholder: PlaceholderLabel!
    
    /// Strong reference to custom delegate.
    private let _delegate = PlaceholderTextViewDelegate()

    @IBInspectable var placeholderText: String? {
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
        self.delegate = _delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        placeholder = PlaceholderLabel(textView: self)
        self.delegate = _delegate
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 0.5
        self.clipsToBounds = true
    }
    
    func refresh() {
        placeholder.isHidden = !text.isEmpty
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        let tempText = placeholder.text
        placeholder = PlaceholderLabel(textView: self)
        placeholderText = tempText
    }
}

class PlaceholderTextViewDelegate: NSObject, UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if let textView = textView as? PlaceholderTextView {
            textView.placeholder.isHidden = !textView.text.isEmpty
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let placeholderView = textView as? PlaceholderTextView
        placeholderView?.refresh()
    }
}

class PlaceholderLabel: UILabel {
    
    init(textView: PlaceholderTextView) {
        guard textView.font != nil else { // Should only happen inside Interface Builder.
            super.init(frame: CGRect.zero)
            return
        }
        
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
