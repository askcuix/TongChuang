//
//  UIViewUtil.h
//  TongChuang
//
//  Created by cuixiang on 15/7/19.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewGeometryHelper)

@property(assign, nonatomic) CGFloat width;
@property(assign, nonatomic) CGFloat height;
@property(assign, nonatomic) CGFloat x;
@property(assign, nonatomic) CGFloat y;
@property(readonly, nonatomic) CGFloat bottom;

@end
