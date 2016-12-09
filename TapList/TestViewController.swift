//
//  TestViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/7/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: PlaceholderTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }

    func textViewDidChange(_ textView: UITextView) {
        if let textView = textView as? PlaceholderTextView {
            textView.placeholder.isHidden = !textView.text.isEmpty
        }
    }
}
