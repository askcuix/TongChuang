//
//  GenderPickerDelegate.h
//  TongChuang
//
//  Created by cuixiang on 15/7/19.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerView.h"

@protocol SingerPickerDelegate <NSObject>

- (void)pickValueDone:(id)sender data:(NSString *)pickedValue;

@end

@interface SingerPickerViewDelegate : NSObject
    <PickerViewDelegate, PickerViewDataSource>

- (instancetype)initWithData:(NSArray *)data delegate:(id<SingerPickerDelegate>)delegate;

@end
