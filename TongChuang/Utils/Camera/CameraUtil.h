//
//  CameraUtil.h
//  TongChuang
//
//  Created by cuixiang on 15/7/18.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraUtil : NSObject

+ (BOOL)isCameraAvailable;
+ (BOOL)isFrontCameraAvailable;

+ (BOOL)isCameraSupportTakingPhoto;
+ (BOOL)isCameraSupportTakingVideo;

+ (BOOL)isPhotoLibraryAvailable;
+ (BOOL) isAvailableForPickVideosFromPhotoLibrary;
+ (BOOL) isAvailablePickPhotosFromPhotoLibrary;

@end
