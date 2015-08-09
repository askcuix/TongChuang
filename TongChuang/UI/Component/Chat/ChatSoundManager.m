//
//  ChatSoundManager.m
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ChatSoundManager.h"
#import <AudioToolbox/AudioToolbox.h>

#define kPlaySoundWhenNotChattingKey @"needPlaySoundWhenNotChatting"
#define kPlaySoundWhenChattingKey @"needPlaySoundWhenChatting"
#define kVibrateWhenNotChattingKey @"needVibrateWhenNotChatting"

@interface ChatSoundManager ()

@property (nonatomic, assign) SystemSoundID loudReceiveSound;
@property (nonatomic, assign) SystemSoundID sendSound;
@property (nonatomic, assign) SystemSoundID receiveSound;

@end

@implementation ChatSoundManager

+ (ChatSoundManager *)manager {
    static ChatSoundManager *soundManager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        soundManager = [[ChatSoundManager alloc] init];
    });
    return soundManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaultSettings];
        self.needPlaySoundWhenChatting =  [[[NSUserDefaults standardUserDefaults] objectForKey:kPlaySoundWhenChattingKey] boolValue];
        self.needPlaySoundWhenNotChatting  = [[[NSUserDefaults standardUserDefaults] objectForKey:kPlaySoundWhenNotChattingKey] boolValue];
        self.needVibrateWhenNotChatting = [[[NSUserDefaults standardUserDefaults] objectForKey:kVibrateWhenNotChattingKey] boolValue];
        
        [self createSoundWithName:@"loudReceive" soundId:&_loudReceiveSound];
        [self createSoundWithName:@"send" soundId:&_sendSound];
        [self createSoundWithName:@"receive" soundId:&_receiveSound];
    }
    return self;
}

- (void)createSoundWithName:(NSString *)name soundId:(SystemSoundID *)soundId {
    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:@"caf"];
    OSStatus errorCode = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url) , soundId);
    if (errorCode != 0) {
        NSLog(@"create sound failed");
    }
}

- (void)playSendSoundIfNeed {
    if (self.needPlaySoundWhenChatting) {
        AudioServicesPlaySystemSound(_sendSound);
    }
}

- (void)playReceiveSoundIfNeed {
    if (self.needPlaySoundWhenChatting) {
        AudioServicesPlaySystemSound(_receiveSound);
    }
}

- (void)playLoudReceiveSoundIfNeed {
    if (self.needPlaySoundWhenNotChatting) {
        AudioServicesPlaySystemSound(_loudReceiveSound);
    }
}

- (void)vibrateIfNeed {
    if (self.needVibrateWhenNotChatting) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

#pragma mark - local data
- (void)setNeedPlaySoundWhenChatting:(BOOL)needPlaySoundWhenChatting {
    _needPlaySoundWhenChatting = needPlaySoundWhenChatting;
    [[NSUserDefaults standardUserDefaults] setObject:@(self.needPlaySoundWhenChatting) forKey:kPlaySoundWhenChattingKey];
}

- (void)setNeedPlaySoundWhenNotChatting:(BOOL)needPlaySoundWhenNotChatting {
    _needPlaySoundWhenNotChatting = needPlaySoundWhenNotChatting;
    [[NSUserDefaults standardUserDefaults] setObject:@(self.needPlaySoundWhenNotChatting) forKey:kPlaySoundWhenNotChattingKey];
}

- (void)setNeedVibrateWhenNotChatting:(BOOL)needVibrateWhenNotChatting {
    _needVibrateWhenNotChatting = needVibrateWhenNotChatting;
    [[NSUserDefaults standardUserDefaults] setObject:@(self.needVibrateWhenNotChatting) forKey:kVibrateWhenNotChattingKey];
}

- (void)setDefaultSettings {
    // initialize default settings
    NSDictionary *defaultSettings = @{kPlaySoundWhenChattingKey : @YES,
                                      kPlaySoundWhenNotChattingKey : @YES,
                                      kVibrateWhenNotChattingKey : @YES};
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultSettings];
}

@end
