//
//  Lock.m
//  Example0
//
//  Created by lmg on 2018/10/9.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Lock.h"
#import <pthread/pthread.h>

@implementation Lock

/**
 互斥锁
 优点:不需要在代码中显式的创建锁对象，便可以实现锁的机制
 缺点:作为一种预防措施，会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常处理的
 时候自动的释放互斥锁，
 */
- (void)synchronizedTest
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            NSLog(@"需要线程同步的操作1 开始");
            sleep(3);
            NSLog(@"需要线程同步的操作1 结束");
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        @synchronized (self) {
            NSLog(@"需要线程同步的操作2");
        }
    });
}

/**
 信号总量设为1的时候可以当锁来用。在没有等待的情况下，它的性能比pthread_mutex还要高，
 但一旦有等待情况出现时，性能就会下降很多
 */
- (void)semaphoreTest
{
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束");
        dispatch_semaphore_signal(signal);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(signal);
    });
}

/**
 最常用的锁
 */
- (void)lockTest
{
    NSLock *lock = [[NSLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockBeforeDate:[NSDate date]];
        NSLog(@"需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束");
        [lock unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        if ([lock tryLock]) {
            NSLog(@"锁可用的操作");
            [lock unlock];
        }else
        {
            NSLog(@"锁不可用的操作");
        }
        
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:3];
        if ([lock lockBeforeDate:date]) {
            NSLog(@"没有超时，获得锁");
            [lock unlock];
        }else
        {
            NSLog(@"超时，没有获得锁");
        }
        
    });
}

/**
 递归锁
 */
- (void)recursiveLockTest
{
    NSRecursiveLock *lock = [[NSRecursiveLock alloc]init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        static void (^RecursiveMethod)(int);
        RecursiveMethod = ^(int value){
            
            [lock lock];
            if (value > 0) {
                NSLog(@"value = %d",value);
                sleep(2);
                RecursiveMethod(value - 1);
            }
            [lock unlock];
            
        };
        RecursiveMethod(5);
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        BOOL flag = [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
        if (flag) {
            NSLog(@"lock before date");
            [lock unlock];
        }else
        {
            NSLog(@"fail to lock before date");
        }
    });
}
/**
 条件锁
 */
- (void)NSConditionLockTest
{
    //初始化锁时，指定一个默认的条件
    
    NSInteger HAS_DATA = 1;
    NSInteger NO_DATA = 0;
    NSConditionLock *lock = [[NSConditionLock alloc]initWithCondition:NO_DATA];
    NSMutableArray *products = [NSMutableArray array];
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (1) {
            [lock lockWhenCondition:NO_DATA];
            [products addObject:@"1111"];
            NSLog(@"produce a product,总量:%zi",products.count);
            [lock unlockWithCondition:HAS_DATA];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (1) {
            NSLog(@"wait for product");
            [lock lockWhenCondition:HAS_DATA];
            [products removeObjectAtIndex:0];
            NSLog(@"custome a product");
            [lock unlockWithCondition:NO_DATA];
        }
    });
}

#define Lock() pthread_mutex_lock(&_lock)
#define Unlock() pthread_mutex_unlock(&_lock)

- (void)pthreadMutexTest
{
    pthread_mutex_t _lock;
    pthread_mutex_init(&_lock, NULL);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        Lock();
        NSLog(@"需要线程同步的操作1 开始");
        sleep(4);
        NSLog(@"需要线程同步的操作1 结束");
        Unlock();
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        Lock();
        NSLog(@"需要线程同步的操作2 开始");
        Unlock();
    });
    
}

/**
 condition进入到判断条件时，当products == 0时，condition调用wait时当前线程处于等待状态；
 其他线程开始访问products添加对象时，CPU发出signal的信号时，处于等待的线程被唤醒，开始继续执行
 */
- (void)NSConditionTest
{
    
    NSCondition *condition = [[NSCondition alloc]init];
    NSMutableArray *products = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [condition lock];
        while ([products count] == 0) {
            NSLog(@"wait for product");
            [condition wait];
        }
        [products removeObjectAtIndex:0];
        NSLog(@"custom a product");
        [condition unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [condition lock];
        [products addObject:@"11111"];
        NSLog(@"product a product");
        [condition signal];
        [condition unlock];
    });
}


@end
