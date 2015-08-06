//
//  AvatarUtil.h
//  TongChuang
//
//  Created by cuixiang on 15/7/18.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ORIGINAL_MAX_WIDTH 640.0f

@interface AvatarUtil : NSObject

+ (UIImage *)imageScalingToMaxSize:(UIImage *)sourceImage;

@end
