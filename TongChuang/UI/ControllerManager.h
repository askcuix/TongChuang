//
//  ControllerManager.h
//  TongChuang
//
//  Created by cuixiang on 15/7/27.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControllerManager : NSObject

+ (ControllerManager *)sharedInstance;

- (void)applicationLaunch;

- (void)presentMainView;
- (void)loginSuccessed;

+ (id)viewControllerInMainStoryboard:(NSString *)identifier;
+ (id)viewControllerInSettingStoryboard:(NSString *)identifier;

@end
