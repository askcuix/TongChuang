//
//  JsonUtil.m
//  TongChuang
//
//  Created by cuixiang on 15/7/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "JsonUtil.h"
#import "GTMNSString+URLArguments.h"

@implementation JsonUtil

+ (NSData *)toJsonData:(id)jsonObject
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil) {
        return jsonData;
    } else {
        return nil;
    }
}

+ (NSString *)toJsonString:(id)jsonObject
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:&error];
    if ([jsonData length] > 0 && error == nil) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

+ (NSString *)toJsonUrlString:(id)jsonObject
{
    return [[self toJsonString:jsonObject] gtm_stringByEscapingForURLArgument];
}

+ (NSString *)toDecodeUrlString:(NSString *)jsonString{
    return [jsonString gtm_stringByUnescapingFromURLArgument];
}


@end
