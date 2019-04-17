//
//  CYPImagePickerManager.m
//  CarEasyBuy
//
//  Created by 吴林杰 on 2017/5/3.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPImagePickerManager.h"

@implementation CYPImagePickerManager

static CYPImagePickerManager *imagePickerManager = nil;

+ (CYPImagePickerManager *)shareImagePickerManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imagePickerManager = [[CYPImagePickerManager alloc] init];
    });
    return imagePickerManager;
}
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC
                                     delegate:(id<CYPImagePickerManagerDelegate>)aDelegate {
    imagePickerManager.uploadImageDelegate = aDelegate;
    _fatherViewController = fatherVC;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"从手机相册上传", @"相机拍照", nil];
    [sheet showInView:fatherVC.view];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self fromPhotos];
    }else if (buttonIndex == 1) {
        [self createPhotoView];
    }
}
#pragma mark - 头像(相机和从相册中选择)
- (void)createPhotoView {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        imagePC.sourceType                = UIImagePickerControllerSourceTypeCamera;
        imagePC.delegate                  = self;
        imagePC.allowsEditing             = YES;
        [_fatherViewController presentViewController:imagePC
                                            animated:YES
                                          completion:^{
                                          }];
    }else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"该设备没有照相机"
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
    }
}
//图片库方法(从手机的图片库中查找图片)
- (void)fromPhotos {
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    imagePC.sourceType                = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePC.delegate                  = self;
    imagePC.allowsEditing             = YES;
    [_fatherViewController presentViewController:imagePC
                                        animated:YES
                                      completion:^{
                                      }];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    /**
     *  上传用户头像
     */
    if (self.uploadImageDelegate && [self.uploadImageDelegate respondsToSelector:@selector(uploadImageToServerWithImage:)]) {
        [self.uploadImageDelegate uploadImageToServerWithImage:image];
    }
}

@end
