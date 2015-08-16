//
//  ViewUtil.h
//  TongChuang
//
//  Created by cuixiang on 15/8/15.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewUtil : NSObject

+ (void)addTabItemController:(UIViewController *)itemController toTabBarController:(UITabBarController *)tab;

+ (void)setNormalTabItem:(UIViewController *)vc imageName:(NSString *)image;
+ (void)setSelectedTabItem:(UIViewController *)vc imageName:(NSString *)image;

@end
