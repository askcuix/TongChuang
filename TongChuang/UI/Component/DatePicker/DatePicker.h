//
//  DatePicker.h
//  TongChuang
//
//  Created by cuixiang on 15/7/19.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerDelegate <NSObject>

@optional
- (void)onDatePickDone:(id)sender date:(NSDate *)date;

@end

@interface DatePicker : UIView

@property (nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (instancetype)initWithDelegate:(id<DatePickerDelegate>)delegate;

- (void)setDate:(NSDate *)date withMode:(UIDatePickerMode)mode;
- (void)showInView:(UIView *)parentView withBlur:(BOOL)blur minsInterval:(NSInteger)interval;
- (void)showInView:(UIView *)parentView withBlur:(BOOL)blur;
- (void)hide;

@end