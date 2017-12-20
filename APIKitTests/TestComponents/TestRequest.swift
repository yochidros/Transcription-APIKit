//
//  TestRequest.swift
//  APIKitTests
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation
import APIKit

struct TestRequest: Request {
    let baseURL: URL
    let method: HTTPMethod
    let path: String
    let parameters: Any?
    let headerFields: [String : String]
    
    let interceptURLRequest: (URLRequest) throws -> URLRequest
    
    var absoluteURL: URL? {
        let urlRequest = try? buildURLRequest()
        return urlRequest?.url
    }
    
    typealias Response = Any
    
    init(baseURL: String = "https://example.com",
         path: String = "/",
         method: HTTPMethod = .get,
         parameters: Any? = [:],
         headerFields: [String: String] = [:],
         interceptURLRequest: @escaping (URLRequest) throws -> URLRequest = { $0 }) {
        self.baseURL = URL(string: baseURL)!
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headerFields = headerFields
        self.interceptURLRequest = interceptURLRequest
    }
    
    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        return try interceptURLRequest(urlRequest)
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        return object
    }
   
}
