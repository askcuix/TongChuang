//
//  UserModel.m
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "UserModel.h"
#import "CommonTypes.h"
#import "CacheManager.h"

@implementation UserModel

- (void)countUnreadAddRequestsWithBlock:(void (^)(NSInteger, NSError *))unreadBlock {
    unreadBlock(1, nil);
}

- (void)findFriendsWithBlock:(void (^)(NSArray *, NSError *))findFriendBlock {
    findFriendBlock([NSMutableArray array], nil);
}

- (void)removeFriend:(UserInfo *)user callback:(void (^)(BOOL succeeded, NSError *error))callback {
    //TODO: unfollow
}

#pragma mark - ChatUserDelegate
- (void)cacheUserByIds:(NSSet *)userIds block:(AVBooleanResultBlock)block {
    [[CacheManager manager] cacheUsersWithIds:userIds callback:block];
}

- (UserInfo *)getUserById:(NSString *)userId {
    UserInfo *chatUser = [[CacheManager manager] lookupChatUser:userId];
    if (!chatUser) {
        chatUser = [[UserInfo alloc] init];
        //TODO: find user
    }
    
    chatUser.uid = [userId integerValue];
    chatUser.name = userId;
    chatUser.avatarUrl = @"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg";
    
    return chatUser;
}

@end
