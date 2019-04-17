//
//  Capture18.m
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture18.h"

@interface Capture18 ()

@property (nonatomic,strong) NSString *retainCou;
@property (nonatomic,strong) dispatch_queue_t concurrentQueue;
@end

@implementation Capture18

-(instancetype)init
{
    self = [super init];
    if (self) {
        _concurrentQueue = dispatch_queue_create("com.cn.cheyipai.concurrent", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

static NSString *userId = @"";

-(void)setUserIdentifier:(NSString *)userIdentifier
{
    dispatch_barrier_async(self.concurrentQueue, ^{
        userId = userIdentifier;
    });
}

-(NSString *)userIdentifier
{
    __block NSString *result;
    dispatch_sync(self.concurrentQueue, ^{
        result = [userId copy];
    });
    return result;
}

/*
 
 
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.尽量创建不可变的对象。
 2.若某属性仅可用于对象内部修改属性，则在class-extension中将其由readonly属性修改为readwrite属性。
 3.不要把可变的collection作为属性公开，而应提供相关方法，以此修改对象中的collection。
 
 
 */
@end
