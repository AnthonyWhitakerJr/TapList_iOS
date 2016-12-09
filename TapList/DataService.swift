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
    let product: FIRDatabaseReference
    
    private init(){
        database = FIRDatabase.database().reference()
        product = database.child("product")
    }
}
