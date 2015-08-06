//
//  FileUtil.m
//  TongChuang
//
//  Created by cuixiang on 15/7/18.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

+ (BOOL)isFileExists:(NSString *)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (BOOL)createFilePath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (NSString *)getCacheDirectory {
    static NSString *cacheDirectory = nil;
    do {
        if (cacheDirectory) {
            break;
        }
        
        NSArray *directories = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        if ([directories count] < 1) {
            break;
        }
        
        cacheDirectory = [directories objectAtIndex:0];
        
        NSUInteger length = [cacheDirectory length];
        if (length < 1) {
            cacheDirectory = nil;
            break;
        }
        
        if ('/' == [cacheDirectory characterAtIndex:length - 1]) {
            break;
        }
        
        cacheDirectory = [cacheDirectory stringByAppendingString:@"/"];
    } while (false);
    
    return cacheDirectory;
}

+ (NSString *)getCacheDirectory:(NSString *)directoryName {
    NSString *cacheDirectory = [FileUtil getCacheDirectory];
    if (!cacheDirectory) {
        return nil;
    }
    
    cacheDirectory = [cacheDirectory stringByAppendingString:directoryName];
    
    if ('/' == [cacheDirectory characterAtIndex:[cacheDirectory length] - 1]) {
        cacheDirectory = [cacheDirectory stringByAppendingString:@"/"];
    }
    
    return cacheDirectory;
}

+ (NSString *)getDocumentDirectory {
    static NSString *documentDirectory = nil;
    do {
        
        if (documentDirectory) {
            break;
        }
        
        NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        if ([directories count] < 1) {
            break;
        }
        
        documentDirectory = [directories objectAtIndex:0];
        
        NSUInteger length = [documentDirectory length];
        if (length < 1) {
            documentDirectory = nil;
            break;
        }
        
        if ('/' == [documentDirectory characterAtIndex:length - 1]) {
            break;
        }
        
        documentDirectory = [documentDirectory stringByAppendingString:@"/"];
    } while (false);
    
    return documentDirectory;
}

+ (NSString *)getDocumentDirectory:(NSString *)directoryName {
    NSString *documentDirectory = [FileUtil getDocumentDirectory];
    if (!documentDirectory) {
        return nil;
    }
    
    documentDirectory = [documentDirectory stringByAppendingString:directoryName];
    if ('/' != [documentDirectory characterAtIndex:[documentDirectory length] - 1]) {
        documentDirectory = [documentDirectory stringByAppendingString:@"/"];
    }
    
    return documentDirectory;
}

+ (BOOL)writeFile:(NSString *)filePath data:(NSData *)fileData {
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager createFileAtPath:filePath contents:fileData attributes:nil];
}

+ (BOOL)moveFile:(NSString *)oldFilePath to:(NSString *)newFilePath {
    NSError *error = nil;
    
    if(![[NSFileManager defaultManager] moveItemAtPath:oldFilePath toPath:newFilePath error:&error]) {
        NSLog(@"Move file[%@] to [%@] error: %@", oldFilePath, newFilePath, error);
        return NO;
    }
    return  YES;
}

+ (BOOL)copyFile:(NSString *)oldFilePath to:(NSString *)newFilePath {
    NSError *error = nil;
    
    if(![[NSFileManager defaultManager] copyItemAtPath:oldFilePath toPath:newFilePath error:&error]) {
        NSLog(@"Copy file[%@] to [%@] error: %@", oldFilePath, newFilePath, error);
        return NO;
    }
    return  YES;
}

+ (BOOL)removeFile:(NSString *)filePath {
    if (!filePath) {
        return NO;
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        return NO;
    }
    
    NSError *error = nil;
    if (![manager removeItemAtPath:filePath error:&error]) {
        NSLog(@"Remove file[%@] error: %@", filePath, error);
        return NO;
    }
    
    return YES;
}

@end
