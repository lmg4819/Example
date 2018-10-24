//
//  GetImageAPI.m
//  Example0
//
//  Created by lmg on 2018/9/29.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "GetImageAPI.h"

@implementation GetImageAPI
{
    NSString *_imageId;
}

- (id)initWithImageId:(NSString *)imageId
{
    self = [super init];
    if (self) {
        _imageId = imageId;
    }
    return self;
}

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
{
    return @{
             
             
             };
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"/iphone/images/%@",_imageId];
}

- (BOOL)useCDN
{
    return YES;
}

- (NSString *)resumableDownloadPath
{
    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cachePath = [libPath stringByAppendingPathComponent:@"Caches"];
    NSString *filePath = [cachePath stringByAppendingPathComponent:_imageId];
    return filePath;
}

@end
