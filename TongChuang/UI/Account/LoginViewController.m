//
//  LoginViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/14.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "LoginViewController.h"
#import "ControllerManager.h"
#import "RegisterViewController.h"
#import "ValidateUtil.h"
#import "AppModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginBtnClick:(UIButton *)sender;
- (IBAction)registerBtnClick:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginResult:) name:kLoginNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action
- (IBAction)loginBtnClick:(UIButton *)sender {
    [_mobileField resignFirstResponder];
    [_passwordField resignFirstResponder];
    
    if ([_mobileField.text length] == 0) {
        NSLog(@"手机号码不能为空！");
        _mobileField.backgroundColor = [UIColor redColor];
        return;
    } else if ([_passwordField.text length] == 0) {
        NSLog(@"密码不能为空！");
        _passwordField.backgroundColor = [UIColor redColor];
        return;
    } else if (![ValidateUtil validatePhoneNum:[_mobileField text]]) {
        NSLog(@"手机号码格式不正确！");
        _mobileField.backgroundColor = [UIColor redColor];
        return;
    }
    
    [[AppModel sharedInstance].loginModel login:_mobileField.text password:_passwordField.text];
}

- (IBAction)registerBtnClick:(UIButton *)sender {
    RegisterViewController *registerController = [ControllerManager viewControllerInSettingStoryboard:@"RegisterViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:registerController];
    
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - Notification
- (void)onLoginResult:(NSNotification *)notification {
    NSInteger result = [[notification.userInfo valueForKey:kLoginResult] integerValue];
    
    if (result == LoginSuccess) {
        NSLog(@"登录成功");
        [[ControllerManager sharedInstance] presentMainView];
    } else {
        NSLog(@"登录失败");
    }
}

@end
