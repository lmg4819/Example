//
//  Capture39.m
//  Example0
//
//  Created by lmg on 2018/10/18.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture39.h"
#import "EOCNetworkFetcher.h"

@interface Capture39 ()<EOCNetworkFetcherDelegate>

@end

@implementation Capture39

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
        EOCNetworkFetcher *fetcher = [[EOCNetworkFetcher alloc]initWithURL:url];
        fetcher.delegate = self;
//        [fetcher start];
        [fetcher startWithCompletionHandle:^(NSData * _Nonnull data) {
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
        
    }
    return self;
}

#pragma mark -EOCNetworkFetcherDelegate

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didReceiveData:(NSData *)data
{
    
}

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didFailWithError:(NSError *)error
{
    
}

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didUpdateProgressTo:(float)progress
{
    
}

/*
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.在创建对象时，可以使用内联的handle块将相关业务逻辑一并声明。
 2.在有多个实例需要监控时，如果采用委托模式，那么经常需要根据传入的对象来切换，而若改用handle块实现，则可直接将块与相关对象写在一起。
 3.设计API时如果用到了handle块，那么可以增加一个参数，使调用者可通过此参数来决定应该把块安排在哪个队列上执行。
 
 
 */
@end
