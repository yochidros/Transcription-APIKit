//
//  JSONDataParser.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

public class JSONDataParser: DataParser {
    public let readingOptions: JSONSerialization.ReadingOptions
    
    public init(readingOptions: JSONSerialization.ReadingOptions) {
        self.readingOptions = readingOptions
    }
    
    public var contentType: String? {
        return "application/json"
    }
    
    public func parse(data: Data) throws -> Any {
        guard data.count > 0 else { return [:] }
        
        return try JSONSerialization.jsonObject(with: data, options: readingOptions)
    }
}
