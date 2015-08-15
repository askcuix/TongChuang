//
//  UserModel.h
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatManager.h"

@interface UserModel : NSObject <ChatUserDelegate>

- (void)countUnreadAddRequestsWithBlock:(void (^)(NSInteger number, NSError *error))unreadBlock;

- (void)findFriendsWithBlock:(void (^)(NSArray *objects, NSError *error))findFriendBlock;

- (void)removeFriend:(UserInfo *)user callback:(void (^)(BOOL succeeded, NSError *error))callback;

@end
