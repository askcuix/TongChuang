//
//  DatePicker.m
//  TongChuang
//
//  Created by cuixiang on 15/7/19.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "DatePicker.h"
#import "UIView+Extension.h"
#import "UIImage+ImageEffects.h"

@interface DatePicker() {
    id<DatePickerDelegate> _delegate;
    NSDate *_date;
    UIDatePickerMode _mode;
    UIView *_pickerView;
    
    UIImageView *_bgImageView;
}

@end

@implementation DatePicker

- (id)initWithDelegate:(id<DatePickerDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        _date = [NSDate date];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)setDate:(NSDate *)date withMode:(UIDatePickerMode)mode {
    if (date) {
        _date = date;
    }
    _mode = mode;
}

- (void)showInView:(UIView *)parentView withBlur:(BOOL)blur minsInterval:(NSInteger)interval {
    if (_bgImageView) {
        return;
    }
    
    self.frame = CGRectMake(0, parentView.height, parentView.width, parentView.height);
    self.backgroundColor = [UIColor clearColor];
    
    if (_pickerView)
    {
        [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
    
    _pickerView = [[[NSBundle mainBundle] loadNibNamed:@"DatePicker" owner:self options:nil] lastObject];
    _pickerView.frame = CGRectMake(0, 0, parentView.width, parentView.height);
    [self addSubview:_pickerView];
    
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, parentView.width, parentView.height)];
    _bgImageView.alpha = 0.0;
    _bgImageView.backgroundColor = [UIColor clearColor];
    [parentView addSubview:_bgImageView];
    
    if (blur) {
        UIGraphicsBeginImageContext(parentView.frame.size);
        [parentView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *windowImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
        UIImage *blurImage = [windowImage applyBlurWithRadius:2.0f tintColor:tintColor saturationDeltaFactor:1.2 maskImage:nil];
        [_bgImageView setImage:blurImage];
    } else {
        _bgImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    
    UIDatePicker *datePicker = (UIDatePicker*)[_pickerView.subviews objectAtIndex:2];
    UIView *datePickerBg = [datePicker.subviews objectAtIndex:0];
    datePickerBg.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.20
                          delay:0
                        options:(7 << 16)
                     animations:^{
                         self.frame = CGRectMake(0, 0, parentView.width, parentView.height);
                         _bgImageView.alpha = 1.0;
                     } completion:nil];
    
    [parentView addSubview:self];
    [parentView bringSubviewToFront:self];
    self.datePicker.datePickerMode = _mode;
    self.datePicker.minuteInterval = interval;
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [_datePicker setLocale:locale];
    
    [self.datePicker setDate:_date animated:NO];
    
}
- (void)showInView:(UIView *)parentView withBlur:(BOOL)blur {
    [self showInView:parentView withBlur:blur minsInterval:1];
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _pickerView.top = self.height;
        _bgImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_bgImageView removeFromSuperview];
        _bgImageView = nil;
    }];
}

- (IBAction)onConfirmButtonClicked:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(onDatePickDone:date:)]) {
        [_delegate onDatePickDone:self date:self.datePicker.date];
    }
    [self hide];
}

- (IBAction)onCancelButtonClicked:(id)sender {
    [self hide];
}

- (IBAction)onBackgroundClicked:(id)sender
{
    [self hide];
}
@end
