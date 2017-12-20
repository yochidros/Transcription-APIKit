//
//  Session.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation
import Result

private var taskRequestKey = 0

open class Session {
    public let adapter: SessionAdapter
    
    public let callbackQueue: CallbackQueue
    
    public init(adapter: SessionAdapter, callbackQueue: CallbackQueue = .main) {
        self.adapter = adapter
        self.callbackQueue = callbackQueue
    }
    
    private static let privateShared: Session = {
        let configuration = URLSessionConfiguration.default
        let adapter = URLSessionAdapter(configuration: configuration)
        return Session(adapter: adapter)
    }()
    
    open class var shared: Session {
        return privateShared
    }
    
    @discardableResult
    open class func send<Request: APIKit.Request>(
        _ request: Request,
        callbackQueue: CallbackQueue? = nil,
        handler: @escaping (Result<Request.Response, SessionTaskError>) -> Void = { _ in }) -> SessionTask? {
        return shared.send(request, callbackQueue: callbackQueue, handler: handler)
    }
    
    open class func cancelRequests<Request: APIKit.Request>(with requestType: Request.Type, passingTest test: @escaping (Request) -> Bool = { _ in true }) {
        shared.cancelRequests(with: requestType, passingTest: test)
    }
    
    @discardableResult
    open func send<Request: APIKit.Request>(_ request: Request, callbackQueue: CallbackQueue? = nil, handler: @escaping (Result<Request.Response, SessionTaskError>) -> Void = { _ in }) -> SessionTask? {
            let callbackQueue = callbackQueue ?? self.callbackQueue
       
        let urlRequest: URLRequest
        do {
            urlRequest = try request.buildURLRequest()
        } catch {
            callbackQueue.execute {
                handler(.failure(.requestError(error)))
            }
            return nil
        }
        
        let task = adapter.createTask(with: urlRequest) { data, urlResponse, error in
            let result: Result<Request.Response, SessionTaskError>
            
            switch (data, urlResponse, error) {
            case (_, _, let error?):
                result = .failure(.connectionError(error))
            case (let data?, let urlResponse as HTTPURLResponse, _):
                do {
                    result = .success(try request.parse(data: data as Data, urlResponse: urlResponse))
                } catch {
                    result = .failure(.responseError(error))
                }
            default:
                result = .failure(.responseError(ResponseError.nonHTTPURLResponse(urlResponse)))
            }
            
            callbackQueue.execute {
                handler(result)
            }
        }
        
        setRequest(request, forTask: task)
        task.resume()
        
        
        return task
    }
    
    open func cancelRequests<Request: APIKit.Request>(with requestType: Request.Type, passingTest test: @escaping (Request) -> Bool = { _ in true }) {
        adapter.getTasks { [weak self] tasks in
            return tasks
                .filter { task in
                    if let request = self?.requestForTask(task) as Request? {
                        return test(request)
                    } else {
                        return false
                    }
                }
                .forEach { $0.cancel() }
            
        }
    }
    
    private func setRequest<Request: APIKit.Request>(_ request: Request, forTask task: SessionTask) {
        objc_setAssociatedObject(task, &taskRequestKey, request, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private func requestForTask<Request: APIKit.Request>(_ task: SessionTask) -> Request? {
        return objc_getAssociatedObject(task, &taskRequestKey) as? Request
    }
}
