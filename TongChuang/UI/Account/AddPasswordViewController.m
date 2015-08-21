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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextBtn;

- (IBAction)backBtnClick:(UIBarButtonItem *)sender;
- (IBAction)nextBtnClick:(UIBarButtonItem *)sender;

@end

@implementation AddPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.nextBtn setEnabled:NO];
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

- (IBAction)backBtnClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - action
- (IBAction)textFieldDidChange:(id)sender {
    if ([[_passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return;
    }
    
    [self.nextBtn setEnabled:YES];
}

- (IBAction)nextBtnClick:(UIBarButtonItem *)sender {
    [_passwordField resignFirstResponder];
    
    [[AppModel sharedInstance].loginModel login:self.mobile password:_passwordField.text];
    [self showProgress];
}

#pragma mark - Notification
- (void)onLoginResult:(NSNotification *)notification {
    [self hideProgress];
    
    NSInteger result = [[notification.userInfo valueForKey:kLoginResult] integerValue];
    
    if (result == LoginSuccess) {
        NSLog(@"登录成功：%@", self.mobile);
        
        BasicProfileViewController *profileController = [ControllerManager viewControllerInSettingStoryboard:@"BasicProfileViewController"];
        [self.navigationController pushViewController:profileController animated:YES];
    } else {
        [self showHUDText:@"登录失败" type:Fail];
    }
}
@end
