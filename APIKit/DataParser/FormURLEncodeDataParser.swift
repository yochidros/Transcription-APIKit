//
//  FormURLEncodeDataParser.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

public class FormURLEncodeDataParser: DataParser {
    public enum Error: Swift.Error {
        case cannotGetStringFromData(Data)
    }
    
    public let encoding: String.Encoding
    
    public init(encoding: String.Encoding) {
        self.encoding = encoding
    }
    
    public var contentType: String? {
        return "application/x-www.form-urlencoded"
    }
    
    public func parse(data: Data) throws -> Any {
        guard let string = String(data: data, encoding: encoding) else {
            throw Error.cannotGetStringFromData(data)
        }
        
        var components = URLComponents()
        components.percentEncodedQuery = string
        
        let queryItems = components.queryItems ?? []
        var dictionary = [String: Any]()
        
        queryItems.forEach{ dictionary[$0.name] = $0.value }
        
        return dictionary
    }
}
