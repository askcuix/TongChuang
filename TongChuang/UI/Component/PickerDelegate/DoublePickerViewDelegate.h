//
//  DoublePickerViewDelegate.h
//  TongChuang
//
//  Created by cuixiang on 15/8/3.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerView.h"

@protocol DoublePickerDelegate <NSObject>

- (void)pickDoubleValueDone:(id)sender data:(NSArray *)pickedValue;

@end

@interface DoublePickerViewDelegate : NSObject
        <PickerViewDelegate, PickerViewDataSource>

- (instancetype)initWithData:(NSDictionary *)data delegate:(id<DoublePickerDelegate>)delegate;
- (void)setWidth:(CGFloat)firstComponentWidth secondComponentWidth:(CGFloat)secondComponentWidth;

@end
