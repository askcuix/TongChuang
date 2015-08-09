//
//  FailedMessageStore.m
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "FailedMessageStore.h"
#import <FMDB/FMDB.h>

#define kFaildMessageStoreLogKey @"[Faild Chat DB]"

#define kFaildMessageTable @"failed_messages"
#define kKeyId @"id"
#define kKeyConversationId @"conversationId"
#define kKeyMessage @"message"

#define kCreateTableSQL                                       \
    @"CREATE TABLE IF NOT EXISTS " kFaildMessageTable @"("    \
        kKeyId @" VARCHAR(63) PRIMARY KEY, "                  \
        kKeyConversationId @" VARCHAR(63) NOT NULL,"          \
        kKeyMessage @" BLOB NOT NULL"                         \
    @")"

#define kWhereConversationId \
    @" WHERE " kKeyConversationId @" = ? "

#define kSelectMessagesSQL                        \
    @"SELECT * FROM " kFaildMessageTable          \
    kWhereConversationId

#define kInsertMessageSQL                             \
    @"INSERT OR IGNORE INTO " kFaildMessageTable @"(" \
        kKeyId @","                                   \
        kKeyConversationId @","                       \
        kKeyMessage                                   \
    @") values (?, ?, ?) "                            \

#define kDeleteMessageSQL                             \
    @"DELETE FROM " kFaildMessageTable @" "           \
    @"WHERE " kKeyId " = ? "                          \

@interface FailedMessageStore ()

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

@end

@implementation FailedMessageStore

+ (FailedMessageStore *)store {
    static FailedMessageStore *manager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[FailedMessageStore alloc] init];
    });
    return manager;
}

- (void)setupStoreWithDatabasePath:(NSString *)path {
    if (self.databaseQueue) {
        NSLog(@"%@database queue not nil !!!!", kFaildMessageStoreLogKey);
    }
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:kCreateTableSQL];
    }];
}

- (NSDictionary *)recordFromResultSet:(FMResultSet *)resultSet {
    NSMutableDictionary *record = [NSMutableDictionary dictionary];
    NSData *data = [resultSet dataForColumn:kKeyMessage];
    AVIMTypedMessage *message = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [record setObject:message forKey:kKeyMessage];
    [record setObject:[resultSet stringForColumn:kKeyId] forKey:kKeyId];
    return record;
}

- (NSArray *)recordsByConversationId:(NSString *)conversationId {
    NSMutableArray *records = [NSMutableArray array];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:kSelectMessagesSQL, conversationId];
        while ([resultSet next]) {
            [records addObject:[self recordFromResultSet:resultSet]];
        }
        [resultSet close];
    }];
    return records;
}

- (NSArray *)selectFailedMessagesByConversationId:(NSString *)conversationId {
    NSArray *records = [self recordsByConversationId:conversationId];
    NSMutableArray *messages = [NSMutableArray array];
    for (NSDictionary *record in records) {
        [messages addObject:record[kKeyMessage]];
    }
    return messages;
}

- (BOOL)deleteFailedMessageByRecordId:(NSString *)recordId {
    __block BOOL result;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:kDeleteMessageSQL, recordId];
    }];
    return result;
}

- (void)insertFailedMessage:(AVIMTypedMessage *)message {
    if (message.conversationId == nil) {
        [NSException raise:@"conversationId is nil" format:nil];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:message];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:kInsertMessageSQL,message.messageId, message.conversationId, data];
    }];
}

@end
