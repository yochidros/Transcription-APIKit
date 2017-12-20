//
//  JSONBodyParameters.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

public struct JSONBodyParameters: BodyParameters {
    public let JSONObject: Any
    
    public let writingOptions: JSONSerialization.WritingOptions
    
    public init(JSONObject: Any, writingOptions: JSONSerialization.WritingOptions = []) {
        self.JSONObject = JSONObject
        self.writingOptions = writingOptions
    }
    
    public var contentType: String {
        return "application/json"
    }
    
    public func buildEntity() throws -> ResponseBodyEntity {
        guard JSONSerialization.isValidJSONObject(JSONObject) else {
            throw NSError(domain: NSCocoaErrorDomain, code: 3840, userInfo: nil)
        }
        
        return .data(try JSONSerialization.data(withJSONObject: JSONObject, options: writingOptions))
    }
    
}
