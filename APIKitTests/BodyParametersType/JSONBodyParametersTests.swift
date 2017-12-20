//
//  JSONBodyParametersTests.swift
//  APIKitTests
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation
import XCTest
import APIKit

class JSONBodyParametersTests: XCTest {
    
    func testJSONSuccess() {
        let object = ["foo": 1, "bar": 2, "baz": 34]
        let paramters = JSONBodyParameters(JSONObject: object)
        XCTAssertEqual(paramters.contentType, "application/json")
        
        do {
            guard case .data(let data) = try paramters.buildEntity() else {
                XCTFail()
                return
            }
            
            let dictionary = try JSONSerialization.jsonObject(with: data, options: [])
            print(dictionary)
            XCTAssertEqual((dictionary as? [String: Int])?["foo"], 1)
            XCTAssertEqual((dictionary as? [String: Int])?["bar"], 2)
            XCTAssertEqual((dictionary as? [String: Int])?["baz"], 34)
        } catch {
            XCTFail()
        }
    }
}
