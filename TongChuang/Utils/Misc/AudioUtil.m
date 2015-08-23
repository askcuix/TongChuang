//
//  AudioUtil.m
//  TongChuang
//
//  Created by cuixiang on 15/8/23.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "AudioUtil.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation AudioUtil

+ (SystemSoundID)createSoundID:(NSString *)name type:(NSString *)type {
    SystemSoundID soundID;
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if(path != nil){
        OSStatus errorCode = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&soundID);
        
        if (errorCode != 0) {
            NSLog(@"Create sound[%@.%@] failed.", name, type);
        }
    }
    
    return soundID;
}

+ (void)playVoice:(NSString *)name type:(NSString *)type {
    static int nLastTime = 0;
    int nCurTime = [[NSDate date] timeIntervalSince1970];
    if( nCurTime - nLastTime < 1 && nLastTime != 0 ) {
        nLastTime = nCurTime;
        return;
    }
    
    nLastTime = nCurTime;
    
    SystemSoundID soundID = [AudioUtil createSoundID:name type:type];
    if (soundID) {
        AudioServicesPlaySystemSound(soundID);
    }
}

+ (void)playVoice:(SystemSoundID)soundID {
    static int nLastTime = 0;
    int nCurTime = [[NSDate date] timeIntervalSince1970];
    if( nCurTime - nLastTime < 1 && nLastTime != 0 ) {
        nLastTime = nCurTime;
        return;
    }
    
    nLastTime = nCurTime;
    
    if (soundID) {
        AudioServicesPlaySystemSound(soundID);
    }
}

+ (void)playVoice:(NSString *)name type:(NSString *)type withVibrate:(BOOL)vibrate {
    [AudioUtil playVoice:name type:type];
    
    if (vibrate) {
        [AudioUtil playVibrate];
    }
}

+ (void)playVoice:(SystemSoundID)soundID withVibrate:(BOOL)vibrate {
    [AudioUtil playVoice:soundID];
    
    if (vibrate) {
        [AudioUtil playVibrate];
    }
}

+ (void)playVibrate {
    static int nLastTime = 0;
    int nCurTime = [[NSDate date] timeIntervalSince1970];
    if( nCurTime - nLastTime < 1 && nLastTime != 0 ) {
        nLastTime = nCurTime;
        return;
    }
    
    nLastTime = nCurTime;
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
