//
//  ChatPushManager.m
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ChatPushManager.h"
#import "AppModel.h"

@implementation ChatPushManager

+ (ChatPushManager *)manager {
    static ChatPushManager *pushManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pushManager = [[ChatPushManager alloc] init];
    });
    return pushManager;
}

- (void)registerForRemoteNotification {
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert |
                             UIUserNotificationTypeBadge |
                             UIUserNotificationTypeSound
            categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
}

- (void)saveInstallationWithDeviceToken:(NSData *)deviceToken {
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[[AppModel sharedInstance].loginModel uid]] forKey:kAVIMInstallationKeyUserId];
    [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)pushMessage:(NSString *)message userIds:(NSArray *)userIds block:(AVBooleanResultBlock)block {
    AVQuery *query = [AVInstallation query];
    [query whereKey:kAVIMInstallationKeyUserId containedIn:userIds];
    AVPush *push = [[AVPush alloc] init];
    [push setQuery:query];
    [push setMessage:message];
    [push sendPushInBackgroundWithBlock:block];
}

- (void)cleanBadge {
    UIApplication *application = [UIApplication sharedApplication];
    NSInteger num = application.applicationIconBadgeNumber;
    if (num != 0) {
        AVInstallation *currentInstallation = [AVInstallation currentInstallation];
        [currentInstallation setBadge:0];
        [currentInstallation saveInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
            NSLog(@"%@", error ? error : @"succeed");
        }];
        application.applicationIconBadgeNumber = 0;
    }
    [application cancelAllLocalNotifications];
}

- (void)syncBadge {
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    if (currentInstallation.badge != [UIApplication sharedApplication].applicationIconBadgeNumber) {
        [currentInstallation setBadge:[UIApplication sharedApplication].applicationIconBadgeNumber];
        [currentInstallation saveEventually: ^(BOOL succeeded, NSError *error) {
            NSLog(@"%@", error ? error : @"succeed");
        }];
    } 
}


@end
