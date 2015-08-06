//
//  NSDictionary+JsonSafe.m
//  TongChuang
//
//  Created by cuixiang on 15/7/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "NSDictionary+JsonSafe.h"

@implementation NSDictionary (JsonSafe)

- (NSString *)stringSafeGet:(id)aKey
{
    id tmp = [self objectForKey:aKey];
    if (![tmp isKindOfClass:[NSString class]] || [tmp isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return tmp;
}

- (NSArray *)arraySafeGet:(id)aKey
{
    id tmp = [self objectForKey:aKey];
    if (![tmp isKindOfClass:[NSArray class]] || [tmp isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return tmp;
}

- (NSDictionary *)dictionarySafeGet:(id)aKey
{
    id tmp = [self objectForKey:aKey];
    if (![tmp isKindOfClass:[NSDictionary class]] || [tmp isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return tmp;
}

- (NSNumber *)numberSafeGet:(id)aKey
{
    id tmp = [self objectForKey:aKey];
    if (!tmp || ![tmp isKindOfClass:[NSNumber class]] || [tmp isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return tmp;
}

- (NSInteger)integerSafeGet:(id)aKey
{
    id tmp = [self objectForKey:aKey];
    if (!tmp || ![tmp isKindOfClass:[NSNumber class]] || [tmp isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [tmp integerValue];
}

- (float)floatSafeGet:(id)aKey
{
    id tmp = [self objectForKey:aKey];
    if (!tmp || ![tmp isKindOfClass:[NSNumber class]] || [tmp isKindOfClass:[NSNull class]]) {
        return 0.0f;
    }
    return [tmp floatValue];
}

- (uint64_t)ulonglongSafeGet:(id)aKey
{
    id tmp = [self objectForKey:aKey];
    if (!tmp || ![tmp isKindOfClass:[NSNumber class]] || [tmp isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [tmp unsignedLongLongValue];
}

@end
