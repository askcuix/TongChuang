//
//  UserModel.m
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "UserModel.h"
#import "ChatUserModel.h"
#import "CacheManager.h"

@implementation UserModel

#pragma mark - ChatUserDelegate
- (void)cacheUserByIds:(NSSet *)userIds block:(AVBooleanResultBlock)block {
    [[CacheManager manager] cacheUsersWithIds:userIds callback:block];
}

- (ChatUserModel *)getUserById:(NSString *)userId {
    ChatUserModel *chatUser = [[CacheManager manager] lookupChatUser:userId];
    if (!chatUser) {
        chatUser = [[ChatUserModel alloc] init];
        //TODO: find user
    }
    
    chatUser.userId = userId;
    chatUser.username = userId;
    chatUser.avatarUrl = @"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg";
    
    return chatUser;
}

@end
