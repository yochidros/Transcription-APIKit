//
//  ProtobufBodyParameters.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

public struct ProtobufBodyParameters: BodyParameters {
    public let protobufObject: Data
    
    public init(protobufObject: Data) {
        self.protobufObject = protobufObject
    }
    
    public var contentType: String {
        return "application/protobuf"
    }
    
    public func buildEntity() throws -> ResponseBodyEntity {
        return .data(protobufObject)
    }
}
