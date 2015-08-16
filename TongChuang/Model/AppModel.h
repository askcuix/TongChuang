//
//  AppModel.h
//  TongChuang
//
//  Created by cuixiang on 15/7/27.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileModel.h"
#import "LoginModel.h"
#import "UserModel.h"
#import "CircleModel.h"

@interface AppModel : NSObject

+ (AppModel *)sharedInstance;

@property (nonatomic, readonly, strong) FileModel *fileModel;
@property (nonatomic, readonly, strong) LoginModel *loginModel;
@property (nonatomic, readonly, strong) UserModel *userModel;
@property (nonatomic, readonly, strong) CircleModel *circleModel;

- (void)initModel;
- (void)destroyModel;

@end
