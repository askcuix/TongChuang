//
//  AppDelegate.m
//  TongChuang
//
//  Created by cuixiang on 15/7/8.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CommonDefs.h"
#import "AppModel.h"
#import "ControllerManager.h"
#import "ChatPushManager.h"
#import "ChatManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - shared instance
+ (instancetype)sharedInstance {
    return [UIApplication sharedApplication].delegate;
}

#pragma mark - lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 初始化model
    [[AppModel sharedInstance] initModel];
    
    // 创建必须的目录
    [[AppModel sharedInstance].fileModel createRequiredPath];
    
    // 初始化AVOSCloud
    [AVOSCloud setApplicationId:AVOSAppID clientKey:AVOSAppKey];
    
    // 初始化controller
    [[ControllerManager sharedInstance] applicationLaunch];
    
    // 注册IM消息推送
    [[ChatPushManager manager] registerForRemoteNotification];
    
#ifdef DEBUG
    NSLog(@"Runing DEBUG mode.");
    [AVPush setProductionMode:NO];
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    //同步应用程序角标
    [[ChatPushManager manager] syncBadge];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //清除应用程序角标
    [[ChatPushManager manager] cleanBadge];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[AppModel sharedInstance] destroyModel];
    
    //同步应用程序角标
    [[ChatPushManager manager] syncBadge];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[ChatPushManager manager] saveInstallationWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Register remote notification error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (application.applicationState == UIApplicationStateActive) {
        // 应用在前台时收到推送，只能来自于普通的推送，而非离线消息推送
    } else {
        //  当使用 https://github.com/leancloud/leanchat-cloudcode 云代码更改推送内容的时候
        //        {
        //            aps =     {
        //                alert = "lzwios : sdfsdf";
        //                badge = 4;
        //                sound = default;
        //            };
        //            convid = 55bae86300b0efdcbe3e742e;
        //        }
        [[ChatManager manager] didReceiveRemoteNotification:userInfo];
    }
    
    NSLog(@"Received remote notification: %@", userInfo);
}

@end
