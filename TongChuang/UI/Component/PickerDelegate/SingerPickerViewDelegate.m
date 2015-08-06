//
//  GenderPickerDelegate.m
//  TongChuang
//
//  Created by cuixiang on 15/7/19.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "SingerPickerViewDelegate.h"
#import "CommonDefs.h"

@interface SingerPickerViewDelegate () {
    __weak id<SingerPickerDelegate> _delegate;
}

@property(nonatomic, copy) NSArray *pickerData;

@end

@implementation SingerPickerViewDelegate

- (instancetype)initWithData:(NSArray *)data delegate:(id<SingerPickerDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        self.pickerData = data;        
    }
    
    return self;
}

#pragma mark - PickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerData[row];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerData count];
}

#pragma mark - PickerViewDelegate
- (void)onPickerViewDone:(id)sender data:(NSArray *)data {
    NSNumber *index = [data objectAtIndex:0];
    
    if (_delegate && [_delegate respondsToSelector:@selector(pickValueDone:data:)]) {
        [_delegate pickValueDone:sender data:self.pickerData[index.integerValue]];
    }
}

@end
