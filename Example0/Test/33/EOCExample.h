//
//  EOCExample.h
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EOCExample : NSObject

@end

@class EOCClassB;
@class EOCClassA;

@interface EOCClassA : NSObject
@property (nonatomic,strong) EOCClassB *other;
@end

@interface EOCClassB : NSObject
@property (nonatomic,weak) EOCClassA *other;
@end


NS_ASSUME_NONNULL_END
