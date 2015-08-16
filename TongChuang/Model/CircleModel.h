//
//  CircleModel.h
//  TongChuang
//
//  Created by cuixiang on 15/8/15.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleModel : NSObject

- (void)getCirclesWithBlock:(void (^)(NSArray *objects, NSError *error))circlesBlock;

@end
