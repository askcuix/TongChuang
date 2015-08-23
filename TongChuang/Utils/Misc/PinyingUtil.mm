//
//  PinyingUtil.m
//  TongChuang
//
//  Created by cuixiang on 15/8/23.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "PinyingUtil.h"
#import "base.h"
#import "PinyinTable.h"

@implementation PinyingUtil

+ (NSString *)getPinyinSortingKeyOfHanziString:(NSString*) hanziString {
    if (hanziString == nil) {
        return nil;
    }
    
    int hanziString_len = (int)[hanziString length];
    
    NSMutableString* sortKey1 = [NSMutableString stringWithString:@""];
    
    for (int i = 0; i < hanziString_len; ++i) {
        const WCHAR hanzi = [hanziString characterAtIndex:i];
        LPCSTR pinyin = CPinyinTable::getFirstPinyinOf(hanzi);
        
        if (pinyin != NULL) {
            [sortKey1 appendFormat:@"%s_%c`",pinyin,hanzi];
        } else {
            [sortKey1 appendFormat:@" %c`",hanzi];
        }
    }
    
    
    return sortKey1;
}

+ (NSString *) getFirstPinyinSortingKeyOfHanziString :(NSString*) hanziString {
    //example: "王a二小b" ==> "wang_王` a`er_二`xiao_小` b`"
    int hanziString_len = (int)[hanziString length];
    
    
    NSString* sortKey = @"";
    
    if(hanziString_len > 0) {
        const WCHAR hanzi = [hanziString characterAtIndex:0];
        LPCSTR pinyin = CPinyinTable::getFirstPinyinOf(hanzi);
        
        if (pinyin != NULL) {
            NSString* toappend = [NSString stringWithFormat:@"%s",pinyin];
            sortKey = [sortKey stringByAppendingString:toappend];
            sortKey = [sortKey stringByAppendingString:@"_"];
            toappend = [NSString stringWithFormat:@"%c",hanzi];
            sortKey = [sortKey stringByAppendingString:toappend];
        } else {
            sortKey = [sortKey stringByAppendingString:@" "];
            NSString* toappend = [NSString stringWithFormat:@"%c",hanzi];
            sortKey = [sortKey stringByAppendingString:toappend];
        }
        
        sortKey = [sortKey stringByAppendingString:@"`"];
    }
    
    return sortKey;
}

+ (NSString *)getFirstLetterOfHanziString:(NSString *)hanziString {
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < hanziString.length; ++i) {
        const WCHAR hanzi = [hanziString characterAtIndex:i];
        LPCSTR pinyin = CPinyinTable::getFirstPinyinOf(hanzi);
        if (pinyin) {
            [result appendFormat:@"%c", pinyin[0]];
        } else {
            [result appendFormat:@"%c", hanzi];
        }
    }
    return result;
}

@end
