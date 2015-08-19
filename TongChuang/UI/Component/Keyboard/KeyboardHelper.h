//
//  KeyboardHelper.h
//  TongChuang
//
//  Created by cuixiang on 15/8/20.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardHelper : NSObject

+ (instancetype)helper;
- (void)setViewToKeyboardHelper:(UIView *)view withShouldOffsetView:(UIView *)shouldOffsetView;

@end
