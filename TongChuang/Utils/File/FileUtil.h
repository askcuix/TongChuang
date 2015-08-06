//
//  FileUtil.h
//  TongChuang
//
//  Created by cuixiang on 15/7/18.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

+ (BOOL)isFileExists:(NSString *)filePath;

+ (BOOL)createFilePath:(NSString *)filePath;

+ (NSString *)getCacheDirectory;
+ (NSString *)getCacheDirectory:(NSString *)directoryName;
+ (NSString *)getDocumentDirectory;
+ (NSString *)getDocumentDirectory:(NSString *)directoryName;

+ (BOOL)writeFile:(NSString *)filePath data:(NSData *)fileData;

+ (BOOL)moveFile:(NSString *)oldFilePath to:(NSString *)newFilePath;

+ (BOOL)copyFile:(NSString *)oldFilePath to:(NSString *)newFilePath;

+ (BOOL)removeFile:(NSString*)filePath;

@end
