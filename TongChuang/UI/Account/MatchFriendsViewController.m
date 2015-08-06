//
//  MatchFriendsViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/8/3.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "MatchFriendsViewController.h"
#import "ControllerManager.h"
#import "RecommendListViewController.h"

@interface MatchFriendsViewController ()
- (IBAction)nextBtnClick:(UIBarButtonItem *)sender;

@end

@implementation MatchFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //隐藏返回按钮
    [self.navigationItem setHidesBackButton:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)nextBtnClick:(UIBarButtonItem *)sender {
    RecommendListViewController *recommendController = [ControllerManager viewControllerInSettingStoryboard:@"RecommendListViewController"];
    [self.navigationController pushViewController:recommendController animated:YES];
}
@end
