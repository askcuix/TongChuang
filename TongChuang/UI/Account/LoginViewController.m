//
//  LoginViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/14.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "LoginViewController.h"
#import "ControllerManager.h"
#import "UIView+Extension.h"
#import "RegisterViewController.h"
#import "ValidateUtil.h"
#import "CacheManager.h"
#import "AppModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)loginBtnClick:(UIButton *)sender;
- (IBAction)registerBtnClick:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.loginBtn setCornerRadius:4 maskToBounds:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[KeyboardHelper helper] setViewToKeyboardHelper:_passwordField withShouldOffsetView:self.view];
    
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
        [self showHUDText:@"手机号不能为空" type:Fail];
        return;
    } else if ([_passwordField.text length] == 0) {
        [self showHUDText:@"密码不能为空" type:Fail];
        return;
    } else if (![ValidateUtil validatePhoneNum:[_mobileField text]]) {
        [self showHUDText:@"手机号格式不正确" type:Fail];
        return;
    }
    
    [self showProgress];
    [[AppModel sharedInstance].loginModel login:_mobileField.text password:_passwordField.text];
}

- (IBAction)registerBtnClick:(UIButton *)sender {
    RegisterViewController *registerController = [ControllerManager viewControllerInSettingStoryboard:@"RegisterViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:registerController];
    
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - Notification
- (void)onLoginResult:(NSNotification *)notification {
    [self hideProgress];
    
    NSInteger result = [[notification.userInfo valueForKey:kLoginResult] integerValue];
    
    if (result == LoginSuccess) {
        //缓存当前用户信息
        UserInfo *currentUser = [[UserInfo alloc] init];
        currentUser.uid = [[AppModel sharedInstance].loginModel uid];
        currentUser.name = [[AppModel sharedInstance].loginModel account];
        currentUser.avatarUrl = [[AppModel sharedInstance].loginModel avatar];
        [[CacheManager manager] registerUsers:@[currentUser]];
        
        [[ControllerManager sharedInstance] presentMainView];
    } else {
        [self showHUDText:@"登录失败" type:Fail];
    }
}

@end
