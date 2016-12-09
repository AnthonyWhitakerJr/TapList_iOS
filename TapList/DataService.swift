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
    
    let database = FIRDatabase.database().reference()
    private(set) var product : FIRDatabaseReference
    
    private init(){
        product = database.child("product")
    }
}
