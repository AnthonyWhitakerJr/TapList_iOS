//
//  RoundedButton.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

/// A `UIButton` that allows corner radius to be defined and viewed in Interface Builder.
@IBDesignable
class RoundedButton: UIButton {

    /// The radius to use when drawing rounded corners for the layer’s background.
    ///
    /// Setting the radius to a value greater than 0.0 causes the layer to begin drawing rounded corners on its background
    /// and content to be clipped to the rounded corners.
    ///
    /// The default value of this property is 0.0.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}
