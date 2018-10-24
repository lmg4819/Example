//
//  EOCNetworkFetcher.m
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCNetworkFetcher.h"

@interface EOCNetworkFetcher ()
{
    EOCNetworkFetcherCompletionHandle _completionHandle;
    EOCNetworkFetcherFailureHandle _failureHandle;
}
@end

@implementation EOCNetworkFetcher

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (_delegateFlags.didReceiveData) {
            [_delegate networkFetcher:self didReceiveData:nil];
        }
    }
    return self;
}

- (void)startWithCompletionHandle:(EOCNetworkFetcherCompletionHandle)success failure:(EOCNetworkFetcherFailureHandle)failure
{
    [self start];
    _completionHandle = success;
    _failureHandle = failure;
}

- (void)start
{
    
}

-(void)setDelegate:(id<EOCNetworkFetcherDelegate>)delegate
{
    _delegate = delegate;
    _delegateFlags.didReceiveData = [delegate respondsToSelector:@selector(networkFetcher:didReceiveData:)];
    
    _delegateFlags.didFailWithError = [delegate respondsToSelector:@selector(networkFetcher:didFailWithError:)];
    
    _delegateFlags.didUpdateProgressTo = [delegate respondsToSelector:@selector(networkFetcher:didUpdateProgressTo:)];
}

@end
