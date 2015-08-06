//
//  DES3Util.h
//  TongChuang
//
//  Created by cuixiang on 15/7/8.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText key:(NSString *)key;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText key:(NSString *)key;

@end
