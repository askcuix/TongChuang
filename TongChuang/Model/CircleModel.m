//
//  CircleModel.m
//  TongChuang
//
//  Created by cuixiang on 15/8/15.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "CircleModel.h"
#import "CommonTypes.h"

@interface CircleModel ()

@property (nonatomic, strong) NSArray *circles;

@end

@implementation CircleModel

- (instancetype)init {
    if (self = [super init]) {
        CircleInfo *circle1 = [[CircleInfo alloc] init];
        circle1.cid = 10001;
        circle1.name = @"广州法律行业圈";
        
        CircleInfo *circle2 = [[CircleInfo alloc] init];
        circle2.cid = 10002;
        circle2.name = @"广州财经大学校友圈";
        
        _circles = @[circle1, circle2];
    }
    
    return self;
}

- (void)getCirclesWithBlock:(void (^)(NSArray *, NSError *))circlesBlock {
    circlesBlock(_circles, nil);
}

@end
