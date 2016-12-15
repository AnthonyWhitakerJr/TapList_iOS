//
//  QuantityViewDelegate.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/14/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

protocol QuantityViewDataSource: QuantityTableViewControllerDelegate {
    weak var quantityButton: UIButton! {get set}
    weak var quantityTextField: QuantityTextField! {get set}
    var quantity: Int {get}
    
    func configureQuantityView(previousQuantity: Int)
}

extension QuantityViewDataSource {
    
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
    
    func configureQuantityView(previousQuantity: Int = 1) {
        quantityTextField.delegate = quantityTextField
        
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
        }
    }
    
}
