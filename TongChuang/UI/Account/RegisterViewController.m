//
//  RegisterViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/29.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "RegisterViewController.h"
#import "ControllerManager.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "ValidateUtil.h"
#import "AddPasswordViewController.h"

@interface RegisterViewController () {
    NSTimer *_resendSmsTimer;
    NSInteger _resendSmsSec;
    BOOL timerPause;
}

@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeField;
@property (weak, nonatomic) IBOutlet UIButton *sendVerifyCodeBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextBtn;

- (IBAction)sendVerifyCode:(UIButton *)sender;
- (IBAction)backBtnClick:(UIBarButtonItem *)sender;
- (IBAction)nextBtnClick:(UIBarButtonItem *)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.nextBtn setEnabled:NO];
    
    [self.sendVerifyCodeBtn setBorderWidth:1];
    [self.sendVerifyCodeBtn setBorderColor:UIColorHex(@"#46a5e3")];
    [self.sendVerifyCodeBtn setCornerRadius:4 maskToBounds:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[KeyboardHelper helper] setViewToKeyboardHelper:_verifyCodeField withShouldOffsetView:self.view];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_resendSmsTimer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)textFieldDidChange:(id)sender {
    if ([_mobileField.text length] == 0) {
        return;
    } else if ([_verifyCodeField.text length] == 0) {
        return;
    }
    
    [self.nextBtn setEnabled:YES];
}

- (IBAction)sendVerifyCode:(UIButton *)sender {
    [_mobileField resignFirstResponder];
    
    if ([_mobileField.text length] == 0) {
        [self showHUDText:@"手机号不能为空" type:Fail];
        return;
    } else if (![ValidateUtil validatePhoneNum:_mobileField.text]) {
        [self showHUDText:@"手机号格式不正确" type:Fail];
        return;
    }
    
    //TODO: send verify code
    
    [self.sendVerifyCodeBtn setBorderWidth:0];
    [self.sendVerifyCodeBtn setBackgroundColor:UIColorHex(@"#d7d7d7")];
    [self.sendVerifyCodeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [self.sendVerifyCodeBtn setTitle:@"60s后重新发送" forState:UIControlStateNormal];
    [self.sendVerifyCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    timerPause = NO;
    _resendSmsSec = 60;
    _resendSmsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onResendSmsTimer) userInfo:nil repeats:YES];
}

-(void)onResendSmsTimer
{
    if(timerPause){
        return;
    }
    _resendSmsSec--;
    if(_resendSmsSec <= 0){
        [self resetGetSmsCodeButtonState];
    }else{
        timerPause = false;
        [self.sendVerifyCodeBtn setUserInteractionEnabled:NO];
        [self.sendVerifyCodeBtn setTitle:[NSString stringWithFormat:@"%ds后重新发送", _resendSmsSec] forState:UIControlStateNormal];
    }
}

- (void)resetGetSmsCodeButtonState {
    timerPause = true;
    _resendSmsSec = 60;
    
    [self.sendVerifyCodeBtn setBorderWidth:1];
    [self.sendVerifyCodeBtn setBorderColor:UIColorHex(@"#46a5e3")];
    [self.sendVerifyCodeBtn setBackgroundColor:[UIColor whiteColor]];
    [self.sendVerifyCodeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.sendVerifyCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    [self.sendVerifyCodeBtn setTitleColor:UIColorHex(@"#46a5e3") forState:UIControlStateNormal];
    [self.sendVerifyCodeBtn setUserInteractionEnabled:YES];
    
}

- (IBAction)backBtnClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [[ControllerManager sharedInstance] presentMainView];
    }];
}

- (IBAction)nextBtnClick:(UIBarButtonItem *)sender {
    [_mobileField resignFirstResponder];
    [_verifyCodeField resignFirstResponder];
    
    if (![ValidateUtil validatePhoneNum:_mobileField.text]) {
        [self showHUDText:@"手机号格式不正确" type:Fail];
        return;
    }
    
    AddPasswordViewController *passwordController = [ControllerManager viewControllerInSettingStoryboard:@"AddPasswordViewController"];
    passwordController.mobile = _mobileField.text;
    [self.navigationController pushViewController:passwordController animated:YES];
}

@end
