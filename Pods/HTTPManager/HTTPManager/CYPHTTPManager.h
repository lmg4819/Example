//
//  CYPHTTPManager.h
//  车易拍
//
//  Created by 吴林杰 on 16/4/28.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYPAFHTTPRequestOperationManager.h"

typedef enum{
    GEThttpMethod = 1,
    POSThttpMethod = 2,
}RequestHttpMethod;

typedef enum{
    RequestSyn = 1,//同步
    RequestAsyn = 2,//异步
}RequestSynOrAsyn;


typedef void(^CYPOperationSuccBlock)(CYPAFHTTPRequestOperation *operation ,id response);
typedef void(^CYPOperationFailBlock)(NSString * error);

@interface CYPHTTPManager : CYPAFHTTPRequestOperationManager


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
                                       failure:(void (^)(NSError *error))failure;


/**
 *  基本请求
 *  特殊请求头使用
 *
 *  @param MacroString 设置不同的宏请求头    默认nil -->  MYCYP_HOME_HOST
 */
+ (CYPAFHTTPRequestOperation *)C_RequestUrlString:(NSString *)urlString
                                   MacroString:(NSString *)MacroString
                                    httpMethod:(RequestHttpMethod )method
                                    parameters:(id)parameters
                                       success:(CYPOperationSuccBlock)success
                                       failure:(void (^)(NSError *error))failure;

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
                                        failure:(void (^)(NSError *error))failure;
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
                                           failure:(void (^)(NSError *error))failure;

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
                                       failure:(void (^)(NSError *error))failure;

/**
 *  可设置超时时间，连接池数量，同步异步请求
 *  默认宏请求头   MYCYP_HOME_HOST
 *
 */
+ (CYPAFHTTPRequestOperation *)C_AllWithUrlString:(NSString *)urlString
                                    httpMethod:(RequestHttpMethod )method
                                          time:(NSInteger )timer
                                   connectcont:(NSInteger )connectcont
                                           syn:(RequestSynOrAsyn )syn
                                    parameters:(id)parameters
                                       success:(CYPOperationSuccBlock)success
                                       failure:(void (^)(NSError *error))failure;

/**
 *  可设置超时时间，连接池数量，同步异步请求
 *  特殊请求头使用
 *
 *  @param MacroString 设置不同的宏请求头   默认nil -->  MYCYP_HOME_HOST
 */
+ (CYPAFHTTPRequestOperation *)C_AllWithUrlString:(NSString *)urlString
                                   MacroString:(NSString *)MacroString
                                    httpMethod:(RequestHttpMethod )method
                                          time:(NSInteger )timer
                                   connectcont:(NSInteger )connectcont
                                           syn:(RequestSynOrAsyn )syn
                                    parameters:(id)parameters
                                       success:(CYPOperationSuccBlock)success
                                       failure:(void (^)(NSError *error))failure;

#pragma mark-  上传图片
/**
 *  上传请求
 *
 *  @param image      图片
 *  @param urlStr     请求地址
 *  @param parameters 业务接口参数字典
 *  @param name       图片标记
 *  @param fileName   图片文件名字
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (CYPAFHTTPRequestOperation *)C_uploadImage:(UIImage *)image
                                   urlStr:(NSString *)urlStr
                               parameters:(id)parameters
                                     name:(NSString *)name
                                 fileName:(NSString *)fileName
                                  success:(CYPOperationSuccBlock)success
                                  failure:(void (^)(NSError *error))failure;

+ (CYPAFHTTPRequestOperation *)C_uploadImage:(UIImage *)image
                                   urlStr:(NSString *)urlStr
                               parameters:(id)parameters
                                     name:(NSString *)name
                                 fileName:(NSString *)fileName
                                  success:(CYPOperationSuccBlock)success
                                  failure:(void (^)(NSError *error))failure
                                 progress:(void(^)(float progress))progressBlock;

#pragma mark - ------------------C#形式使用接口处理（特殊请求头使用）--------------------

/*
    请求参数json格式
    @param  MacroString  设置不同主域名， 默认 MApiURL, POST传参
 */

+ (CYPAFHTTPRequestOperation *)C_JsonRequestURL:(NSString *)urlString
                                  parameters:(id)parameters
                                     success:(CYPOperationSuccBlock)success
                                     failure:(void (^)(NSError *error))failure;

+ (CYPAFHTTPRequestOperation *)C_JsonRequestURL:(NSString *)urlString
                                 MacroString:(NSString *)MacroString
                                  parameters:(id)parameters
                                     success:(CYPOperationSuccBlock)success
                                     failure:(void (^)(NSError *error))failure;


+ (CYPAFHTTPRequestOperation *)C_JsonRequestURL:(NSString *)urlString
                                 MacroString:(NSString *)MacroString
                                  httpMethod:(RequestHttpMethod )method
                                  parameters:(id)parameters
                                     success:(CYPOperationSuccBlock)success
                                     failure:(void (^)(NSError *error))failure;



//列表使用
+ (CYPAFHTTPRequestOperation *)C_AllListWithRequestJson:(BOOL)jsonRequest
                                           UrlString:(NSString *)urlString
                                         MacroString:(NSString *)MacroString
                                          httpMethod:(RequestHttpMethod )method
                                                time:(NSInteger )timer
                                         connectcont:(NSInteger )connectcont
                                                 syn:(RequestSynOrAsyn )syn
                                          parameters:(id)parameters
                                             success:(CYPOperationSuccBlock)success
                                             failure:(void (^)(NSError *error))failure;




@end
