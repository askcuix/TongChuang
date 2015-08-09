//
//  AppModel.m
//  TongChuang
//
//  Created by cuixiang on 15/7/27.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

+ (AppModel *)sharedInstance {
    static AppModel *appModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appModel = [[AppModel alloc] init];
    });
    
    return appModel;
}

- (void)initModel {
    
    _fileModel = [[FileModel alloc] init];
    _loginModel = [[LoginModel alloc] init];
    _userModel = [[UserModel alloc] init];
    
}

- (void)destroyModel {
    
}

@end
