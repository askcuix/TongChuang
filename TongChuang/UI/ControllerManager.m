//
//  ControllerManager.m
//  TongChuang
//
//  Created by cuixiang on 15/7/27.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ControllerManager.h"
#import "AppDelegate.h"
#import "CommonDefs.h"
#import "BaseViewController.h"
#import "UserGuiderViewController.h"
#import "MainTabViewController.h"
#import "LoginViewController.h"
#import "AppModel.h"
#import "SettingModel.h"
#import "ChatManager.h"
#import "ChatUserModel.h"
#import "CacheManager.h"

@interface ControllerManager () <UserGuideViewDelegate> {
    UIWindow *_window;
    MainTabViewController *_mainController;
}

@end

@implementation ControllerManager

+ (ControllerManager *)sharedInstance {
    static ControllerManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ControllerManager alloc] init];
    });
    
    return instance;
}

#pragma mark - launch
- (void)applicationLaunch {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
        
        if (SYSTEM_VERSION >= 7.0) {
            [[UINavigationBar appearance] setBarTintColor:RGBCOLOR(255, 152, 132)];
            [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        }
        else {
            [[UINavigationBar appearance] setTintColor:RGBCOLOR(255, 152, 132)];
        }
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        [AppDelegate sharedInstance].window = _window;
        [[AppDelegate sharedInstance].window makeKeyAndVisible];
    }
    
    [[AppModel sharedInstance].loginModel logout];
    
    BOOL firstLaunch = [[SettingModel sharedInstance] boolForKey:kUserGuideShowedKey];
    if (!firstLaunch) {
        [self presentGuideController];
    } else {
        [self presentMainView];
    }
}

#pragma mark - present view
- (void)presentGuideController {
    UserGuiderViewController *userGuideController = [ControllerManager viewControllerInSettingStoryboard:@"UserGuiderViewController"];
    userGuideController.delegate = self;

    _window.rootViewController = userGuideController;
}

- (void)presentMainView {
    if ([[AppModel sharedInstance].loginModel isLogined]) {
        [self presentMainController];
    } else {
        [self presentLoginController];
    }
}

- (void)presentMainController {
    //缓存当前用户信息
    ChatUserModel *currentUser = [[ChatUserModel alloc] init];
    currentUser.userId = [NSString stringWithFormat:@"%lu", (unsigned long)[[AppModel sharedInstance].loginModel uid]];
    currentUser.username = [[AppModel sharedInstance].loginModel account];
    currentUser.avatarUrl = [[AppModel sharedInstance].loginModel avatar];
    [[CacheManager manager] registerUsers:@[currentUser]];
    
    [ChatManager manager].userDelegate = [AppModel sharedInstance].userModel;
    
#ifdef DEBUG
    [ChatManager manager].useDevPushCerticate = YES;
#endif
    
    //连接IM服务器
    [[ChatManager manager] openWithClientId:[NSString stringWithFormat:@"%lu", (unsigned long)[[AppModel sharedInstance].loginModel uid]] callback:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"Connect chat server error: %@", error);
        }
    }];
    
    //显示主视图
    if (!_mainController) {
        _mainController = [ControllerManager viewControllerInMainStoryboard:@"MainTabViewController"];
    }
    
    _window.rootViewController = _mainController;
}

- (void)presentLoginController {
    LoginViewController *loginController = [ControllerManager viewControllerInSettingStoryboard:@"LoginViewController"];
   
    _window.rootViewController = loginController;
}

#pragma mark - storyboard
+ (UIStoryboard *)mainStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

+ (UIStoryboard *)settingStoryboard {
    return [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
}

#pragma mark - initial view controller 
+ (id)viewControllerInMainStoryboard:(NSString *)identifier {
    return [[ControllerManager mainStoryboard] instantiateViewControllerWithIdentifier:identifier];
}

+ (id)viewControllerInSettingStoryboard:(NSString *)identifier {
    return [[ControllerManager settingStoryboard] instantiateViewControllerWithIdentifier:identifier];
}

#pragma mark - UserGuideViewDelegate
- (void)userGuideCompleted {
    [[SettingModel sharedInstance] setBool:YES forKey:kUserGuideShowedKey];
    
    [self presentMainView];
}

@end
