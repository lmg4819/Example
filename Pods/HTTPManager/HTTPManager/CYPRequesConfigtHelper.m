//
//  CYPRequestHelper.m
//  LHTeach
//
//  Created by 马敬龙 on 2017/8/31.
//  Copyright © 2017年 majinglong. All rights reserved.
//

#import "CYPRequesConfigtHelper.h"
#import "YYModel.h"

@implementation CYPRequesConfigtHelper


+ (void)requestConfigTemplate {
    
    CYPRequestConfigManager * requestManager = [CYPRequestConfigManager sharedInstance];
    requestManager.prefixNetWorkUrl = @"";
    requestManager.configDelegate = [self singletonRequestHelper];
}

+ (instancetype)singletonRequestHelper
{
    static CYPRequesConfigtHelper * helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[CYPRequesConfigtHelper alloc] init];
    });
    return helper;
}

- (BOOL)connectNetFail
{
    return NO;
}

- (NSDictionary *)paramsConfig:(NSDictionary *)businessParams
{
    NSMutableDictionary * paramsDict = [NSMutableDictionary dictionaryWithDictionary:businessParams];
    
    
    return paramsDict;
}

- (NSDictionary *)headerFieldValueConfig
{
    NSMutableDictionary * headerDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    
    return headerDict;
}

- (NSString *)netFailPrompt
{
    return @"";
}

- (id)jsonToModel:(Class)cls json:(id)json analysisSuccBlock:(AnalysisBlock)analysisBlock
{
    if (!cls ) {
        if (analysisBlock) {
            analysisBlock([json[@""] integerValue], json[@""], json[@""]);
        }
        return json;
    }
    if ([json isKindOfClass:[NSDictionary class]]) {
        id model = [cls yy_modelWithJSON:json];
        if (analysisBlock) {
            analysisBlock([json[@""] integerValue], json[@""], model);
        }
        return model;
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSArray * dataArray = [NSArray yy_modelArrayWithClass:cls json:json];
        if (analysisBlock) {
            analysisBlock([json[@""] integerValue], json[@""], dataArray);
        }
        return dataArray;
    }
    return  json;
}


- (BOOL)specialStatusHandle:(id)model
{
    return NO;
}

@end
