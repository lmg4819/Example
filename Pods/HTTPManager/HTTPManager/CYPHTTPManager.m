//
//  CYPHTTPManager.m
//  车易拍
//
//  Created by 吴林杰 on 16/4/28.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import "CYPHTTPManager.h"
#import "C_HTTPRequest.h"
#import "CYPRequestConfigManager.h"

//#import "AFHTTPRequestOperationManager.h"
//#import <netinet/in.h>
//#import <CoreTelephony/CTCarrier.h>
//#import <CoreTelephony/CTTelephonyNetworkInfo.h>


@implementation CYPHTTPManager


#pragma mark - ------------------以下为Block形式的网络请求--------------------

/**
 *  基本请求
 *
 *  @param method     POST/GET
 *  @param urlString  请求接口
 *  @param parameters 业务接口参数字典
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
+ (CYPAFHTTPRequestOperation *)C_RequestUrlString:(NSString *)urlString
                                    httpMethod:(RequestHttpMethod )method
                                    parameters:(id)parameters
                                       success:(CYPOperationSuccBlock)success
                                       failure:(void (^)(NSError *error))failure
{
    CYPAFHTTPRequestOperation *operation = [[self class] C_AllWithUrlString:urlString httpMethod:method time:0 connectcont:0 syn:RequestAsyn parameters:parameters success:success failure:failure];
    return operation;
}

/**
 *  可设置超时时间
 *
 *  @param timer      超时时间
 */
+ (CYPAFHTTPRequestOperation *)C_TimeWithUrlString:(NSString *)urlString
                                     httpMethod:(RequestHttpMethod )method
                                           time:(NSInteger )timer
                                     parameters:(id)parameters
                                        success:(CYPOperationSuccBlock)success
                                        failure:(void (^)(NSError *error))failure{
    CYPAFHTTPRequestOperation *operation = [[self class] C_AllWithUrlString:urlString httpMethod:method time:timer connectcont:0 syn:2 parameters:parameters success:success failure:failure];
    return operation;
}
/**
 *  可设置连接池数量
 *
 *  @param connectcont  连接池数量
 */
+ (CYPAFHTTPRequestOperation *)C_ConnectWithUrlString:(NSString *)urlString
                                        httpMethod:(RequestHttpMethod )method
                                       connectcont:(NSInteger )connectcont
                                        parameters:(id)parameters
                                           success:(CYPOperationSuccBlock)success
                                           failure:(void (^)(NSError *error))failure{
    CYPAFHTTPRequestOperation *operation = [[self class] C_AllWithUrlString:urlString httpMethod:method time:0 connectcont:connectcont syn:2 parameters:parameters success:success failure:failure];
    return operation;
}

/**
 *  可设置同步异步请求
 *
 *  @param syn    同步异步表示
 */
+ (CYPAFHTTPRequestOperation *)C_SynWithUrlString:(NSString *)urlString
                                    httpMethod:(RequestHttpMethod )method
                                           syn:(RequestSynOrAsyn )syn
                                    parameters:(id)parameters
                                       success:(CYPOperationSuccBlock)success
                                       failure:(void (^)(NSError *error))failure{
    CYPAFHTTPRequestOperation *operation = [[self class] C_AllWithUrlString:urlString httpMethod:method time:0 connectcont:0 syn:syn parameters:parameters success:success failure:failure];
    return operation;
}

/**
 *  可设置超时时间，连接池数量，同步异步请求
 *
 */
+ (CYPAFHTTPRequestOperation *)C_AllWithUrlString:(NSString *)urlString
                                    httpMethod:(RequestHttpMethod )method
                                          time:(NSInteger )timer
                                   connectcont:(NSInteger )connectcont
                                           syn:(RequestSynOrAsyn )syn
                                    parameters:(id)parameters
                                       success:(CYPOperationSuccBlock)success
                                       failure:(void (^)(NSError *error))failure{
    CYPAFHTTPRequestOperation *operation = [[self class] C_AllWithUrlString:urlString MacroString:nil httpMethod:method time:timer connectcont:connectcont syn:syn parameters:parameters success:success failure:failure];
    return operation;
}

/**
 *  基本请求
 *  特殊请求头使用
 *
 *  @param MacroString 设置不同的宏请求头
 *  @param method     POST/GET
 *  @param urlString  请求接口
 *  @param parameters 业务接口参数字典
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
+ (CYPAFHTTPRequestOperation *)C_RequestUrlString:(NSString *)urlString
                                   MacroString:(NSString *)MacroString
                                    httpMethod:(RequestHttpMethod )method
                                    parameters:(id)parameters
                                       success:(CYPOperationSuccBlock)success
                                       failure:(void (^)(NSError *error))failure{
    
    
    
    CYPAFHTTPRequestOperation *operation = [[self class] C_AllWithUrlString:urlString MacroString:MacroString httpMethod:method time:0 connectcont:0 syn:RequestAsyn parameters:parameters success:success failure:failure];
    return operation;
}


/**
 *  可设置超时时间，连接池数量，同步异步请求
 *  特殊请求头使用
 *
 *  @param MacroString 设置不同的宏请求头
 */
+ (CYPAFHTTPRequestOperation *)C_AllWithUrlString:(NSString *)urlString
                                   MacroString:(NSString *)MacroString
                                    httpMethod:(RequestHttpMethod )method
                                          time:(NSInteger )timer
                                   connectcont:(NSInteger )connectcont
                                           syn:(RequestSynOrAsyn )syn
                                    parameters:(id)parameters
                                       success:(CYPOperationSuccBlock)success
                                       failure:(void (^)(NSError *error))failure{
    
    return [self C_AllWithRequestJson:NO UrlString:urlString MacroString:MacroString httpMethod:method time:timer connectcont:connectcont syn:syn parameters:parameters success:success failure:failure];
}

+ (CYPAFHTTPRequestOperation *)C_AllWithRequestJson:(BOOL)jsonRequest
                                       UrlString:(NSString *)urlString
                                     MacroString:(NSString *)MacroString
                                      httpMethod:(RequestHttpMethod )method
                                            time:(NSInteger )timer
                                     connectcont:(NSInteger )connectcont
                                             syn:(RequestSynOrAsyn )syn
                                      parameters:(id)parameters
                                         success:(CYPOperationSuccBlock)success
                                         failure:(void (^)(NSError *error))failure{
    
    id<CYPRequestConfigProtocol> configDelegate = [CYPRequestConfigManager sharedInstance].configDelegate;
    
    if (!MacroString) {
        MacroString = [CYPRequestConfigManager hostUrl];
    }
    //参数
    if ([configDelegate respondsToSelector:@selector(paramsConfig:)]) {
        parameters = [configDelegate paramsConfig:parameters];
    }
    //header
    NSDictionary * headerDict = @{};
    if ([configDelegate respondsToSelector:@selector(headerFieldValueConfig)]) {
        headerDict = [configDelegate headerFieldValueConfig];
    }
    
    C_HTTPRequest * manger = [C_HTTPRequest defaultManager];
     manger.requestSerializer = [manger requestKeyValueSeralizer];
    if (jsonRequest) {
        manger.requestSerializer = [manger requestJsonSeralizer];
    }
   
    NSString * requestMethod = @"GET";
    if (method == POSThttpMethod) {
        requestMethod = @"POST";
    }
    /**************地址、参数输出*********************/
    NSLog(@"{\nURL=%@\nhttpMethod=%@\nheader=%@\nparams=%@\n}",[MacroString stringByAppendingString:urlString],requestMethod,headerDict,parameters);
    /**************地址、参数输出*********************/
    
    CYPAFHTTPRequestOperation *operation =
    [manger requestWithMethod:requestMethod baseUrlStr:MacroString urlStr:urlString params:parameters headers:headerDict time:0 connectCount:0 syn:RequestAsyn success:^(id json) {
        
        if ([configDelegate respondsToSelector:@selector(specialStatusHandle:)]) {
            BOOL isSpecail = [configDelegate specialStatusHandle:json];
            if (isSpecail) {
                return;
            }
        }
        
        if (success) {
            success(nil , json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return operation;
    
}


#pragma mark-  ImageUpload
+ (CYPAFHTTPRequestOperation *)C_uploadImage:(UIImage *)image
                                   urlStr:(NSString *)urlStr
                               parameters:(id)parameters
                                     name:(NSString *)name
                                 fileName:(NSString *)fileName
                                  success:(CYPOperationSuccBlock)success
                                  failure:(void (^)(NSError *error))failure
{
    return [self C_uploadImage:image urlStr:urlStr parameters:parameters name:name fileName:fileName success:success failure:failure progress:nil];
}

+ (CYPAFHTTPRequestOperation *)C_uploadImage:(UIImage *)image
                                   urlStr:(NSString *)urlStr
                                parameters:(id)parameters
                                     name:(NSString *)name
                                 fileName:(NSString *)fileName
                                  success:(CYPOperationSuccBlock)success
                                  failure:(void (^)(NSError *error))failure
                                 progress:(void(^)(float progress))progressBlock
{
 
    id<CYPRequestConfigProtocol> configDelegate = [CYPRequestConfigManager sharedInstance].configDelegate;
    
    //参数
    if ([configDelegate respondsToSelector:@selector(paramsConfig:)]) {
        parameters = [configDelegate paramsConfig:parameters];
    }
    //header
    NSDictionary * headerDict = @{};
    if ([configDelegate respondsToSelector:@selector(headerFieldValueConfig)]) {
        headerDict = [configDelegate headerFieldValueConfig];
    }

    /**************地址、参数输出*********************/
    NSLog(@"UPLoadIamage={\nURL=%@\nheader=%@\nparams=%@\n}",urlStr,headerDict,parameters);
    /**************地址、参数输出*********************/
    
    return [C_HTTPRequest uploadImage:image urlStr:urlStr parameters:parameters headers:headerDict name:name fileName:fileName success:^(id json) {
        if ([configDelegate respondsToSelector:@selector(specialStatusHandle:)]) {
            BOOL isSpecail = [configDelegate specialStatusHandle:json];
            if (isSpecail) {
                return;
            }
        }
        if (success) {
            success(nil, json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    } progress:^(float progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    }];
    
}


#pragma mark- JSON_POST
+ (CYPAFHTTPRequestOperation *)C_JsonRequestURL:(NSString *)urlString
                                  parameters:(id)parameters
                                     success:(CYPOperationSuccBlock)success
                                     failure:(void (^)(NSError *error))failure
{
    return [self C_AllWithRequestJson:YES UrlString:urlString MacroString:nil httpMethod:POSThttpMethod time:0 connectcont:0 syn:RequestAsyn parameters:parameters success:success failure:failure];
}

+ (CYPAFHTTPRequestOperation *)C_JsonRequestURL:(NSString *)urlString
                                 MacroString:(NSString *)MacroString
                                  parameters:(id)parameters
                                     success:(CYPOperationSuccBlock)success
                                     failure:(void (^)(NSError *error))failure
{
    return [self C_AllWithRequestJson:YES UrlString:urlString MacroString:MacroString httpMethod:POSThttpMethod time:0 connectcont:0 syn:RequestAsyn parameters:parameters success:success failure:failure];
}


+ (CYPAFHTTPRequestOperation *)C_JsonRequestURL:(NSString *)urlString
                                 MacroString:(NSString *)MacroString
                                  httpMethod:(RequestHttpMethod )method
                                  parameters:(id)parameters
                                     success:(CYPOperationSuccBlock)success
                                     failure:(void (^)(NSError *error))failure
{
    return [self C_AllWithRequestJson:YES UrlString:urlString MacroString:MacroString httpMethod:method time:0 connectcont:0 syn:RequestAsyn parameters:parameters success:success failure:failure];
}


#pragma mark - 列表使用
+ (CYPAFHTTPRequestOperation *)C_AllListWithRequestJson:(BOOL)jsonRequest
                                           UrlString:(NSString *)urlString
                                         MacroString:(NSString *)MacroString
                                          httpMethod:(RequestHttpMethod )method
                                                time:(NSInteger )timer
                                         connectcont:(NSInteger )connectcont
                                                 syn:(RequestSynOrAsyn )syn
                                          parameters:(id)parameters
                                             success:(CYPOperationSuccBlock)success
                                             failure:(void (^)(NSError *error))failure{
    
    id<CYPRequestConfigProtocol> configDelegate = [CYPRequestConfigManager sharedInstance].configDelegate;
    
    if (!MacroString) {
        MacroString = [CYPRequestConfigManager hostUrl];
    }
    //参数
    NSDictionary * allParamsDic = parameters;
    //header
    NSDictionary * headerDict = @{};
    if ([configDelegate respondsToSelector:@selector(headerForCarListValueDictionary)]) {
        headerDict = [configDelegate headerForCarListValueDictionary];
    }
    
    C_HTTPRequest * manger = [C_HTTPRequest defaultManager];
    manger.requestSerializer = [manger requestKeyValueSeralizer];
    if (jsonRequest) {
        manger.requestSerializer = [manger requestJsonSeralizer];
    }
    
    NSString * requestMethod = @"GET";
    if (method == POSThttpMethod) {
        requestMethod = @"POST";
    }
    /**************地址、参数输出*********************/
    NSLog(@"{\nURL=%@\nhttpMethod=%@\nheader=%@\nparams=%@\n}",[MacroString stringByAppendingString:urlString],requestMethod,headerDict,allParamsDic);
    /**************地址、参数输出*********************/
    
    CYPAFHTTPRequestOperation *operation =
    [manger requestWithMethod:requestMethod baseUrlStr:MacroString urlStr:urlString params:allParamsDic headers:headerDict time:0 connectCount:0 syn:RequestAsyn success:^(id json) {
        
        if ([configDelegate respondsToSelector:@selector(specialStatusHandle:)]) {
            BOOL isSpecail = [configDelegate specialStatusHandle:json];
            if (isSpecail) {
                return;
            }
        }
        
        if (success) {
            success(nil , json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return operation;
    
}



@end
