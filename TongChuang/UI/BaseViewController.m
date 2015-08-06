//
//  BaseViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/20.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - common style
//设置状态栏的字体为白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - common action
//隐藏键盘，绑定到Did End On Exit事件
- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

@end
