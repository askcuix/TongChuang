//
//  CommonTypes.h
//  TongChuang
//
//  Created by cuixiang on 15/8/2.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GenderType) {
    Male    = 0,
    Female  = 1,
};

typedef NS_ENUM(NSUInteger, DegreeType) {
    Doctor      = 1,
    Master      = 2,
    Bachelor    = 3,
};

@interface GenderInfo : NSObject

+ (NSString *)genderName:(GenderType)genderType;

@end

@interface DegreeInfo : NSObject

+ (NSString *)degreeName:(DegreeType)degreeType;
+ (NSUInteger)degree:(NSString *)degreeName;
+ (NSInteger)stepCount:(DegreeType)highestDegree;
+ (NSInteger)currentStep:(NSInteger)currentDegree HighestDegree:(DegreeType)highestDegree;

@end

@interface GroupInfo : NSObject

@property (nonatomic, assign) NSInteger gid;
@property (nonatomic, strong) NSString *name;

@end

@interface CircleInfo : NSObject

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, strong) NSString *name;

@end

@interface PersonInfo : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *schoolName;

@end