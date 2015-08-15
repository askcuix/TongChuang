//
//  CacheManager.h
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonTypes.h"

typedef void (^CacheResultBlock)(BOOL succeeded, NSError *error);

@interface CacheManager : NSObject

+ (instancetype)manager;

- (UserInfo *)lookupChatUser:(NSString *)userId;
- (void)registerUsers:(NSArray *)users;
- (void)cacheUsersWithIds:(NSSet *)userIds callback:(CacheResultBlock)callback;

@end
