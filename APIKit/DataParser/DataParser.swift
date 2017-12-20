//
//  DataParser.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

// 受け取ったデータをパースする約束事
public protocol DataParser {
    var contentType: String? { get }
    
    func parse(data: Data) throws -> Any
}
