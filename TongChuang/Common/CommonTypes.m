//
//  CommonTypes.m
//  TongChuang
//
//  Created by cuixiang on 15/8/2.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "CommonTypes.h"

@implementation GenderInfo

+ (NSString *)genderName:(GenderType)genderType {
    switch (genderType) {
        case Male:
            return @"男";
            break;
        case Female:
            return @"女";
            break;
    }
}

@end

@implementation DegreeInfo

+ (NSString *)degreeName:(DegreeType)degreeType {
    switch (degreeType) {
        case Doctor:
            return @"博士";
            break;
        case Master:
            return @"硕士";
            break;
        case Bachelor:
            return @"本科";
    }
}

+ (NSUInteger)degree:(NSString *)degreeName {
    if ([degreeName isEqualToString:@"博士"]) {
        return Doctor;
    } else if ([degreeName isEqualToString:@"硕士"]) {
        return Master;
    } else if ([degreeName isEqualToString:@"本科"]) {
        return Bachelor;
    }
    return 0;
}

+ (NSInteger)stepCount:(DegreeType)highestDegree {
    switch (highestDegree) {
        case Doctor:
            return 4;
            break;
        case Master:
            return 3;
            break;
        case Bachelor:
            return 2;
        default:
            return 1;
    }
}

+ (NSInteger)currentStep:(NSInteger)currentDegree HighestDegree:(DegreeType)highestDegree {
    if (highestDegree == Doctor) {
        if (currentDegree == Doctor) {
            return 0;
        } else if (currentDegree == Master) {
            return 1;
        } else if (currentDegree == Bachelor) {
            return 2;
        } else {
            return 3;
        }
    } else if (highestDegree == Master) {
        if (currentDegree == Master) {
            return 0;
        } else if (currentDegree == Bachelor) {
            return 1;
        } else {
            return 2;
        }
    } else if (highestDegree == Bachelor) {
        if (currentDegree == Bachelor) {
            return 0;
        } else {
            return 1;
        }
    }
    
    return 0;
}

@end

@implementation GroupInfo


@end

@implementation CircleInfo


@end

@implementation PersonInfo


@end