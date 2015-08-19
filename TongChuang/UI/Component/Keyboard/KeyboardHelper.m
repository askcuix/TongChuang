//
//  KeyboardHelper.m
//  TongChuang
//
//  Created by cuixiang on 15/8/20.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "KeyboardHelper.h"

@interface KeyboardHelper () {
    __weak UIView *_responderView;
    CGFloat _originY;
    __weak UIView *_shouldOffsetView;
    UITapGestureRecognizer *_tapGesture;
}

@end

@implementation KeyboardHelper

+ (instancetype)helper {
    static KeyboardHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KeyboardHelper alloc] init];
    });
    
    return instance;
}

- (id)init {
    if (self == [super self]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapToHiddenKeyboardView:)];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)setViewToKeyboardHelper:(UIView *)view withShouldOffsetView:(UIView *)shouldOffsetView {
    if (_responderView != view) {
        [_responderView removeGestureRecognizer:_tapGesture];
        _responderView = view;
        _shouldOffsetView = shouldOffsetView;
    }
}

- (CGFloat)getOffsetYFromKeyboardFrame:(CGRect)keyboardFrame {
    CGRect responderViewFrameInWindow = [_responderView.superview convertRect:_responderView.frame toView:_responderView.window];
    CGFloat offsetY;
    offsetY = (responderViewFrameInWindow.origin.y + responderViewFrameInWindow.size.height >= keyboardFrame.origin.y - 20) ? (keyboardFrame.origin.y - responderViewFrameInWindow.origin.y - responderViewFrameInWindow.size.height - 20 ) : 0;
    return offsetY;
}

#pragma mark -Notification
- (void)keyboardWillShown:(NSNotification *)notification {
    if (!_responderView || !_shouldOffsetView) {
        return;
    }
    
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat offsetY = [self getOffsetYFromKeyboardFrame:keyboardFrame];
    CGRect _shouldOffsetViewOriginalFrame = _shouldOffsetView.frame;
    _originY = _originY == 0 ? _shouldOffsetViewOriginalFrame.origin.y : _originY;
    _shouldOffsetViewOriginalFrame.origin.y = _shouldOffsetViewOriginalFrame.origin.y + offsetY;
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *animationCurve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [_shouldOffsetView addGestureRecognizer:_tapGesture];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration.doubleValue];
    [UIView setAnimationCurve:animationCurve.integerValue];
    
    _shouldOffsetView.frame = _shouldOffsetViewOriginalFrame;
    [UIView commitAnimations];
}

- (void)keyboardWillHidden:(NSNotification *)notification
{
    if (!_responderView || !_shouldOffsetView) {
        return;
    }
    NSDictionary *userInfo = notification.userInfo;
    CGRect _shouldOffsetViewOriginalFrame = _shouldOffsetView.frame;
    _shouldOffsetViewOriginalFrame.origin.y = _originY;
    _originY = 0;
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *animationCurve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [_shouldOffsetView removeGestureRecognizer:_tapGesture];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration.doubleValue];
    [UIView setAnimationCurve:animationCurve.integerValue];
    
    _shouldOffsetView.frame = _shouldOffsetViewOriginalFrame;
    [UIView commitAnimations];
}

#pragma mark -Action
- (void)onTapToHiddenKeyboardView:(UITapGestureRecognizer *)gesture
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
