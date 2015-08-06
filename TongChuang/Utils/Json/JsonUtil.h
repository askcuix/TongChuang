//
//  JsonUtil.h
//  TongChuang
//
//  Created by cuixiang on 15/7/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonUtil : NSObject

+ (NSData *)toJsonData:(id)jsonObject;
+ (NSString *)toJsonString:(id)jsonObject;
+ (NSString *)toJsonUrlString:(id)jsonObject;
+ (NSString *)toDecodeUrlString:(NSString *)jsonString;

@end
