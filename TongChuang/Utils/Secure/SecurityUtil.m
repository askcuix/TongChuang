//
//  SecurityUtil.m
//  TongChuang
//
//  Created by cuixiang on 15/7/8.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "SecurityUtil.h"
#import <CommonCrypto/CommonCrypto.h>

#define TWICE(length) (length * 2)

@implementation SecurityUtil

+ (NSString *)md5HexString:(NSString *)rawString {
    NSData * rawData = [rawString dataUsingEncoding:NSUTF8StringEncoding];
    NSData * md5Data = [MD5Util md5Data:rawData];
    return [SecurityUtil hexString:md5Data];
}

+ (NSString *)sha1HexString:(NSString *)rawString {
    NSData * rawData  = [rawString dataUsingEncoding:NSUTF8StringEncoding];
    NSData * sha1Data = [SHAUtil sha1Data:rawData];
    return [SecurityUtil hexString:sha1Data];
}

+ (NSString *)sha256HexString:(NSString *)rawString {
    NSData * rawData    = [rawString dataUsingEncoding:NSUTF8StringEncoding];
    NSData * sha256Data = [SHAUtil sha256Data:rawData];
    return [SecurityUtil hexString:sha256Data];
}

#pragma mark - hex string util

+ (NSString *)hexString:(NSData *)rawData {
    NSUInteger length = rawData.length;
    const unsigned char * rawContent = rawData.bytes;
    
    NSMutableString * hexString = [NSMutableString stringWithCapacity:TWICE(length)];
    
    for (NSUInteger i = 0; i < length; i++) {
        [hexString appendFormat:@"%02x", rawContent[i]];
    }
    return hexString;
}

@end

#pragma mark - md5 util

@implementation MD5Util

+ (NSData *)md5Data:(NSData *)rawData {
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5(rawData.bytes, (CC_LONG)rawData.length, md5);
    return [NSData dataWithBytes:md5 length:CC_MD5_DIGEST_LENGTH];
}

@end

#pragma mark - sha1 util

@implementation SHAUtil

+ (NSData *)sha1Data:(NSData *)rawData {
    unsigned char sha1[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(rawData.bytes, (CC_LONG)rawData.length, sha1);
    return [NSData dataWithBytes:sha1 length:CC_SHA1_DIGEST_LENGTH];
}

+ (NSData *)sha256Data:(NSData *)rawData {
    unsigned char sha256[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(rawData.bytes, (CC_LONG)rawData.length, sha256);
    return [NSData dataWithBytes:sha256 length:CC_SHA256_DIGEST_LENGTH];
}

@end
