//
//  CYPImagePickerManager.h
//  CarEasyBuy
//
//  Created by 吴林杰 on 2017/5/3.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CYPImagePickerManagerDelegate <NSObject>

@optional
- (void)uploadImageToServerWithImage:(UIImage *)image;

@end

@interface CYPImagePickerManager : NSObject < UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>
{
    //如果你调不出来UIViewController,请添加UIKit头文件
    UIViewController *_fatherViewController;
}
@property (nonatomic, weak) id <CYPImagePickerManagerDelegate> uploadImageDelegate;
//单例方法
+ (CYPImagePickerManager *)shareImagePickerManager;
//弹出选项的方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC
                                     delegate:(id<CYPImagePickerManagerDelegate>)aDelegate;

@end
