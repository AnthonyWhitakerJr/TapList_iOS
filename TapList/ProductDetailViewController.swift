//
//  ProductDetailViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/9/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var specialInstructionTextView: PlaceholderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        specialInstructionTextView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProductDetailViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if let textView = textView as? PlaceholderTextView {
            textView.placeholder.isHidden = !textView.text.isEmpty
        }
    }
}
