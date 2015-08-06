//
//  MainTabViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "MainTabViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置tabBar背景色
    UIView *tabBarView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    tabBarView.backgroundColor = [UIColor clearColor];
    [self.tabBar insertSubview:tabBarView atIndex:0];
    self.tabBar.opaque = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
