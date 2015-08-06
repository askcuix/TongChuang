//
//  FileModel.h
//  TongChuang
//
//  Created by cuixiang on 15/7/18.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

- (void)createRequiredPath;

- (BOOL)writeFile:(NSString *)filePath data:(NSData *)fileData;

- (NSString *)getProfilePath;
- (NSString *)getAvatarPath;
- (BOOL)isAvatarExists;

@end
