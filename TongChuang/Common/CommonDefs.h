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

//screen size
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//system
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define WEAKSELF __weak typeof(self) weakSelf = self;

#endif
