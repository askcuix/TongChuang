//
//  ValidateUtil.m
//  TongChuang
//
//  Created by cuixiang on 15/7/29.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ValidateUtil.h"

@implementation ValidateUtil

+ (BOOL)validatePhoneNum:(NSString *)phoneNum {
    if (phoneNum.length == 0) {
        return NO;
    }
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    BOOL result = [regextestmobile evaluateWithObject:phoneNum];
    return result;
}

@end
