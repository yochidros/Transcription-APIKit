//
//  Request.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation
import Result

public protocol Request {
    associatedtype Response
    
    var baseURL: URL { get }
    
    var method: HTTPMethod { get }
    
    var path: String { get }
    
    var parameters: Any? { get }
    
    var queryParameters: [String: Any]? { get }
    
    
}
