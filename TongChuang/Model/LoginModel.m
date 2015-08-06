//
//  LoginModel.m
//  TongChuang
//
//  Created by cuixiang on 15/7/27.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "LoginModel.h"
#import "SettingModel.h"

NSString * const kLoginNotification = @"kLoginNotification";
NSString * const kLoginResult = @"kLoginResult";
NSString * const kLoginErrCode = @"kLoginErrCode";

NSString * const kLogoutNotification = @"kLogoutNotification";

@implementation LoginModel

- (id)init {
    if (self = [super init]) {
        [self initAccount];
    }
    
    return self;
}

- (void)login:(NSString *)phone password:(NSString *)password {
    NSLog(@"login request - phone: %@, password: %@", phone, password);
    
    //TODO: login request
    BOOL loginResult = YES;
    if (loginResult) {
        _isLogined = YES;
        _account = phone;
        _uid = 1000;
        
        [self saveAccount];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotification object:nil userInfo:@{kLoginResult : @(LoginSuccess), kLoginErrCode : @(0)}];
}

- (void)logout {
    NSLog(@"logout request");
    
    _isLogined = NO;
    _account = nil;
    _uid = 0;
    
    [self removeAccount];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutNotification object:[NSString stringWithFormat:@"%lu", (unsigned long)_uid]];
}

- (void)initAccount {
    _isLogined = NO;
    
    SettingModel *settingModel = [SettingModel sharedInstance];
    NSInteger uid = [settingModel integerForKey:kUidKey];
    if (uid != 0) {
        _isLogined = YES;
        _uid = uid;
        _account = [settingModel objectForKey:kAccountKey];
    }
}

- (void)saveAccount {
    SettingModel *settingModel = [SettingModel sharedInstance];
    [settingModel setObject:_account forKey:kAccountKey];
    [settingModel setInteger:_uid forKey:kUidKey];
    
    [settingModel synchronize];
}

- (void)removeAccount {
    SettingModel *settingModel = [SettingModel sharedInstance];
    [settingModel setInteger:_uid forKey:kUidKey];
    
    [settingModel synchronize];
}

@end
