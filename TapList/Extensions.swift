//
//  Extensions.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/27/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    /// - returns: Style of this font matching the given traits if it is available;
    /// otherwise returns `nil`.
    open func with(traits:UIFontDescriptorSymbolicTraits...) -> UIFont? {
        if let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits)) {
            return UIFont(descriptor: descriptor, size: 0)
        }
        return nil
    }
    
    /// - returns: Italic style of this font if it is available;
    /// otherwise returns `nil`.
    open func italic() -> UIFont? {
        return with(traits: .traitItalic)
    }
    
}
