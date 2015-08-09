//
//  LoginModel.h
//  TongChuang
//
//  Created by cuixiang on 15/7/27.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kLoginNotification;
extern NSString * const kLoginResult;
extern NSString * const kLoginErrCode;
extern NSString * const kLogoutNotification;

typedef NS_ENUM(NSUInteger, LoginResultCode) {
    LoginSuccess,
    LoginFail,
};

@interface LoginModel : NSObject

@property (nonatomic, readonly, strong) NSString *account;
@property (nonatomic, readonly, assign) NSUInteger uid;
@property (nonatomic, readonly, strong) NSString *avatar;
@property (nonatomic, readonly, assign) BOOL isLogined;

- (void)login:(NSString *)phone password:(NSString *)password;
- (void)logout;

@end
