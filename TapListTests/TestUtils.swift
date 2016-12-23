//
//  TestUtils.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/23/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest

extension XCTestCase {
    func assertEqual<T: Hashable>(_ lhs: Dictionary<T, Any>, _ rhs: Dictionary<T, Any>) {
        XCTAssertTrue(NSDictionary(dictionary: lhs).isEqual(to: rhs), "\(lhs) is not equal to \(rhs)")
    }
    
    func assertNotEqual<T: Hashable>(_ lhs: Dictionary<T, Any>, _ rhs: Dictionary<T, Any>) {
        XCTAssertFalse(NSDictionary(dictionary: lhs).isEqual(to: rhs), "\(lhs) is equal to \(rhs)")
    }
}
