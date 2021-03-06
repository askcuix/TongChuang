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
+ (NSString *)simpleDegreeName:(DegreeType)degreeType;
+ (NSUInteger)degree:(NSString *)degreeName;
+ (NSInteger)stepCount:(DegreeType)highestDegree;
+ (NSInteger)currentStep:(NSInteger)currentDegree HighestDegree:(DegreeType)highestDegree;

@end

@interface GroupInfo : NSObject

@property (nonatomic, assign) NSInteger gid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) DegreeType degree;

@end

@interface CircleInfo : NSObject

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) DegreeType degree;

@end

@interface UserInfo : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *schoolName;

@end

@interface UserProfile : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, assign) DegreeType highestDegree;
@property (nonatomic, strong) NSArray *eduInfo;

@end

@interface EducationInfo : NSObject

@property (nonatomic, assign) DegreeType degree;
@property (nonatomic, strong) NSString *schooleName;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSDate *startTime;


@end