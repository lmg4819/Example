//
//  GetUserInfoAPI.m
//  Example0
//
//  Created by lmg on 2018/9/29.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "GetUserInfoAPI.h"

@implementation GetUserInfoAPI
{
    NSString *_userId;
}

- (id)initWithUserId:(NSString *)userId
{
    self = [super init];
    if (self) {
        _userId = userId;
    }
    return self;
}

- (NSString *)requestUrl
{
    return @"/iphone/users";
}

- (id)requestArgument
{
    return @{
             @"id":_userId
             };
}

- (id)jsonValidator
{
    return @{
             @"nick":[NSString class],
             @"level":[NSNumber class]
             };
}
// 3 分钟的缓存
- (NSInteger)cacheTimeInSeconds
{
    // 3 分钟 = 180 秒
    return 3 * 60;
}

-(BOOL)loadCacheWithError:(NSError * _Nullable __autoreleasing *)error
{
    return YES;
}

@end
