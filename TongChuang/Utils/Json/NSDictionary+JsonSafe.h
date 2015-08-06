//
//  NSDictionary+JsonSafe.h
//  TongChuang
//
//  Created by cuixiang on 15/7/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JsonSafe)

- (NSString *)stringSafeGet:(id)aKey;
- (NSArray *)arraySafeGet:(id)aKey;
- (NSDictionary *)dictionarySafeGet:(id)aKey;
- (NSNumber *)numberSafeGet:(id)aKey;
- (NSInteger)integerSafeGet:(id)aKey;
- (float)floatSafeGet:(id)aKey;
- (uint64_t)ulonglongSafeGet:(id)aKey;

@end

