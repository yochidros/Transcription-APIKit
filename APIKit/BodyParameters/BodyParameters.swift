//
//  BodyParameters.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

public enum ResponseBodyEntity {
    case data(Data)
    
    case inputStream(InputStream)
}

public protocol BodyParameters {
    var contentType: String { get }
    
    func buildEntity() throws -> ResponseBodyEntity
}
