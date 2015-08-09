//
//  CacheManager.h
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatUserModel.h"

typedef void (^CacheResultBlock)(BOOL succeeded, NSError *error);

@interface CacheManager : NSObject

+ (instancetype)manager;

- (ChatUserModel *)lookupChatUser:(NSString *)userId;
- (void)registerUsers:(NSArray *)users;
- (void)cacheUsersWithIds:(NSSet *)userIds callback:(CacheResultBlock)callback;

@end
