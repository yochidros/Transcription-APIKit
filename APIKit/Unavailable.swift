//
//  Unavailable.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Result

@available(*, unavailable, renamed: "Request")
public typealias RequestType = Request

@available(*, unavailable, renamed: "SessionAdapter")
public typealias SessionAdapterType = SessionAdapter

@available(*, unavailable, renamed: "SessionTask")
public typealias SessionTaskType = SessionTask

@available(*, unavailable, renamed: "BodyParameters")
public typealias BodyParametersType = BodyParameters

@available(*, unavailable, renamed: "DataParser")
public typealias DataParserType = DataParser

extension Session {
    @available(*, unavailable, renamed: "shared")
    public class var sharedSession: Session {
        fatalError("\(#function) is no longer available")
    }
    
    @available(*, unavailable, renamed: "send(_:callbackQueue:handler:)")
    public class func sendRequest<Request: APIKit.Request>(_ request: Request, callbackQueue: CallbackQueue? = nil, handler: @escaping (Result<Request.Response, SessionTaskError>) -> Void = { _ in }) -> SessionTask? {
        fatalError("\(#function) is no longer available")
    }
    
    
}
