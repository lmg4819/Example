//
//  YTKUrlArgumentsFilter.h
//  Example0
//
//  Created by lmg on 2018/9/29.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetworkConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTKUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>

+ (YTKUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
