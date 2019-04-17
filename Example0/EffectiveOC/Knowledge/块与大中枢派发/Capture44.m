//
//  Capture44.m
//  Example0
//
//  Created by lmg on 2018/10/19.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture44.h"

@implementation Capture44

-(instancetype)init
{
    self = [super init];
    if (self) {
//        NSArray *collection = @[@1,@2,@3,@4,@5,@6];
//        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//        dispatch_group_t group = dispatch_group_create();
//        for (NSNumber *number in collection) {
//            dispatch_group_async(group, queue, ^{
//                int intValue = [number intValue];
//                NSLog(@"-------%d",intValue);
//            });
//        }
//        //阻塞当前线程
//        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//        //不想阻塞当前线程，则应使用notify
//        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//          //continue processing after completing tasks
//        });
        NSArray *lowPriorityObjects = @[@1,@2,@3,@4,@5,@6];
        NSArray *highPriorityObjects = @[@1,@2,@3,@4,@5,@6];
//        dispatch_queue_create("com.effectiveobjective.queue", DISPATCH_QUEUE_SERIAL);
        
        
        dispatch_queue_t lowPriorityQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        dispatch_queue_t highPrioriryQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_group_t dispatchGroup = dispatch_group_create();
        
        for (NSNumber *number in lowPriorityObjects) {
            dispatch_group_async(dispatchGroup, lowPriorityQueue, ^{
                int intValue = [number intValue];
                NSLog(@"lowPro-----%d",intValue);
            });
        }
        
        
        for (NSNumber *number in highPriorityObjects) {
            dispatch_group_async(dispatchGroup, highPrioriryQueue, ^{
                int intValue = [number intValue];
                NSLog(@"highPro-----%d",intValue);
            });
        }
        
        dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
            
        });
        
        
        
        
    }
    return self;
}

/*
 
 根据系统资源状况来执行任务：
 为了执行队列中的块，GCD会在适当的时机自动创建新线程或复用旧线程。如果使用并发队列，那么其中可能会有多个线程，这也就意味着多个块可以并发执行。
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.一系列任务可归入一个dispatch group中，开发者可以在这组任务执行完成后获得通知。
 2.通过dispatch group,可以在并发式派发队列中同时执行多项任务。此时GCD会根据系统资源状况来调度这些并发执行的任务，
 
 */
@end
