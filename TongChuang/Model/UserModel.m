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

@interface UserModel ()

@property (nonatomic, strong) NSArray *friends;

@end

@implementation UserModel

- (instancetype)init {
    if (self = [super init]) {
        UserInfo *user1 = [[UserInfo alloc] init];
        user1.uid = 1001;
        user1.name = @"阮威";
        user1.avatarUrl = @"http://c.hiphotos.baidu.com/image/pic/item/6a600c338744ebf860f09e3ddbf9d72a6059a72b.jpg";
        user1.schoolName = @"华中科技大学";
        
        UserInfo *user2 = [[UserInfo alloc] init];
        user2.uid = 1002;
        user2.name = @"吴晓彤";
        user2.avatarUrl = @"http://d.hiphotos.baidu.com/image/pic/item/960a304e251f95ca821dc4becb177f3e660952c9.jpg";
        user2.schoolName = @"广东美院";
        
        UserInfo *user3 = [[UserInfo alloc] init];
        user3.uid = 1003;
        user3.name = @"江成彦";
        user3.avatarUrl = @"http://d.hiphotos.baidu.com/image/pic/item/3801213fb80e7bece74afce12d2eb9389b506b1a.jpg";
        user3.schoolName = @"广东农业大学";
        
        UserInfo *user4 = [[UserInfo alloc] init];
        user4.uid = 1004;
        user4.name = @"邱展佳";
        user4.avatarUrl = @"http://g.hiphotos.baidu.com/image/pic/item/3b292df5e0fe992552b6f68935a85edf8cb171b5.jpg";
        user4.schoolName = @"中山大学";
        
        UserInfo *user5 = [[UserInfo alloc] init];
        user5.uid = 1005;
        user5.name = @"李如虎";
        user5.avatarUrl = @"http://a.hiphotos.baidu.com/image/pic/item/0df3d7ca7bcb0a46aa4d57306963f6246b60af48.jpg";
        user5.schoolName = @"湖南大学";
        
        _friends = @[user1, user2, user3, user4, user5];
    }
    
    return self;
}

- (void)countUnreadAddRequestsWithBlock:(void (^)(NSInteger, NSError *))unreadBlock {
    unreadBlock(1, nil);
}

- (void)getFriendsWithBlock:(void (^)(NSArray *objects, NSError *error))friendsBlock {
    friendsBlock(_friends, nil);
}

- (void)removeFriend:(UserInfo *)user callback:(void (^)(BOOL succeeded, NSError *error))callback {
    //TODO: unfollow
}

- (void)findAddRequestsWithBlock:(void (^)(NSArray *objects, NSError *error))friendsBlock {
    friendsBlock(_friends, nil);
}

- (void)markAddRequestsRead:(NSArray *)addRequests block:(void (^)(BOOL, NSError *))markBlock {
    markBlock(YES, nil);
}

- (void)agreeAddRequest:(NSInteger)uid callback:(void (^)(BOOL, NSError *))callback {
    callback(YES, nil);
}

- (void)addUser:(NSInteger)uid callback:(void (^)(BOOL, NSError *))callback {
    callback(YES, nil);
}

- (void)findUser:(NSInteger)uid callback:(void (^)(UserProfile *, NSError *))callback {
    UserProfile *user = [[UserProfile alloc] init];
    
    for (UserInfo *info in _friends) {
        if (info.uid == uid) {
            user.uid = info.uid;
            user.name = info.name;
            user.avatarUrl = info.avatarUrl;
            
            break;
        }
    }
    
    user.location = @"广东 广州";
    user.highestDegree = Master;
    
    EducationInfo *eduInfo = [[EducationInfo alloc] init];
    eduInfo.degree = Master;
    eduInfo.schooleName = @"广东财经大学";
    eduInfo.major = @"国际经济法";
    eduInfo.className = @"一班";
    eduInfo.startTime = [NSDate date];
    
    user.eduInfo = @[eduInfo];
    
    callback(user, nil);
}

- (void)isFriend:(NSInteger)uid callback:(void (^)(BOOL, NSError *))callback {
    BOOL isFriend = NO;
    
    if (uid == 1001 || uid == 1002 || uid == 1003) {
        isFriend = YES;
    }
    
    callback(isFriend, nil);
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
