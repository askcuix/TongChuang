//
//  PickerView.m
//  TongChuang
//
//  Created by cuixiang on 15/7/19.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "PickerView.h"
#import "UIViewUtil.h"
#import "UIImage+ImageEffects.h"

@interface PickerView () {
    __weak id<PickerViewDelegate> _delegate;
    __weak id<PickerViewDataSource> _dataSource;
    
    UIView *_pickerView;
    UIImageView *_bgImageView;
}

@end

@implementation PickerView

- (instancetype)initWithDelegate:(id<PickerViewDelegate>)delegate withDataSource:(id<PickerViewDataSource>)dataSource {
    if (self = [super init]) {
        _delegate = delegate;
        _dataSource = dataSource;
        _pickerView = [[[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)showInView:(UIView *)parentView withBlur:(BOOL)blur {
    if (_bgImageView) {
        return;
    }
    
    self.frame = CGRectMake(0, parentView.height, parentView.width, parentView.height);
    self.backgroundColor = [UIColor clearColor];
    
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
    
    UIPickerView *picker = (UIPickerView *)[_pickerView.subviews objectAtIndex:2];
    picker.backgroundColor = [UIColor whiteColor];
    _pickerView.frame = CGRectMake(0, 0, parentView.width, parentView.height);
    [self addSubview:_pickerView];
    
    [UIView animateWithDuration:0.20
                          delay:0
                        options:(7 << 16)
                     animations:^{
                         self.frame = CGRectMake(0, 0, parentView.width, parentView.height);
                         _bgImageView.alpha = 1.0;
                     } completion:nil];
    self.picker.delegate = _delegate;
    self.picker.dataSource = _dataSource;
    [parentView addSubview:self];
    [parentView bringSubviewToFront:self];
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        _pickerView.y = self.height;
        _bgImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_bgImageView removeFromSuperview];
        [self removeFromSuperview];
        _bgImageView = nil;
    }];
}

- (IBAction)onConfirmButtonClicked:(id)sender {
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:[_picker numberOfComponents]];
    for (int i = 0; i < [_picker numberOfComponents]; i++) {
        NSNumber *index = @([_picker selectedRowInComponent:i]);
        [data addObject:index];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(onPickerViewDone:data:)]) {
        [_delegate onPickerViewDone:self data:data];
    }
    [self hide];
}

- (IBAction)onCancelButtonClicked:(id)sender {
    [self hide];
}

- (IBAction)onBackgroundClicked:(id)sender {
    [self hide];
}

@end
