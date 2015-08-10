//
//  ChatPushManager.h
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

static NSString *const kAVIMInstallationKeyUserId = @"userId";

@interface ChatPushManager : NSObject

+ (ChatPushManager *)manager;

// please call in application:didFinishLaunchingWithOptions:launchOptions
- (void)registerForRemoteNotification;

// please call in application:didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
- (void)saveInstallationWithDeviceToken:(NSData *)deviceToken;

// push message
- (void)pushMessage:(NSString *)message userIds:(NSArray *)userIds block:(AVBooleanResultBlock)block;

// please call in applicationDidBecomeActive:application
- (void)cleanBadge;

//save the local applicationIconBadgeNumber to the server
- (void)syncBadge;

@end
