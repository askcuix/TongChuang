//
//  BaseViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/20.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

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

#pragma mark - common action
//隐藏键盘，绑定到Did End On Exit事件
- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

#pragma mark - progress
-(void)showProgress{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideProgress{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)toast:(NSString *)text {
    [self toast:text duration:2];
}

- (void)toast:(NSString *)text duration:(NSTimeInterval)duration {
    MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    hud.detailsLabelText = text;
    hud.margin=10.f;
    hud.removeFromSuperViewOnHide=YES;
    hud.mode=MBProgressHUDModeText;
    [hud hide:YES afterDelay:duration];
}

-(void)showHUDText:(NSString*)text{
    [self toast:text];
}

@end
