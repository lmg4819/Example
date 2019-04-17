//
//  C_HTTPManager.h
//  CarEasyBuy
//
//  Created by 马敬龙 on 17/3/30.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYPAFNetworking.h"

// 网络访问的回调block预定义
typedef void(^HttpRequestSuccessBlock)(id json);
typedef void(^HttpRequestFailureBlock)(NSError *error);


@interface C_HTTPRequest : CYPAFHTTPRequestOperationManager

+ (C_HTTPRequest *)defaultManager;

- (CYPAFHTTPRequestSerializer *)requestJsonSeralizer;

- (CYPAFHTTPRequestSerializer*)requestKeyValueSeralizer;

-(CYPAFHTTPRequestOperation *)requestWithMethod:(NSString *)method
                                  baseUrlStr:(NSString *)baseUrlStr
                                      urlStr:(NSString *)urlStr
                                      params:(NSDictionary *)params
                                     headers:(NSDictionary *)headers
                                        time:(NSInteger)timer
                                connectCount:(NSInteger)connectCount
                                         syn:(NSInteger)syn
                                     success:(HttpRequestSuccessBlock)success
                                     failure:(HttpRequestFailureBlock)failure;


/**
 *  @param  image       图片
 *  @param  urlStr      上传地址
 *  @param  parameters  上传参数
 *  @param  headers     header参数
 *  @param  name        图片名
 *  @param  fileName    图片文件名
 *  @param  success     成功回调block
 *  @param  failure     失败回调block
 *  @param  progress    上传进度回调block
 */
+ (CYPAFHTTPRequestOperation *)uploadImage:(UIImage *)image
                                 urlStr:(NSString *)urlStr
                             parameters:(id)parameters
                                headers:(NSDictionary *)headers
                                   name:(NSString *)name
                               fileName:(NSString *)fileName
                                success:(HttpRequestSuccessBlock)success
                                failure:(HttpRequestFailureBlock)failure
                               progress:(void (^)(float progress))progress;


@end
