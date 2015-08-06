//
//  RegisterViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/29.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "RegisterViewController.h"
#import "ControllerManager.h"
#import "ValidateUtil.h"
#import "AddPasswordViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeField;

- (IBAction)sendVerifyCode:(UIButton *)sender;
- (IBAction)backBtnClick:(UIBarButtonItem *)sender;
- (IBAction)nextBtnClick:(UIBarButtonItem *)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)sendVerifyCode:(UIButton *)sender {
    [_mobileField resignFirstResponder];
    
    if ([_mobileField.text length] == 0) {
        NSLog(@"手机号码不能为空！");
        _mobileField.backgroundColor = [UIColor redColor];
        return;
    } else if (![ValidateUtil validatePhoneNum:_mobileField.text]) {
        NSLog(@"手机号码格式不正确！");
        _mobileField.backgroundColor = [UIColor redColor];
        return;
    }
    
    NSLog(@"发送验证码......");
}

- (IBAction)backBtnClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextBtnClick:(UIBarButtonItem *)sender {
    [_mobileField resignFirstResponder];
    [_verifyCodeField resignFirstResponder];
    
    if ([_mobileField.text length] == 0) {
        NSLog(@"手机号码不能为空！");
        _mobileField.backgroundColor = [UIColor redColor];
        return;
    } else if (![ValidateUtil validatePhoneNum:_mobileField.text]) {
        NSLog(@"手机号码格式不正确！");
        _mobileField.backgroundColor = [UIColor redColor];
        return;
    } else if ([_verifyCodeField.text length] == 0) {
        NSLog(@"验证码不能为空！");
        _verifyCodeField.backgroundColor = [UIColor redColor];
        return;
    }
    
    NSLog(@"手机号码：%@, 验证码：%@", _mobileField.text, _verifyCodeField.text);
    
    AddPasswordViewController *passwordController = [ControllerManager viewControllerInSettingStoryboard:@"AddPasswordViewController"];
    passwordController.mobile = _mobileField.text;
    [self.navigationController pushViewController:passwordController animated:YES];
}
@end
