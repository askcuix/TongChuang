//
//  CameraUtil.m
//  TongChuang
//
//  Created by cuixiang on 15/7/18.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "CameraUtil.h"

@implementation CameraUtil

+ (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+ (BOOL)isCameraSupportTakingPhoto {
    return [CameraUtil cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL)isCameraSupportTakingVideo {
    return [CameraUtil cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL)isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL) isAvailableForPickVideosFromPhotoLibrary {
    return [CameraUtil
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL) isAvailablePickPhotosFromPhotoLibrary {
    return [CameraUtil
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL)cameraSupportsMedia:(NSString *)mediaType sourceType:(UIImagePickerControllerSourceType)sourceType {
    if ([mediaType length] == 0) {
        return NO;
    }
    
    __block BOOL result = NO;
    
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *availableType = (NSString *)obj;
        
        if ([availableType isEqualToString:mediaType]) {
            result = YES;
            *stop = YES;
        }
    }];
    
    return result;
}

@end
