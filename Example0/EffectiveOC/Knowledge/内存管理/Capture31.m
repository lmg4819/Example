//
//  Capture31.m
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture31.h"

@implementation Capture31

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/*
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.在dealloc方法中，应该做的事情就是释放指向其他对象的引用，并取消原来订阅的“键值观察”(KVO)或NSNotificationCenter等通知，不要做其他事情。
 2.如果对象持有文件描述符等系统资源，那么应该专门编写一个方法来释放此种资源。这样的类要和其使用者约定，用完资源后必须调用close方法。
 3.执行异步任务的方法不应在dealloc中调用;只能在正常状态下调用的那些方法也不应在dealloc中调用，因为对象已处于正在回收的状态了。
 
 
 */
@end
