//
//  ViewUtil.m
//  TongChuang
//
//  Created by cuixiang on 15/8/15.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ViewUtil.h"
#import "BaseNavigationController.h"

@implementation ViewUtil

+ (void)addTabItemController:(UIViewController *)itemController toTabBarController:(UITabBarController *)tab {
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:itemController];
    [tab addChildViewController:nav];
}

+ (void)setNormalTabItem:(UIViewController *)vc imageName:(NSString *)image {
    //设置tab的图片，并清除tint color
    UIImage *tabImg = [UIImage imageNamed:image];
    vc.tabBarItem.image = [tabImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (void)setSelectedTabItem:(UIViewController *)vc imageName:(NSString *)image {
    //设置tab选中时的图片，并清除tint color
    UIImage *tabSelectedImg = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [tabSelectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
