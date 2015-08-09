//
//  CacheManager.m
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "CacheManager.h"

@interface CacheManager ()

@property (nonatomic, strong) NSCache *userCache;

@end

@implementation CacheManager

+ (instancetype)manager {
    static CacheManager *cacheManager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        cacheManager = [[CacheManager alloc] init];
    });
    return cacheManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _userCache = [[NSCache alloc] init];
    }
    return self;
}

#pragma mark - chat user cache
- (ChatUserModel *)lookupChatUser:(NSString *)userId {
    return [self.userCache objectForKey:userId];
}

- (void)registerUsers:(NSArray *)users {
    for (ChatUserModel *user in users) {
        [self.userCache setObject:user forKey:user.userId];
    }
}

- (void)cacheUsersWithIds:(NSSet *)userIds callback:(CacheResultBlock)callback {
    NSMutableSet *uncachedUserIds = [[NSMutableSet alloc] init];
    for (NSString *userId in userIds) {
        if ([[CacheManager manager] lookupChatUser:userId] == nil) {
            [uncachedUserIds addObject:userId];
        }
    }
    
    if ([uncachedUserIds count] > 0) {
        //TODO: find users
        //[[CacheManager manager] registerUsers:users];
        callback(YES, nil);
    } else {
        callback(YES, nil);
    }
}

@end
