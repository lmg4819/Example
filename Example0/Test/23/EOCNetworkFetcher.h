//
//  EOCNetworkFetcher.h
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^EOCNetworkFetcherCompletionHandle)(NSData *data);
typedef void(^EOCNetworkFetcherFailureHandle)(NSError *error);

@class EOCNetworkFetcher;

@protocol EOCNetworkFetcherDelegate <NSObject>

@optional
- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didReceiveData:(NSData *)data;
- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didFailWithError:(NSError *)error;
- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didUpdateProgressTo:(float)progress;


@end

@interface EOCNetworkFetcher : NSObject
//位段数据类型将方法响应能力缓存起来，可以提高性能
{
    struct {
        unsigned int didReceiveData : 1;
        unsigned int didFailWithError : 1;
        unsigned int didUpdateProgressTo : 1;
        
    }_delegateFlags;
}

@property (nonatomic,weak) id<EOCNetworkFetcherDelegate>delegate;

- (instancetype)initWithURL:(NSURL *)url;
- (void)start;
- (void)startWithCompletionHandle:(EOCNetworkFetcherCompletionHandle)success
                          failure:(EOCNetworkFetcherFailureHandle)failure;


@end

NS_ASSUME_NONNULL_END
