//
//  DataService.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/8/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataService {
    
    static let instance = DataService()
    
    let database: FIRDatabaseReference
    let offer: FIRDatabaseReference
    let product: FIRDatabaseReference
    
    private init(){
        database = FIRDatabase.database().reference()
        offer = database.child("offer")
        product = database.child("product")
    }
    
    func offer(for productSku: String, completion: @escaping (_: Offer?) -> ()) {
        let offerRef = offer.child(productSku)
        
        offerRef.observeSingleEvent(of: .value , with: { snapshot in
            if let offerData = snapshot.value as? Dictionary<String, Any> {
                let offer = Offer(productSku: productSku, data: offerData)
                completion(offer)
            } else {
                completion(nil)
            }
        })
    }
}
