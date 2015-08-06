//
//  SettingModel.h
//  TongChuang
//
//  Created by cuixiang on 15/7/27.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kUserGuideShowedKey;
extern NSString * const kAccountKey;
extern NSString * const kUidKey;

@interface SettingModel : NSObject

+ (SettingModel *)sharedInstance;

- (void)setObject:(id)value forKey:(NSString *)name;
- (id)objectForKey:(NSString *)name;
- (void)removeObjectForKey:(NSString *)name;

- (void)setInteger:(NSInteger)value forKey:(NSString *)name;
- (NSInteger)integerForKey:(NSString *)name;

- (void)setBool:(BOOL)value forKey:(NSString *)name;
- (BOOL)boolForKey:(NSString *)name;

- (void)synchronize;

@end
