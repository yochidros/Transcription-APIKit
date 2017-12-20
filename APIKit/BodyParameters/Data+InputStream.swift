//
//  Data+InputStream.swift
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import Foundation

enum InputStreamError: Error {
    case invalidDataCapacity(Int)
    case unreadableStream(InputStream)
}

extension Data {
    init(inputStream: InputStream, capacity: Int = Int(UInt16.max)) throws {
        var data = Data(capacity: capacity)
        
        // capacityがUInt16.max(65,535)より大きい場合65,535にする
        let bufferSize = Swift.min(Int(UInt16.max), capacity)
        // メモリ割り当て
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        
        var readSize: Int
        
        repeat {
          // 割り当てたアドレスにbufferSize分読み込む返り値は読み込んだサイズ分
            // 読み込めなかったら-1
            readSize = inputStream.read(buffer, maxLength: bufferSize)
            
            switch readSize {
            case let x where x > 0:
                data.append(buffer, count: bufferSize)
                
            case let x where x < 0:
                throw InputStreamError.unreadableStream(inputStream)
            
            default:
                break
            }
        } while readSize > 0
        
        // メモリ解放
        buffer.deallocate(capacity: bufferSize)
        
        self.init(data)
    }
}
