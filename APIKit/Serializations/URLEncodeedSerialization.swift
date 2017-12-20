//
//  URLEncodeedSerialization.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation


private func escape(_ string: String) -> String {
    
    let generalDelimiters = ":#[]@"
    let subDelimiters = "!$&'()*+,;="
    let reservedCharacters = generalDelimiters + subDelimiters
    
    var allowedCharacterSet = CharacterSet()
    allowedCharacterSet.formUnion(.urlQueryAllowed)
    allowedCharacterSet.remove(charactersIn: reservedCharacters)
    
    let batchSize = 50
    var index = string.startIndex
    
    var escaped = ""
    
    while index != string.endIndex {
        let startIndex = index
        let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
        let range = startIndex..<endIndex
        
        let subString = String(string[range])
        
        escaped += subString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? subString
        
        index = endIndex
    }
    
    return escaped
}

private func unescape(_ string: String) -> String {
    return CFURLCreateStringByReplacingPercentEscapes(nil, string as CFString, nil) as String
}

public final class URLEncodedSerialization {
    public enum Error: Swift.Error {
        case cannotGetStringFromData(Data, String.Encoding)
        case cannotGetDataFromString(String, String.Encoding)
        case cannotCastObjectToDictionary(Any)
        case invalidFormatString(String)
    }
    
    public static func object(from data: Data, encoding: String.Encoding) throws -> [String: String] {
        guard let string = String(data: data, encoding: encoding) else {
            throw Error.cannotGetStringFromData(data, encoding)
        }
        
        var dictionary = [String: String]()
        for pair in string.components(separatedBy: "&") {
            let contents = pair.components(separatedBy: "=")
            
            guard contents.count == 2 else {
                throw Error.invalidFormatString(string)
            }
            
            dictionary[contents[0]] = unescape(contents[1])
        }
        
        return dictionary
    }
    
    public static func data(from object: Any, encoding: String.Encoding) throws -> Data {
        guard let dictionary = object as? [String: Any] else {
            throw Error.cannotCastObjectToDictionary(object)
        }
        
        let string = self.string(from: dictionary)
        guard  let data = string.data(using: encoding, allowLossyConversion: false) else {
            throw Error.cannotGetDataFromString(string, encoding)
        }
        
        return data
    }
    
    public static func string(from dictionary: [String: Any]) -> String {
        let pairs = dictionary.map { key, value -> String in
            if value is NSNull {
                return "\(escape(key))"
            }
            
            let valueAsString = (value as? String) ?? "\(value)"
            return "\(escape(key))=\(escape(valueAsString))"
        }
        
        return pairs.joined(separator: "&")
    }
}
