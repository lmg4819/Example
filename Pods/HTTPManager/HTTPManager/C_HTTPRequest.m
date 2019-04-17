//
//  C_HTTPManager.m
//  CarEasyBuy
//
//  Created by 马敬龙 on 17/3/30.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import "C_HTTPRequest.h"

@implementation C_HTTPRequest

+ (C_HTTPRequest *)defaultManager {
    
    static C_HTTPRequest * afManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        afManager = [C_HTTPRequest manager];
        afManager.requestSerializer = [CYPAFHTTPRequestSerializer serializer];
        //相应数据解析格式
        afManager.responseSerializer = [CYPAFJSONResponseSerializer serializer];
        afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil];
        //post安全策略
        CYPAFSecurityPolicy *securityPolicy = [CYPAFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = NO;
        securityPolicy.validatesDomainName = YES;
        afManager.securityPolicy  = securityPolicy;
        
        //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO//如果是需要验证自建证书，需要设置为YES
        //validatesDomainName 是否需要验证域名，默认为YES；
    });

    return afManager;
}

- (CYPAFHTTPRequestSerializer*)requestKeyValueSeralizer
{
    return [CYPAFHTTPRequestSerializer serializer];
}

- (CYPAFHTTPRequestSerializer *)requestJsonSeralizer
{
    return [CYPAFJSONRequestSerializer serializer];
}


-(CYPAFHTTPRequestOperation *)requestWithMethod:(NSString *)method
                                  baseUrlStr:(NSString *)baseUrlStr
                                      urlStr:(NSString *)urlStr
                                      params:(NSDictionary *)params
                                     headers:(NSDictionary *)headers
                                        time:(NSInteger)timer
                                connectCount:(NSInteger)connectCount
                                         syn:(NSInteger)syn
                                     success:(HttpRequestSuccessBlock)success
                                     failure:(HttpRequestFailureBlock)failure
{
    NSString * allUrlStr = [[NSString alloc] initWithFormat:@"%@%@",baseUrlStr,urlStr];
    NSURL * url = [[NSURL alloc] initWithString:allUrlStr];
    
    
    CYPAFHTTPRequestOperationManager * manager = [C_HTTPRequest defaultManager];
    if (timer) {
        manager.requestSerializer.timeoutInterval = timer;
    }else{
        manager.requestSerializer.timeoutInterval = 60;
    }
    /**
     *  设置连接池数量
     */
    if (connectCount) {
        manager.operationQueue.maxConcurrentOperationCount = connectCount;
    }else{
        manager.operationQueue.maxConcurrentOperationCount = -1;
    }
    
    NSMutableURLRequest * request =
    [manager.requestSerializer requestWithMethod:method
                                       URLString:[url absoluteString]
                                      parameters:params
                                           error:nil];
    if (headers) {
        [request setAllHTTPHeaderFields:headers];
    }

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    CYPAFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request success:^(CYPAFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if (success) {
            success(responseObject);
        }
        [operation cancel];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(CYPAFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        [operation cancel];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    [manager.operationQueue addOperation:operation];
    
    
    
    return operation;
}




+ (CYPAFHTTPRequestOperation *)uploadImage:(UIImage *)image
                                 urlStr:(NSString *)urlStr
                             parameters:(id)parameters
                                headers:(NSDictionary *)headers
                                   name:(NSString *)name
                               fileName:(NSString *)fileName
                                success:(HttpRequestSuccessBlock)success
                                failure:(HttpRequestFailureBlock)failure
                               progress:(void (^)(float progress))progress
{
    
    
    CYPAFHTTPRequestOperationManager * manager = [self defaultManager];
    manager.requestSerializer.timeoutInterval = 60.f;
    manager.requestSerializer = [CYPAFHTTPRequestSerializer serializer];
    
    NSString * allUrlStr = [[NSString alloc] initWithFormat:@"%@",urlStr];
    NSURL * url = [[NSURL alloc] initWithString:allUrlStr];
    
    NSMutableURLRequest * request =
    [manager.requestSerializer
     multipartFormRequestWithMethod:@"POST"
                          URLString:[url absoluteString]
                         parameters:parameters
          constructingBodyWithBlock:^(id<CYPAFMultipartFormData>  _Nonnull formData) {
        
              NSData *data = UIImageJPEGRepresentation(image, 1.0f);
              NSUInteger limitImageSize = 700 * 1024;
              if (data.length > limitImageSize) {
                  data = UIImageJPEGRepresentation(image, (limitImageSize / data.length));
              }
              [formData appendPartWithFileData:data
                                          name:name
                                      fileName:fileName
                                      mimeType:@"image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg"];
                                    }
     error:nil];
    
    
    if (headers) {
        [request setAllHTTPHeaderFields:headers];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    CYPAFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request success:^(CYPAFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if (success) {
            success(responseObject);
        }
        [operation cancel];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(CYPAFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        [operation cancel];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (progress) {
            float p = (float)totalBytesWritten / totalBytesExpectedToWrite;
            progress(p);
        }
    }];
   
    
    [manager.operationQueue addOperation:operation];
    
    return operation;
}

@end
