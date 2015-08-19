//
//  UIColor+Extension.m
//  TongChuang
//
//  Created by cuixiang on 15/8/18.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorWithRGB:(uint32_t)rgbValue {
    CGFloat red   = (rgbValue & 0xFF0000) >> 16;
    CGFloat green = (rgbValue & 0xFF00) >> 8;
    CGFloat blue  = rgbValue & 0xFF;
    
    return UIColorRGB(red, green, blue);
}

+ (UIColor *)colorWithRGBA:(uint32_t)rgbaValue {
    CGFloat red   = (rgbaValue & 0xFF000000) >> 24;
    CGFloat green = (rgbaValue & 0xFF0000) >> 16;
    CGFloat blue  = (rgbaValue & 0xFF00) >> 8;
    CGFloat alpha = (rgbaValue & 0xFF) / 255.0f;
    
    return UIColorRGBA(red, green, blue, alpha);
}

+ (UIColor *)colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha {
    CGFloat red   = (rgbValue & 0xFF0000) >> 16;
    CGFloat green = (rgbValue & 0xFF00) >> 8;
    CGFloat blue  = rgbValue & 0xFF;
    
    return UIColorRGBA(red, green, blue, alpha);
}

static NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

static BOOL hexStrToRGBA(NSString *str, CGFloat *red, CGFloat *green, CGFloat *blue, CGFloat *alpha) {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    str = [[str stringByTrimmingCharactersInSet:set] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *red = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]);
        *green = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]);
        *blue = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]);
        if (length == 4) {
            *alpha = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        } else {
            *alpha = 1;
        }
    } else {
        *red = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]);
        *green = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]);
        *blue = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]);
        if (length == 8) {
            *alpha = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        } else {
            *alpha = 1;
        }
    }
    return YES;
}

+ (UIColor *)colorWithHexString:(NSString *)hexStr {
    CGFloat red, green, blue, alpha;
    if (hexStrToRGBA(hexStr, &red, &green, &blue, &alpha)) {
        return UIColorRGBA(red, green, blue, alpha);
    }
    return nil;
}

+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha {
    CGFloat red, green, blue, tempAlpha;
    if (hexStrToRGBA(hexStr, &red, &green, &blue, &tempAlpha)) {
        return UIColorRGBA(red, green, blue, alpha);
    }
    return nil;
}

- (uint32_t)rgbValue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int8_t red = r * 255;
    uint8_t green = g * 255;
    uint8_t blue = b * 255;
    return (red << 16) + (green << 8) + blue;
}

- (uint32_t)red {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r * 255;
}

- (uint32_t)green {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g * 255;
}

- (uint32_t)blue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b * 255;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

@end
