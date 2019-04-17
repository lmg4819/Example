//
//  Capture41.m
//  Example0
//
//  Created by lmg on 2018/10/18.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture41.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface Capture41 ()

@property (nonatomic,copy) NSString *someThing;

@property (nonatomic,strong) dispatch_queue_t serialQueue;
@property (nonatomic,strong) dispatch_queue_t concurrentQueue;

@end

static NSString *_someThing;

@implementation Capture41

- (instancetype)init
{
    self = [super init];
    if (self) {
        _serialQueue = dispatch_queue_create("serialQueue.com.cn", NULL);
        _concurrentQueue = dispatch_queue_create("concurrentQueue.com.cn", DISPATCH_QUEUE_CONCURRENT);
        ((void(*)(id,SEL,id))objc_msgSend)(self,@selector(someThing),@"string");
        
    }
    return self;
}

-(NSString *)someThing
{
    __block NSString *localSomeString;
    dispatch_sync(_concurrentQueue, ^{
        localSomeString = _someThing;
    });
    return localSomeString;
}

-(void)setSomeThing:(NSString *)someThing
{
    dispatch_barrier_async(_concurrentQueue, ^{
        _someThing = someThing;
    });
}

/*
 
 @synchronized:滥用@synchronized(self)则会降低代码效率，因为公用同一个锁的那些同步块，都必须按顺序进行。若是在self对象上频繁加锁，那么程序可能要等另一段与此无关的代码执行完毕，才能继续执行当前代码，这样做其实并没有必要。我们只想令每个属性各自独立的执行。@synchronized无法保证访问该对象时绝对是线程安全的。使用属性时，必定能从中获取到有效值，然而在同一线程上多次调用获取方法，每次获取到的结果却未必相同。在两次访问操作之间，其他线程可能会写入新的属性值。
 
 
 NSLock和NSRecursiceLock效率比较差，NSLock可能造成死锁。
 
 同步派发改成异步派发，执行异步派发时，需要拷贝块。若拷贝块所用的时间明显超过执行块所用的时间，则这种做法将比原来更慢。然而，若是派发给队列的块要执行更为繁重的任务，那么仍然可以考虑这种备选方案。
 
 多个获取方法可以并发执行，而获取方法和设置方法不能并发执行
 
 
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.派发队列可用来表述同步语义（synchronization semantic），这种做法要比使用NSLock或@synchronized块更简单。
 2.将同步与异步派发结合起来，可以实现与普通加锁机制一样的同步行为，而这么做却不会阻碍执行异步派发的线程。
 3.使用同步队列及栅栏块，可以令同步行为更加高效。
 
 
 */
@end
