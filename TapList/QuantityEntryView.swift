//
//  QuantityEntryView.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/19/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

@IBDesignable
class QuantityEntryView: UIControl, QuantityTableViewControllerDelegate, QuantityTextFieldActionDelegate {

    var quantityButton: UIButton!
    var quantityTextField: QuantityTextField!
    
    @IBInspectable var fontSize: CGFloat = 15.0
    @IBInspectable var textColor: UIColor = .black
    
    var quantity: Int {
        var result: Int?
        if quantityButton.isHidden {
            if let text = quantityTextField.text {
                result = Int(text)
            }
        } else {
            if let text = quantityButton.currentTitle {
                result = Int(text)
            }
        }
        
        if let result = result {
            return result
        }
        
        return 0
    }
    
    // Try size 45x30
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }
    
    private func addSubviews() {
        quantityButton = UIButton(type: .system)
        quantityTextField = QuantityTextField(frame: self.bounds)
        quantityTextField.actionDelegate = self
        addSubview(quantityTextField)
        addSubview(quantityButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        quantityTextField.contentMode = .scaleToFill
        quantityTextField.contentHorizontalAlignment = .center
        quantityTextField.contentVerticalAlignment = .center
        quantityTextField.borderStyle = .roundedRect
        quantityTextField.textAlignment = .center
        quantityTextField.minimumFontSize = 17
        quantityTextField.frame = self.bounds
        quantityTextField.keyboardType = .numberPad
        quantityTextField.font = UIFont(name: quantityTextField.font!.fontName, size: fontSize)
        quantityTextField.textColor = textColor
        
        quantityButton.contentMode = .scaleToFill
        quantityButton.contentHorizontalAlignment = .center
        quantityButton.contentVerticalAlignment = .center
        quantityButton.frame = self.bounds
        quantityButton.setTitleColor(textColor, for: .normal)
    }
    
    func configureQuantityView(previousQuantity: Int = 1) {
        if previousQuantity < 10 {
            quantityButton.setTitle("\(previousQuantity)", for: .normal)
        } else {
            quantityButton.isHidden = true
            
            quantityTextField.isEnabled = true
            quantityTextField.text = "\(previousQuantity)"
        }
    }
    
    func update(selectedQuantity: String) {
        if selectedQuantity == "10+" {
            quantityButton.isHidden = true
            
            quantityTextField.isEnabled = true
            quantityTextField.text = "10"
            quantityTextField.becomeFirstResponder()
        } else {
            quantityButton.setTitle(selectedQuantity, for: .normal)
            sendActions(for: .valueChanged)
        }
    }
    
    func quantityTextFieldValueChanged() {
        sendActions(for: .valueChanged)
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        quantityButton.setTitle("1", for: .normal)
    }
    
    override var forFirstBaselineLayout: UIView {
        return quantityTextField.forFirstBaselineLayout
    }
    
    override var forLastBaselineLayout: UIView {
        return quantityTextField.forLastBaselineLayout
    }
}
