//
//  UniversityInfoViewController.h
//  TongChuang
//
//  Created by cuixiang on 15/7/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTypes.h"
#import "BaseViewController.h"

@interface UniversityInfoViewController : BaseViewController

@property (nonatomic, assign) DegreeType highestDegree;
@property (nonatomic, assign) DegreeType currentDegree;

@end
