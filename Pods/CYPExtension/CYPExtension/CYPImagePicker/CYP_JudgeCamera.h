//
//  CYP_Judge.h
//  车易拍
//
//  Created by cheyipai.com on 16/5/10.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYP_JudgeCamera : NSObject

//相机是否可用
+ (BOOL)isCameraAvailable;

//是否支持某种媒体
+ (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType;

//支持前置摄像头
+ (BOOL)isFrontCameraAvailable;

//支持相册
+ (BOOL)isPhotoLibraryAvailable;

//支持拍照
+ (BOOL)doesCameraSupportTakingPhotos;


@end
