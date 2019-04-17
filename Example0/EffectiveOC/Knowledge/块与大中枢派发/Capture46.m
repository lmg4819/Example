//
//  Capture46.m
//  Example0
//
//  Created by lmg on 2018/10/19.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture46.h"

@interface Capture46 ()

@property (nonatomic,copy) NSString *someThing;
@property (nonatomic,strong) dispatch_queue_t syncQueue;

@end

static NSString *_someThing;

@implementation Capture46

- (instancetype)init
{
    self = [super init];
    if (self) {
        _syncQueue = dispatch_queue_create("syncQueue.com.cn", NULL);
        
        dispatch_queue_t queueA = dispatch_queue_create("queueA", NULL);
        dispatch_queue_t queueB = dispatch_queue_create("queueB", NULL);
        
        dispatch_set_target_queue(queueB, queueA);
        static int kQueueSpecific;
        CFStringRef queueSpecificValue = CFSTR("queueA");
        dispatch_queue_set_specific(queueA, &kQueueSpecific, (void *)queueSpecificValue, (dispatch_function_t)CFRelease);
        dispatch_sync(queueB, ^{
            dispatch_block_t block = ^{
                NSLog(@"No deadlock");
            };
            CFStringRef retrivedValue = dispatch_get_specific(&kQueueSpecific);
            if (retrivedValue) {
                block();
            }else
            {
                dispatch_sync(queueA, block);
            }
        });
        
    }
    return self;
}

-(NSString *)someThing
{
    __block NSString *localSomeThing;
    dispatch_sync(_syncQueue, ^{
        localSomeThing = _someThing;
    });
    return localSomeThing;
}

-(void)setSomeThing:(NSString *)someThing
{
    dispatch_async(_syncQueue, ^{
        _someThing = someThing;
    });
}

/*
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.dispatch_get_current_queue函数的行为常常与开发者的预期不同。此函数已经废弃，只应做调试只用
 2.由于派发队列是按照层级来组织的，所以无法单用某个队列对象来描述当前队列这一概念
 3.dispatch_get_current_queue函数用于解决不可重用的代码所引入的死锁，然而能用此函数解决的问题，通常也能改用“队列特定数据”来解决
 
 */
@end
