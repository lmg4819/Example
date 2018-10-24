//
//  Lock.h
//  Example0
//
//  Created by lmg on 2018/10/9.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Lock : NSObject
/**
 1.OSSpinLock(已弃用)
 2.dispatch_semaphore
 3.pthread_mutex
 4.NSLock
 5.NSCondition
 6.NSRecursiveLock
 7.NSConditionLock
 8.@synchronized
 */
@end

NS_ASSUME_NONNULL_END
