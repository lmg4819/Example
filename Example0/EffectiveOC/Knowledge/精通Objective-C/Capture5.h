//
//  Capture5.h
//  Example0
//
//  Created by lmg on 2018/10/11.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,EOCEunmType) {
    
    EOCEunmTypeOne,
    EOCEunmTypeTwo,
    EOCEunmTypeThress
};

typedef NS_OPTIONS(NSUInteger, EOCOptionDirection) {
    
    EOCOptionDirectionLeft        = 1 << 0,
    EOCOptionDirectionRight       = 1 << 1,
    EOCOptionDirectionUp          = 1 << 2,
    EOCOptionDirectionDown        = 1 << 3
    
};

NS_ASSUME_NONNULL_BEGIN

@interface Capture5 : NSObject
//5.用枚举表示状态，选项，状态码
@end

NS_ASSUME_NONNULL_END
