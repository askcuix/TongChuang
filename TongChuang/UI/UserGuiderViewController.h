//
//  UserGuiderViewController.h
//  TongChuang
//
//  Created by cuixiang on 15/7/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol UserGuideViewDelegate <NSObject>

- (void)userGuideCompleted;

@end

@interface UserGuiderViewController : BaseViewController

@property (nonatomic, assign) id<UserGuideViewDelegate> delegate;

@end
