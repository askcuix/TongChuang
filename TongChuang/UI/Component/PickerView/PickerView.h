//
//  PickerView.h
//  TongChuang
//
//  Created by cuixiang on 15/7/19.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewDelegate <UIPickerViewDelegate>

@optional
- (void)onPickerViewDone:(id)sender data:(NSArray *)data;//返回的是每一列的索引

@end

@protocol PickerViewDataSource <UIPickerViewDataSource>

@end

@interface PickerView : UIView

@property (nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (instancetype)initWithDelegate:(id<PickerViewDelegate>)delegate withDataSource:(id<PickerViewDataSource>)dataSource;
- (void)showInView:(UIView *)view withBlur:(BOOL)blur;;
- (void)hide;

@end
