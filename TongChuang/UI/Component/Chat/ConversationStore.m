//
//  ConversationStore.m
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ConversationStore.h"
#import <FMDB/FMDB.h>
#import "AVIMConversation+Custom.h"

#define kConversationStoreLogKey @"[Chat DB]"

#define kConversationTableName @"conversations"

#define kConversationTableKeyId @"id"
#define kConversationTableKeyData @"data"
#define kConversationTableKeyUnreadCount @"unreadCount"
#define kConversationTableKeyMentioned @"mentioned"

#define kConversatoinTableCreateSQL                                       \
    @"CREATE TABLE IF NOT EXISTS " kConversationTableName @" ("           \
        kConversationTableKeyId           @" VARCHAR(63) PRIMARY KEY, "   \
        kConversationTableKeyData         @" BLOB NOT NULL, "             \
        kConversationTableKeyUnreadCount  @" INTEGER DEFAULT 0, "         \
        kConversationTableKeyMentioned    @" BOOL DEFAULT FALSE "         \
    @")"

#define kConversationTableInsertSQL                           \
    @"INSERT OR IGNORE INTO " kConversationTableName @" ("    \
        kConversationTableKeyId               @", "           \
        kConversationTableKeyData             @", "           \
        kConversationTableKeyUnreadCount      @", "           \
        kConversationTableKeyMentioned                        \
    @") VALUES(?, ?, ?, ?)"

#define kConversationTableWhereClause                         \
    @" WHERE " kConversationTableKeyId         @" = ?"

#define kConversationTableDeleteSQL                           \
    @"DELETE FROM " kConversationTableName                    \
    kConversationTableWhereClause

#define kConversationTableIncreaseUnreadCountSQL              \
    @"UPDATE " kConversationTableName         @" "            \
    @"SET " kConversationTableKeyUnreadCount  @" = "          \
            kConversationTableKeyUnreadCount  @" + 1 "        \
    kConversationTableWhereClause

#define kConversationTableUpdateUnreadCountSQL                \
    @"UPDATE " kConversationTableName         @" "            \
    @"SET " kConversationTableKeyUnreadCount  @" = ? "        \
    kConversationTableWhereClause

#define kConversationTableUpdateMentionedSQL                  \
    @"UPDATE " kConversationTableName         @" "            \
    @"SET " kConversationTableKeyMentioned    @" = ? "        \
    kConversationTableWhereClause

#define kConversationTableSelectSQL                           \
    @"SELECT * FROM " kConversationTableName                  \

#define kConversationTableSelectOneSQL                        \
    @"SELECT * FROM " kConversationTableName                  \
    kConversationTableWhereClause

#define kConversationTableUpdateDataSQL                       \
    @"UPDATE " kConversationTableName @" "                    \
    @"SET " kConversationTableKeyData @" = ? "                \
    kConversationTableWhereClause                             \

@interface ConversationStore ()

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

@end

@implementation ConversationStore

+ (ConversationStore *)store {
    static ConversationStore *manager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[ConversationStore alloc] init];
    });
    return manager;
}

- (void)setupStoreWithDatabasePath:(NSString *)path {
    if (self.databaseQueue) {
        NSLog(@"%@database queue not nil !!!!", kConversationStoreLogKey);
    }
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:kConversatoinTableCreateSQL];
    }];
}

#pragma mark - conversations local data
- (NSData *)dataFromConversation:(AVIMConversation *)conversation {
    AVIMKeyedConversation *keydConversation = [conversation keyedConversation];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:keydConversation];
    return data;
}

- (AVIMConversation *)conversationFromData:(NSData *)data{
    AVIMKeyedConversation *keyedConversation = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return [[AVIMClient defaultClient] conversationWithKeyedConversation:keyedConversation];
}

- (void)updateUnreadCountToZeroWithConversation:(AVIMConversation *)conversation {
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:kConversationTableUpdateUnreadCountSQL withArgumentsInArray:@[@0, conversation.conversationId]];
    }];
}

- (void)deleteConversation:(AVIMConversation *)conversation {
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:kConversationTableDeleteSQL withArgumentsInArray:@[conversation.conversationId]];
    }];
}

- (void)insertConversation:(AVIMConversation *)conversation {
    if (conversation.creator == nil) {
        return;
    }
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSData *data = [self dataFromConversation:conversation];
        [db executeUpdate:kConversationTableInsertSQL withArgumentsInArray:@[conversation.conversationId, data, @0, @(NO)]];
    }];
}

- (BOOL)isConversationExists:(AVIMConversation *)conversation {
    __block BOOL exists = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:kConversationTableSelectOneSQL withArgumentsInArray:@[conversation.conversationId]];
        if ([resultSet next]) {
            exists = YES;
        }
        [resultSet close];
    }];
    return exists;
}

- (void)increaseUnreadCountWithConversation:(AVIMConversation *)conversation {
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:kConversationTableIncreaseUnreadCountSQL withArgumentsInArray:@[conversation.conversationId]];
    }];
}

- (void)updateMentioned:(BOOL)mentioned conversation:(AVIMConversation *)conversation {
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:kConversationTableUpdateMentionedSQL withArgumentsInArray:@[@(mentioned), conversation.conversationId]];
    }];
}

- (AVIMConversation *)createConversationFromResultSet:(FMResultSet *)resultSet {
    NSData *data = [resultSet dataForColumn:kConversationTableKeyData];
    NSInteger unreadCount = [resultSet intForColumn:kConversationTableKeyUnreadCount];
    BOOL mentioned = [resultSet boolForColumn:kConversationTableKeyMentioned];
    AVIMConversation *conversation = [self conversationFromData:data];
    conversation.unreadCount = unreadCount;
    conversation.mentioned = mentioned;
    return conversation;
}

- (NSArray *)selectAllConversations {
    NSMutableArray *conversations = [NSMutableArray array];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:kConversationTableSelectSQL withArgumentsInArray:@[]];
        while ([resultSet next]) {
            [conversations addObject:[self createConversationFromResultSet:resultSet]];
        }
        [resultSet close];
    }];
    return conversations;
}

- (void)updateConversations:(NSArray *)conversations {
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        for (AVIMConversation *conversation in conversations) {
            [db executeUpdate:kConversationTableUpdateDataSQL, [self dataFromConversation:conversation], conversation.conversationId];
        }
        [db commit];
    }];
}

@end
