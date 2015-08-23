//
//  PinyingUtil.h
//  TongChuang
//
//  Created by cuixiang on 15/8/23.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PinyingUtil : NSObject

+ (NSString *)getFirstPinyinSortingKeyOfHanziString :(NSString*) hanziString;
+ (NSString *)getPinyinSortingKeyOfHanziString:(NSString*) hanziString;
+ (NSString *)getFirstLetterOfHanziString:(NSString *)hanziString;

@end
