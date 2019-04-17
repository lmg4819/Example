//
//  CYPRequestConfigManager.m
//  LHTeach
//
//  Created by 马敬龙 on 2017/8/30.
//  Copyright © 2017年 majinglong. All rights reserved.
//

#import "CYPRequestConfigManager.h"

@implementation CYPRequestConfigManager


+ (CYPRequestConfigManager *)sharedInstance
{
    static CYPRequestConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [CYPRequestConfigManager new];
    });
    
    return instance;
}

+ (NSString *)hostUrl
{
    return  [self sharedInstance].prefixNetWorkUrl;
}


@end
