//
//  StringDataParser.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

// String 仕様
public class StringDataParser: DataParser {
    public enum Error: Swift.Error {
        case invalidData(Data)
    }
    
    public let encoding: String.Encoding
    
    public init(encoding: String.Encoding = .utf8) {
        self.encoding = encoding
    }
    
    public var contentType: String? {
        return nil
    }
    
    public func parse(data: Data) throws -> Any {
        guard let string = String(data: data, encoding: encoding) else {
            throw Error.invalidData(data)
        }
        
        return string
    }
}
