//
//  SettingModel.m
//  TongChuang
//
//  Created by cuixiang on 15/7/27.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "SettingModel.h"

NSString * const kUserGuideShowedKey = @"UserGuideShowed";
NSString * const kAccountKey = @"Account";
NSString * const kUidKey = @"Uid";

@implementation SettingModel

+ (SettingModel *)sharedInstance {
    static SettingModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SettingModel alloc] init];
    });
    
    return instance;
}

#pragma mark - NSUserDefaults operations
- (void)setObject:(id)value forKey:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:name];
}

- (id)objectForKey:(NSString *)name {
    return [[NSUserDefaults standardUserDefaults] objectForKey:name];
}

- (void)removeObjectForKey:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:name];
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:name];
}

- (NSInteger)integerForKey:(NSString *)name {
    return [[NSUserDefaults standardUserDefaults] integerForKey:name];
}

- (void)setBool:(BOOL)value forKey:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:name];
}

- (BOOL)boolForKey:(NSString *)name {
    return [[NSUserDefaults standardUserDefaults] boolForKey:name];
}

- (void)synchronize {
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
