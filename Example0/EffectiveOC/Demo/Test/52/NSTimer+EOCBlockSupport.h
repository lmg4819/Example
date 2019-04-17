//
//  NSTimer+EOCBlockSupport.h
//  Example0
//
//  Created by lmg on 2018/10/25.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (EOCBlockSupport)

+ (NSTimer *)eoc_scheduleTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void (^)(void))block
                                       repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
