//
//  InputPasswordViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/29.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "AddPasswordViewController.h"
#import "AppModel.h"
#import "BasicProfileViewController.h"

@interface AddPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)backBtnClick:(UIBarButtonItem *)sender;
- (IBAction)nextBtnClick:(UIBarButtonItem *)sender;

@end

@implementation AddPasswordViewController

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

- (IBAction)backBtnClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - action
- (IBAction)nextBtnClick:(UIBarButtonItem *)sender {
    [_passwordField resignFirstResponder];
    
    if ([_passwordField.text length] == 0) {
        NSLog(@"密码不能为空！");
        _passwordField.backgroundColor = [UIColor redColor];
        return;
    }
    
    NSLog(@"注册用户 - 手机号码：%@, 密码：%@", _mobile, _passwordField.text);
    
    [[AppModel sharedInstance].loginModel login:self.mobile password:_passwordField.text];
}

#pragma mark - Notification
- (void)onLoginResult:(NSNotification *)notification {
    NSInteger result = [[notification.userInfo valueForKey:kLoginResult] integerValue];
    
    if (result == LoginSuccess) {
        NSLog(@"登录成功");
        
        BasicProfileViewController *profileController = [ControllerManager viewControllerInSettingStoryboard:@"BasicProfileViewController"];
        [self.navigationController pushViewController:profileController animated:YES];
    } else {
        NSLog(@"登录失败");
    }
}
@end
