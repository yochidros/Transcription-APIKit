//
//  CallbackQueue.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

// コールバック処理
public enum CallbackQueue {
    case main
    
    case sessionQueue
    
    case operationQueue(OperationQueue)
    
    case dispatchQueue(DispatchQueue)
    
    public func execute(closure: @escaping () -> Void) {
        switch self {
        case .main:
            DispatchQueue.main.async {
                closure()
            }
        case .sessionQueue:
            closure()
        case .operationQueue(let operationQueue):
            operationQueue.addOperation {
                closure()
            }
        case .dispatchQueue(let dispatchQueue):
            dispatchQueue.async {
                closure()
            }
        }
    }
}
