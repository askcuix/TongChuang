//
//  ChatSoundManager.m
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ChatSoundManager.h"
#import "AudioUtil.h"

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
        
        _loudReceiveSound = [AudioUtil createSoundID:@"loudReceive" type:@"caf"];
        _sendSound = [AudioUtil createSoundID:@"send" type:@"caf"];
        _receiveSound = [AudioUtil createSoundID:@"receive" type:@"caf"];
    }
    return self;
}

- (void)playSendSoundIfNeed {
    if (self.needPlaySoundWhenChatting) {
        [AudioUtil playVoice:_sendSound];
    }
}

- (void)playReceiveSoundIfNeed {
    if (self.needPlaySoundWhenChatting) {
        [AudioUtil playVoice:_receiveSound];
    }
}

- (void)playLoudReceiveSoundIfNeed {
    if (self.needPlaySoundWhenNotChatting) {
        [AudioUtil playVoice:_loudReceiveSound];
    }
}

- (void)vibrateIfNeed {
    if (self.needVibrateWhenNotChatting) {
        [AudioUtil playVibrate];
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
