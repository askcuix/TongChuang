//
//  BaseViewController.h
//  TongChuang
//
//  Created by cuixiang on 15/7/20.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefs.h"
#import "CommonTypes.h"
#import "ControllerManager.h"

typedef NS_ENUM(NSUInteger, ToastType) {
    Warning,
    Success,
    Fail,
};

@interface BaseViewController : UIViewController

#pragma mark - common action
- (IBAction)textFieldDoneEditing:(id)sender;

#pragma mark - progress
- (void)showProgress;

- (void)hideProgress;

- (void)showHUDText:(NSString *)text type:(ToastType) toastType;

- (void)toast:(NSString *)text;

- (void)toast:(NSString *)text duration:(NSTimeInterval)duration;

@end
