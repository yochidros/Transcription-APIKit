//
//  SessionTaskError.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

public enum SessionTaskError: Error {
    case connectionError(Error)
    
    case requestError(Error)
    
    case responseError(Error)
}
