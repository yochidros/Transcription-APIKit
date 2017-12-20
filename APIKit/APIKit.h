//
//  APIKit.h
//  APIKit
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for APIKit.
FOUNDATION_EXPORT double APIKitVersionNumber;

//! Project version string for APIKit.
FOUNDATION_EXPORT const unsigned char APIKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <APIKit/PublicHeader.h>
@interface AbstractInputStream : NSInputStream

- (instancetype)init;

@end
