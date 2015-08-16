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

- (void)getFriendsWithBlock:(void (^)(NSArray *objects, NSError *error))friendsBlock;

- (void)removeFriend:(UserInfo *)user callback:(void (^)(BOOL succeeded, NSError *error))callback;

- (void)findAddRequestsWithBlock:(void (^)(NSArray *objects, NSError *error))friendsBlock;

- (void)markAddRequestsRead:(NSArray *)addRequests block:(void (^)(BOOL succeeded, NSError *error))markBlock;

- (void)agreeAddRequest:(NSInteger)uid callback:(void (^)(BOOL succeeded, NSError *error))callback;

- (void)addUser:(NSInteger)uid callback:(void (^)(BOOL succeeded, NSError *error))callback;

- (void)findUser:(NSInteger)uid callback:(void (^)(UserProfile *user, NSError *error))callback;

- (void)isFriend:(NSInteger)uid callback:(void (^)(BOOL isFriend, NSError *error))callback;

@end
