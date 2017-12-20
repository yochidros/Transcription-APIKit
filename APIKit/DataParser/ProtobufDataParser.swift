//
//  ProtobufDataParser.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

public class ProtobufDataParser: DataParser {
    public init() {}
    
    public var contentType: String? {
        return "application/protobuf"
    }
    
    public func parse(data: Data) throws -> Any {
        return data
    }
}
