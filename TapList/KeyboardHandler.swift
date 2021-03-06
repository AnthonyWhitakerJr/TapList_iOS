//
//  KeyboardHandler.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/14/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

class KeyboardHandler {
    
    var contentView: UIView
    var scrollView: UIScrollView?
    var onlyScrollForKeyboard: Bool
    private var dismissKeyboardRecognizer: UITapGestureRecognizer?
    private var currentKeyboardHeight: CGFloat = 0
    
    init(contextView: UIView, scrollView: UIScrollView? = nil, onlyScrollForKeyboard: Bool = false) {
        self.contentView = contextView
        self.scrollView = scrollView
        self.onlyScrollForKeyboard = onlyScrollForKeyboard
    }
    
    deinit {
        stopObservingKeyboardEvents()
    }
    
    @objc func dismissKeyboard() {
        contentView.endEditing(true)
    }
    
    func startDismissingKeyboardOnTap() {
        dismissKeyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardRecognizer!.cancelsTouchesInView = false
        contentView.addGestureRecognizer(dismissKeyboardRecognizer!)
    }
    
    func stopDismissingKeyboardOnTap(){
        guard let dismissKeyboardRecognizer = dismissKeyboardRecognizer else {
            return
        }
        
        contentView.removeGestureRecognizer(dismissKeyboardRecognizer)
    }
    
    func startObservingKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func stopObservingKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        if onlyScrollForKeyboard {
            scrollView?.isScrollEnabled = true
        }
        
        moveScrollViewUpForKeyboard(notification: notification)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        moveScrollViewDownAfterHidingKeyboard(notification: notification)
        
        if onlyScrollForKeyboard {
            scrollView?.isScrollEnabled = false
        }
    }
    
    func moveScrollViewUpForKeyboard(notification:NSNotification) {
        guard let scrollView = scrollView else {
            return
        }
        
        // Give room at bottom of scroll view so it doesn't cover anything the user needs to tap.
        var userInfo = notification.userInfo!
        var keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = contentView.convert(keyboardFrame, from: nil)
        
        let scrollPoint = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + keyboardFrame.size.height - currentKeyboardHeight)
        scrollView.setContentOffset(scrollPoint, animated: true)
        currentKeyboardHeight = keyboardFrame.size.height
    }
    
    func moveScrollViewDownAfterHidingKeyboard(notification:NSNotification) {
        guard let scrollView = scrollView else {
            return
        }
        
        var userInfo = notification.userInfo!
        var keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = contentView.convert(keyboardFrame, from: nil)
        
        let scrollPoint = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y - keyboardFrame.size.height)
        scrollView.setContentOffset(scrollPoint, animated: true)
        currentKeyboardHeight = 0
    }
}
