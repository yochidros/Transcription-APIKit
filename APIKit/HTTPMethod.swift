//
//  HTTPMethod.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
    case put  = "PUT"
    case head = "HEAD"
    case delete = "DELETE"
    case patch = "PATCH"
    case trace = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
    
    public var prefersQueryParameters: Bool {
        switch self {
        case .get, .head, .delete:
            return true
        default:
            return false
        }
    }
}
