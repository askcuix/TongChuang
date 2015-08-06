//
//  ChatNavigationViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/20.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ChatNavigationViewController.h"
#import "ContactNavigationViewController.h"
#import "ServiceNavigationViewController.h"
#import "MyPreferenceNavigationViewController.h"

@interface ChatNavigationViewController ()

@end

@implementation ChatNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置tab bar
    NSArray *tabControllers = self.tabBarController.viewControllers;
    for (UIViewController *vc in tabControllers) {
        if ([vc isKindOfClass:[ChatNavigationViewController class]]) {
            [self setNormalTab:vc imageName:@"chat_normal.png"];
            [self setSelectedTab:vc imageName:@"chat_press.png"];
        } else if ([vc isKindOfClass:[ContactNavigationViewController class]]) {
            [self setNormalTab:vc imageName:@"contact_normal.png"];
            [self setSelectedTab:vc imageName:@"contact_press.png"];
        } else if ([vc isKindOfClass:[ServiceNavigationViewController class]]) {
            [self setNormalTab:vc imageName:@"service_normal.png"];
            [self setSelectedTab:vc imageName:@"service_press.png"];
        } else if ([vc isKindOfClass:[MyPreferenceNavigationViewController class]]) {
            [self setNormalTab:vc imageName:@"profile_normal.png"];
            [self setSelectedTab:vc imageName:@"profile_press.png"];
        }
    }
    
//    [self.tabBarItem setBadgeValue:@"1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tab bar
- (void)setNormalTab:(UIViewController *)vc imageName:(NSString *)image {
    //设置tab的图片，并清除tint color
    UIImage *tabImg = [UIImage imageNamed:image];
    vc.tabBarItem.image = [tabImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tab的文字信息
    [vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] } forState:UIControlStateNormal];
}

- (void)setSelectedTab:(UIViewController *)vc imageName:(NSString *)image {
    //设置tab选中时的图片，并清除tint color
    UIImage *tabSelectedImg = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [tabSelectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tab选中时的文字信息
    [vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:38.0f/255.0f green:40.0f/255.0f blue:60.0f/255.0f alpha:1.000] } forState:UIControlStateSelected];
}

@end
