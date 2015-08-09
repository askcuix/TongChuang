//
//  CommonDefs.h
//  TongChuang
//
//  Created by cuixiang on 15/7/14.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#ifndef TongChuang_CommonDefs_h
#define TongChuang_CommonDefs_h

//LeanCloud
#define AVOSAppID @"do8qpysrpacvs6a1lxazt59yrmfr8eq6m530yi65r6s46b4q"
#define AVOSAppKey @"hkwdojx6u4ks39a7l60orfm2qo4gqnrq4xhgpo9z9hhvpe9c"

//path definition
#define fProfileDir @"profile"
#define fAvatarName @"avatar.png"

//picker data definition
#define kPickerFirstComponent 0
#define kPickerSecondComponent 1

//color utility
#define RGBCOLOR(r, g, b) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : 1]
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : (a)]
#define UIColorFromRGB(rgb) [UIColor colorWithRed : ((rgb) & 0xFF0000 >> 16) / 255.0 green : ((rgb) & 0xFF00 >> 8) / 255.0 blue : ((rgb) & 0xFF) / 255.0 alpha : 1.0]

//screen size
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//system
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define WEAKSELF __weak typeof(self) weakSelf = self;

#endif
