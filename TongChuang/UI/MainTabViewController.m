//
//  MainTabViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "MainTabViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppModel.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectedIndex = 0;
    [self showProgress];
    
    [ChatManager manager].userDelegate = [AppModel sharedInstance].userModel;
    
#ifdef DEBUG
    [ChatManager manager].useDevPushCerticate = YES;
#endif
    
    //连接IM服务器
    [[ChatManager manager] openWithClientId:[NSString stringWithFormat:@"%lu", (unsigned long)[[AppModel sharedInstance].loginModel uid]] callback:^(BOOL succeeded, NSError *error) {
        [self hideProgress];
        
        if (!succeeded) {
            [self toast:@"连接IM服务器失败"];
            NSLog(@"Connect chat server error: %@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - progress
-(void)showProgress{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideProgress{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)toast:(NSString *)text {
    MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    hud.detailsLabelText = text;
    hud.margin=10.f;
    hud.removeFromSuperViewOnHide=YES;
    hud.mode=MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
}

@end
