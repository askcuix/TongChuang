//
//  UIView+Extension.m
//  TongChuang
//
//  Created by cuixiang on 15/8/18.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)removeAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

#pragma mark - Getter Methods
- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (UIColor *)borderColor {
    UIColor *color = [UIColor colorWithCGColor:self.layer.borderColor];
    return color;
}

- (CGFloat)shadowRadius {
    return self.layer.shadowRadius;
}

- (float)shadowOpacity {
    return self.layer.shadowOpacity;
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (UIColor *)shadowColor {
    UIColor *color = [UIColor colorWithCGColor:self.layer.shadowColor];
    return color;
}

- (UIBezierPath *)shadowPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.layer.shadowPath];
    return path;
}

- (CGSize)size {
    return self.frame.size;
}

#pragma mark - Setter Methods
- (void)setLeft:(CGFloat)left {
    CGRect frame   = self.frame;
    frame.origin.x = left;
    self.frame     = frame;
}

- (void)setTop:(CGFloat)top {
    CGRect frame   = self.frame;
    frame.origin.y = top;
    self.frame     = frame;
}

- (void)setRight:(CGFloat)right {
    CGRect frame   = self.frame;
    frame.origin.x = right - self.width;
    self.frame     = frame;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame   = self.frame;
    frame.origin.y = bottom - self.height;
    self.frame     = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame     = self.frame;
    frame.size.width = width;
    self.frame       = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame      = self.frame;
    frame.size.height = height;
    self.frame        = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x       = centerX;
    self.center    = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y       = centerY;
    self.center    = center;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame   = frame;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

- (void)setShadowOpacity:(float)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (void)setShadowPath:(UIBezierPath *)shadowPath {
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size   = size;
    self.frame   = frame;
}

- (void)setCornerRadius:(CGFloat)cornerRadius maskToBounds:(BOOL)mask {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = mask;
}

@end
