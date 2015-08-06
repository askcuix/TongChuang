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

@interface ControllerManager () <UserGuideViewDelegate> {
    BaseViewController *_rootController;
    UINavigationController *_accountController;
    UserGuiderViewController *_userGuideController;
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
    if (!_rootController) {
        _rootController = [[BaseViewController alloc] init];
        
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.rootViewController = _rootController;
        
        [AppDelegate sharedInstance].window = window;
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
    if (!_userGuideController) {
        _userGuideController = [ControllerManager viewControllerInSettingStoryboard:@"UserGuiderViewController"];
        _userGuideController.delegate = self;
    }
    
    [_rootController addChildViewController:_userGuideController];
    [_rootController.view addSubview:_userGuideController.view];
}

- (void)presentMainView {
    if ([[AppModel sharedInstance].loginModel isLogined]) {
        [self presentMainController];
    } else {
        [self presentLoginController];
    }
}

- (void)presentMainController {
    if (!_mainController) {
        _mainController = [ControllerManager viewControllerInMainStoryboard:@"MainTabViewController"];
    }
    
    [_rootController addChildViewController:_mainController];
    [_rootController.view addSubview:_mainController.view];
}

- (void)presentLoginController {
    if (!_accountController) {
        LoginViewController *_loginController = [ControllerManager viewControllerInSettingStoryboard:@"LoginViewController"];
        _accountController = [[UINavigationController alloc] initWithRootViewController:_loginController];
        
    }
    
    [_rootController addChildViewController:_accountController];
    [_rootController.view addSubview:_accountController.view];
}

- (void)loginSuccessed {
    if (_accountController) {
        [_accountController removeFromParentViewController];
        [_accountController.view removeFromSuperview];
        _accountController = nil;
    }
    
    [self presentMainView];
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
    if (_userGuideController) {
        [_userGuideController removeFromParentViewController];
        [_userGuideController.view removeFromSuperview];
        _userGuideController = nil;
    }
    
    [[SettingModel sharedInstance] setBool:YES forKey:kUserGuideShowedKey];
    
    [self presentMainView];
}

@end
