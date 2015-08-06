//
//  SecurityUtil.h
//  TongChuang
//
//  Created by cuixiang on 15/7/8.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject

+ (NSString *)md5HexString:(NSString *)rawString;

+ (NSString *)sha1HexString:(NSString *)rawString;

+ (NSString *)sha256HexString:(NSString *)rawString;

+ (NSString *)hexString:(NSData *)rawData;

@end

#pragma mark - md5 util

@interface MD5Util : NSObject

+ (NSData *)md5Data:(NSData *)rawData;

@end

#pragma mark - sha1 util

@interface SHAUtil : NSObject

+ (NSData *)sha1Data:(NSData *)rawData;

+ (NSData *)sha256Data:(NSData *)rawData;

@end
