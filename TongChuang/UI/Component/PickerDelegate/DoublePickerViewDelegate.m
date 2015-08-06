//
//  DoublePickerViewDelegate.m
//  TongChuang
//
//  Created by cuixiang on 15/8/3.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "DoublePickerViewDelegate.h"
#import "CommonDefs.h"

@interface DoublePickerViewDelegate () {
    __weak id<DoublePickerDelegate> _delegate;
    
    CGFloat _firstComponentWidth;
    CGFloat _secondComponentWidth;
}

@property (nonatomic, copy) NSDictionary *pickerData;
@property (nonatomic, strong) NSArray *firstComponentData;
@property (nonatomic, strong) NSArray *secondComponentData;

@end

@implementation DoublePickerViewDelegate

- (instancetype)initWithData:(NSDictionary *)data delegate:(id<DoublePickerDelegate>)delegate {
    if (self == [super init]) {
        _delegate = delegate;
        self.pickerData = data;
        self.firstComponentData = [self.pickerData allKeys];
        self.secondComponentData = self.pickerData[self.firstComponentData[0]];
    }
    
    return self;
}

- (void)setWidth:(CGFloat)firstComponentWidth secondComponentWidth:(CGFloat)secondComponentWidth {
    _firstComponentWidth = firstComponentWidth;
    _secondComponentWidth = secondComponentWidth;
}

#pragma mark - PickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == kPickerFirstComponent) {
        return self.firstComponentData[row];
    } else {
        return self.secondComponentData[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == kPickerFirstComponent) {
        NSString *selectedFirstCompData = self.firstComponentData[row];
        self.secondComponentData = self.pickerData[selectedFirstCompData];
        [pickerView reloadComponent:kPickerSecondComponent];
        [pickerView selectRow:0 inComponent:kPickerSecondComponent animated:YES];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (!_firstComponentWidth) {
        CGFloat viewWidth = pickerView.bounds.size.width;
        _firstComponentWidth = viewWidth / 2;
        _secondComponentWidth = viewWidth / 2;
    }
    
    if (component == kPickerFirstComponent) {
        return _secondComponentWidth;
    } else {
        return _secondComponentWidth;
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == kPickerFirstComponent) {
        return [self.firstComponentData count];
    } else {
        return [self.secondComponentData count];
    }
}

#pragma mark - PickerViewDelegate
- (void)onPickerViewDone:(id)sender data:(NSArray *)data {
    if ([data count] != 2) {
        NSLog(@"Data picker component data length is not correct: %lu", (unsigned long)[data count]);
        return;
    }
    
    NSNumber *firstCompIndex = [data objectAtIndex:0];
    NSNumber *secondCompIndex = [data objectAtIndex:1];
    
    NSArray *result = @[self.firstComponentData[firstCompIndex.integerValue], self.secondComponentData[secondCompIndex.integerValue]];
    
    if (_delegate && [_delegate respondsToSelector:@selector(pickDoubleValueDone:data:)]) {
        [_delegate pickDoubleValueDone:sender data:result];
    }
}

@end
