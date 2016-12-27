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

    /// Text shown by placeholder label. Automatically resizes placeholder label when set.
    @IBInspectable var placeholderText: String? {
        get {
            return placeholder.text
        }
        set {
            placeholder.text = newValue
            placeholder.sizeToFit()
        }
    }
    
    /// The font of the text.
    ///
    /// This property applies to the entire text string. The default font is a 12-point Helvetica plain font.
    ///
    /// Automatically sets font of `placeholder` to italicized version of `font`, if available.
    /// Otherwise will use system italic font.
    override var font: UIFont? {
        didSet {
            guard let font = self.font else { return }
            
            placeholder.configureFont(with: font)
            placeholder.sizeToFit()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        initializeDefaultFont()
        placeholder = PlaceholderLabel(textView: self)
        self.delegate = _delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeDefaultFont()
        placeholder = PlaceholderLabel(textView: self)
        self.delegate = _delegate
    }
    
    /// `Font` is not initialized until `text` is not empty.
    /// Needed to properly init `PlaceholderLabel`.
    private func initializeDefaultFont() {
        guard font == nil else { return }
        
        text = "Temp Text"
        text = ""
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
        let placeholderView = textView as? PlaceholderTextView
        placeholderView?.refresh()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let placeholderView = textView as? PlaceholderTextView
        placeholderView?.refresh()
    }
}

class PlaceholderLabel: UILabel {
    
    init?(textView: PlaceholderTextView) {
        guard let textViewFont = textView.font else { // One would have to do this on purpose.
            return nil
        }
        
        super.init(frame: CGRect(x: 5, y: textViewFont.pointSize / 2, width: textView.frame.width - 10, height: textView.frame.height - textViewFont.pointSize))
        self.numberOfLines = 0
        configureFont(with: textViewFont)
        self.textColor = UIColor(white: 0, alpha: 0.3)
        textView.addSubview(self)
        self.isHidden = !textView.text.isEmpty
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func configureFont(with font: UIFont) {
        if let italic = font.italic() {
            self.font = italic
        } else {
            self.font = UIFont.italicSystemFont(ofSize: font.pointSize)
        }
    }
    
}
