//
//  ChatUserModel.h
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  聊天的 User Model
 */
@interface ChatUserModel : NSObject

/**
 *  用户的 id，如果你的用户系统是数字，则可转换成字符串 "123"
 */
@property (nonatomic, strong) NSString *userId;

/**
 *  头像的 url，则最近对话页面和聊天页面使用，会结合缓存来用
 */
@property (nonatomic, strong) NSString *avatarUrl;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *username;

@end
