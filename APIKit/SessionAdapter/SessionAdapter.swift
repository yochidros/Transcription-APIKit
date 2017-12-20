//
//  SessionAdapter.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

public protocol SessionTask: class {
    func resume()
    func cancel()
}

public protocol SessionAdapter {
    
    func createTask(with URLRequest: URLRequest, handler: @escaping (Data?, URLResponse?, Error?) -> Void) -> SessionTask

    func getTasks(with handler: @escaping ([SessionTask]) -> Void) 
}
