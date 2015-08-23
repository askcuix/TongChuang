//
//  AudioUtil.h
//  TongChuang
//
//  Created by cuixiang on 15/8/23.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioUtil : NSObject

+ (SystemSoundID)createSoundID:(NSString *)name type:(NSString *)type;
+ (void)playVoice:(NSString *)name type:(NSString *)type;
+ (void)playVoice:(SystemSoundID)soundID;
+ (void)playVoice:(NSString *)name type:(NSString *)type withVibrate:(BOOL)vibrate;
+ (void)playVoice:(SystemSoundID)soundID withVibrate:(BOOL)vibrate;
+ (void)playVibrate;

@end
