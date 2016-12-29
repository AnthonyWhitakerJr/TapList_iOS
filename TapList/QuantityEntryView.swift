//
//  QuantityEntryView.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/19/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

@IBDesignable
class QuantityEntryView: UIControl {

    var quantityButton: UIButton!
    var quantityTextField: QuantityTextField!
    var delegate: QuantityEntryViewDelegate?
    
    @IBInspectable var fontSize: CGFloat = 15.0
    @IBInspectable var textColor: UIColor = .black
    
    override var forFirstBaselineLayout: UIView {
        return quantityTextField.forFirstBaselineLayout
    }
    
    override var forLastBaselineLayout: UIView {
        return quantityTextField.forLastBaselineLayout
    }
    
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
        backgroundColor = .clear
        quantityButton = UIButton(type: .system)
        quantityTextField = QuantityTextField()
        quantityTextField.actionDelegate = self
        
        addSubview(quantityTextField)
        addSubview(quantityButton)
        
        quantityButton.addTarget(self, action: #selector(quantityButtonPressed(_:)), for: .touchUpInside)
        quantityTextField.isEnabled = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        quantityTextField.contentMode = .scaleToFill
        quantityTextField.contentHorizontalAlignment = .center
        quantityTextField.contentVerticalAlignment = .center
        quantityTextField.borderStyle = .roundedRect
        quantityTextField.textAlignment = .center
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
    
    func quantityButtonPressed(_ sender: UIButton) {
        delegate?.segueToQuantityPopover(sender)
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        quantityButton.setTitle("1", for: .normal)
    }
}

extension QuantityEntryView: QuantityTableViewControllerDelegate {
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
}

extension QuantityEntryView: QuantityTextFieldActionDelegate {
    func quantityTextFieldValueChanged() {
        sendActions(for: .valueChanged)
    }
}

protocol QuantityEntryViewDelegate {
    func segueToQuantityPopover(_ : UIButton)
}
