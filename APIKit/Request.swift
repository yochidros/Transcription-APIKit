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
    
    var bodyParameters: BodyParameters? { get }
    
    var headerFields: [String: String] { get }
    
    var dataParser: DataParser { get }
    
    func intercept(urlRequest: URLRequest) throws -> URLRequest
    
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response
}

extension Request {
    public var parameters: Any? {
        return nil
    }
    
    public var queryParameters: [String: Any]? {
        guard let parameters = parameters as? [String: Any], method.prefersQueryParameters else {
            return nil
        }
        
        return parameters
    }
    
    public var bodyParameters: BodyParameters? {
        guard let parameters = parameters, !method.prefersQueryParameters else {
            return nil
        }
        
        return JSONBodyParameters(JSONObject: parameters)
    }
    
    public var headerFields: [String: String] {
        return [:]
    }
    
    public var dataParser: DataParser {
        return JSONDataParser(readingOptions: [])
    }
    
    public func intercept(urlRequest: URLRequest) throws -> URLRequest {
        return urlRequest
    }
    
    public func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard 200..<300 ~= urlResponse.statusCode else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        
        return object
    }
    
    public func buildURLRequest() throws -> URLRequest {
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw RequestError.invalidBaseURL(url)
        }
        
        var urlRequest = URLRequest(url: url)
        
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            components.percentEncodedQuery = URLEncodedSerialization.string(from: queryParameters)
        }
        
        if let bodyParameters = bodyParameters {
            urlRequest.setValue(bodyParameters.contentType, forHTTPHeaderField: "Content-Type")
            
            switch try bodyParameters.buildEntity(){
            case .data(let data):
                urlRequest.httpBody = data
            case .inputStream(let inputStream):
                urlRequest.httpBodyStream = inputStream
            }
        }
        
        urlRequest.url = components.url
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(dataParser.contentType, forHTTPHeaderField: "Accept")
        
        headerFields.forEach{ key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return (try intercept(urlRequest: urlRequest) as URLRequest)
    }
    
    public func parse(data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        let parsedObject = try dataParser.parse(data: data)
        let passedObject = try intercept(object: parsedObject, urlResponse: urlResponse)
        return try response(from: passedObject, urlResponse: urlResponse)
    }
    
}
