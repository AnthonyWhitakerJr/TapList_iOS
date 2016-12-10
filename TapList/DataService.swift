//
//  DataService.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/8/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let instance = DataService()
    static let ref = Ref()
    
    func offer(for productSku: String, completion: @escaping (_: Offer?) -> ()) {
        let offerRef = DataService.ref.offer.child(productSku)
        
        offerRef.observeSingleEvent(of: .value , with: { snapshot in
            if let offerData = snapshot.value as? Dictionary<String, Any> {
                let offer = Offer(productSku: productSku, data: offerData)
                completion(offer)
            } else {
                completion(nil)
            }
        })
    }
    
    func product(for sku: String, completion: @escaping (_: Product?) -> ()) {
        let productRef = DataService.ref.product.child(sku)
        
        productRef.observeSingleEvent(of: .value , with: { snapshot in
            if let productData = snapshot.value as? Dictionary<String, Any> {
                let product = Product(sku: sku, data: productData)
                completion(product)
            } else {
                completion(nil)
            }
        })
    }
    
    
}

struct Ref {
    let database: FIRDatabaseReference
    let offer: FIRDatabaseReference
    let product: FIRDatabaseReference
    let user: FIRDatabaseReference
    
    var cart: FIRDatabaseReference? {
        return currentUser?.child("cart")
    }
    
    var currentUser: FIRDatabaseReference? {
        let uid = FIRAuth.auth()?.currentUser?.uid
        if let uid = uid {
            return user.child(uid)
        }
        
        return nil
    }
    
    fileprivate init(){
        database = FIRDatabase.database().reference()
        offer = database.child("offer")
        product = database.child("product")
        user = database.child("user")
    }
}
