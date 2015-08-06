//
//  FileModel.m
//  TongChuang
//
//  Created by cuixiang on 15/7/18.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "CommonDefs.h"
#import "FileModel.h"
#import "FileUtil.h"

@implementation FileModel

- (void)createRequiredPath {
    //profile path
    NSString *profilePath = [FileUtil getDocumentDirectory:fProfileDir];
    if ([FileUtil isFileExists:profilePath] == NO) {
        [FileUtil createFilePath:profilePath];
        NSLog(@"Created profile path: %@", profilePath);
    }
}

- (BOOL)writeFile:(NSString *)filePath data:(NSData *)fileData {
    return [FileUtil writeFile:filePath data:fileData];
}

- (NSString *)getProfilePath {
    return [FileUtil getDocumentDirectory:fProfileDir];
}

- (NSString *)getAvatarPath {
    return [self.getProfilePath stringByAppendingString:fAvatarName];
}

- (BOOL)isAvatarExists {
    NSString *avatar = [self getAvatarPath];
    return [FileUtil isFileExists:avatar];
}

@end
