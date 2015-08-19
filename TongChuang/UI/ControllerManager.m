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
#import "CommonTypes.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "UIColor+Extension.h"
#import "UserGuiderViewController.h"
#import "MainTabViewController.h"
#import "LoginViewController.h"
#import "ChatListViewController.h"
#import "ContactListViewController.h"
#import "ServiceSearchViewController.h"
#import "MyPreferenceViewController.h"
#import "AppModel.h"
#import "SettingModel.h"
#import "ChatManager.h"
#import "CacheManager.h"
#import "ViewUtil.h"

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
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTintColor:[UIColor clearColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColorHex(@"#262626"), NSFontAttributeName : [UIFont systemFontOfSize:17] }];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColorHex(@"#a5a7aa"), NSFontAttributeName : [UIFont systemFontOfSize:10] } forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColorHex(@"#46a5e3"), NSFontAttributeName : [UIFont systemFontOfSize:10] } forState:UIControlStateSelected];
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
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
    //显示主视图
    if (!_mainController) {
        _mainController = [[MainTabViewController alloc] init];
        [ViewUtil addTabItemController:[[ChatListViewController alloc] init] toTabBarController:_mainController];
        [ViewUtil addTabItemController:[[ContactListViewController alloc] init] toTabBarController:_mainController];
        
        ServiceSearchViewController *serviceController = [ControllerManager viewControllerInMainStoryboard:@"ServiceSearchViewController"];
        serviceController.title=@"发现";
        [ViewUtil setNormalTabItem:serviceController imageName:@"service_normal.png"];
        [ViewUtil setSelectedTabItem:serviceController imageName:@"service_press.png"];
        [ViewUtil addTabItemController:serviceController toTabBarController:_mainController];
        
        MyPreferenceViewController *preferenceController = [ControllerManager viewControllerInMainStoryboard:@"MyPreferenceViewController"];
        preferenceController.title=@"我";
        [ViewUtil setNormalTabItem:preferenceController imageName:@"profile_normal.png"];
        [ViewUtil setSelectedTabItem:preferenceController imageName:@"profile_press.png"];
        [ViewUtil addTabItemController:preferenceController toTabBarController:_mainController];
    }
    
    _window.rootViewController = _mainController;
}

- (void)presentLoginController {
    LoginViewController *loginController = [ControllerManager viewControllerInSettingStoryboard:@"LoginViewController"];
    BaseNavigationController *loginNavController = [[BaseNavigationController alloc] initWithRootViewController:loginController];
   
    _window.rootViewController = loginNavController;
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
