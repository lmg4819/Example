//
//  UploadImageAPI.h
//  Example0
//
//  Created by lmg on 2018/9/29.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "YTKRequest.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadImageAPI : YTKRequest

- (id)initWithImage:(UIImage *)image;
- (NSString *)responseImageId;

@end

NS_ASSUME_NONNULL_END
