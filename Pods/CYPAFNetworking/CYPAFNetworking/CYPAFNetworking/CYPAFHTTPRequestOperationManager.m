// CYPAFHTTPRequestOperationManager.m
// Copyright (c) 2011–2015 Alamofire Software Foundation (http://alamofire.org/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

#import "CYPAFHTTPRequestOperationManager.h"
#import "CYPAFHTTPRequestOperation.h"

#import <Availability.h>
#import <Security/Security.h>

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#import <UIKit/UIKit.h>
#endif

@interface CYPAFHTTPRequestOperationManager ()
@property (readwrite, nonatomic, strong) NSURL *baseURL;
@end

@implementation CYPAFHTTPRequestOperationManager

+ (instancetype)manager {
    return [[self alloc] initWithBaseURL:nil];
}

- (instancetype)init {
    return [self initWithBaseURL:nil];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super init];
    if (!self) {
        return nil;
    }

    // Ensure terminal slash for baseURL path, so that NSURL +URLWithString:relativeToURL: works as expected
    if ([[url path] length] > 0 && ![[url absoluteString] hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }

    self.baseURL = url;

    self.requestSerializer = [CYPAFHTTPRequestSerializer serializer];
    self.responseSerializer = [CYPAFJSONResponseSerializer serializer];

    self.securityPolicy = [CYPAFSecurityPolicy defaultPolicy];

    self.reachabilityManager = [CYPAFNetworkReachabilityManager sharedManager];

    self.operationQueue = [[NSOperationQueue alloc] init];

    self.shouldUseCredentialStorage = YES;

    return self;
}

#pragma mark -

#ifdef _SYSTEMCONFIGURATION_H
#endif

- (void)setRequestSerializer:(CYPAFHTTPRequestSerializer <CYPAFURLRequestSerialization> *)requestSerializer {
    NSParameterAssert(requestSerializer);

    _requestSerializer = requestSerializer;
}

- (void)setResponseSerializer:(CYPAFHTTPResponseSerializer <CYPAFURLResponseSerialization> *)responseSerializer {
    NSParameterAssert(responseSerializer);

    _responseSerializer = responseSerializer;
}

#pragma mark -

- (CYPAFHTTPRequestOperation *)HTTPRequestOperationWithHTTPMethod:(NSString *)method
                                                     URLString:(NSString *)URLString
                                                    parameters:(id)parameters
                                                       success:(void (^)(CYPAFHTTPRequestOperation *operation, id responseObject))success
                                                       failure:(void (^)(CYPAFHTTPRequestOperation *operation, NSError *error))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }

        return nil;
    }

    return [self HTTPRequestOperationWithRequest:request success:success failure:failure];
}

- (CYPAFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(CYPAFHTTPRequestOperation *operation, id responseObject))success
                                                    failure:(void (^)(CYPAFHTTPRequestOperation *operation, NSError *error))failure
{
    CYPAFHTTPRequestOperation *operation = [[CYPAFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = self.responseSerializer;
    operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
    operation.credential = self.credential;
    operation.securityPolicy = self.securityPolicy;

    [operation setCompletionBlockWithSuccess:success failure:failure];
    operation.completionQueue = self.completionQueue;
    operation.completionGroup = self.completionGroup;

    return operation;
}

#pragma mark -

- (CYPAFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(CYPAFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(CYPAFHTTPRequestOperation *operation, NSError *error))failure
{
    CYPAFHTTPRequestOperation *operation = [self HTTPRequestOperationWithHTTPMethod:@"GET" URLString:URLString parameters:parameters success:success failure:failure];

    [self.operationQueue addOperation:operation];

    return operation;
}

- (CYPAFHTTPRequestOperation *)HEAD:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(CYPAFHTTPRequestOperation *operation))success
                         failure:(void (^)(CYPAFHTTPRequestOperation *operation, NSError *error))failure
{
    CYPAFHTTPRequestOperation *operation = [self HTTPRequestOperationWithHTTPMethod:@"HEAD" URLString:URLString parameters:parameters success:^(CYPAFHTTPRequestOperation *requestOperation, __unused id responseObject) {
        if (success) {
            success(requestOperation);
        }
    } failure:failure];

    [self.operationQueue addOperation:operation];

    return operation;
}

- (CYPAFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(CYPAFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(CYPAFHTTPRequestOperation *operation, NSError *error))failure
{
    CYPAFHTTPRequestOperation *operation = [self HTTPRequestOperationWithHTTPMethod:@"POST" URLString:URLString parameters:parameters success:success failure:failure];

    [self.operationQueue addOperation:operation];

    return operation;
}

- (CYPAFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <CYPAFMultipartFormData> formData))block
                         success:(void (^)(CYPAFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(CYPAFHTTPRequestOperation *operation, NSError *error))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }

        return nil;
    }

    CYPAFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];

    [self.operationQueue addOperation:operation];

    return operation;
}

- (CYPAFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(CYPAFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(CYPAFHTTPRequestOperation *operation, NSError *error))failure
{
    CYPAFHTTPRequestOperation *operation = [self HTTPRequestOperationWithHTTPMethod:@"PUT" URLString:URLString parameters:parameters success:success failure:failure];

    [self.operationQueue addOperation:operation];

    return operation;
}

- (CYPAFHTTPRequestOperation *)PATCH:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(CYPAFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(CYPAFHTTPRequestOperation *operation, NSError *error))failure
{
    CYPAFHTTPRequestOperation *operation = [self HTTPRequestOperationWithHTTPMethod:@"PATCH" URLString:URLString parameters:parameters success:success failure:failure];

    [self.operationQueue addOperation:operation];

    return operation;
}

- (CYPAFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(CYPAFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(CYPAFHTTPRequestOperation *operation, NSError *error))failure
{
    CYPAFHTTPRequestOperation *operation = [self HTTPRequestOperationWithHTTPMethod:@"DELETE" URLString:URLString parameters:parameters success:success failure:failure];

    [self.operationQueue addOperation:operation];

    return operation;
}

#pragma mark - NSObject

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, baseURL: %@, operationQueue: %@>", NSStringFromClass([self class]), self, [self.baseURL absoluteString], self.operationQueue];
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSURL *baseURL = [decoder decodeObjectForKey:NSStringFromSelector(@selector(baseURL))];

    self = [self initWithBaseURL:baseURL];
    if (!self) {
        return nil;
    }

    self.requestSerializer = [decoder decodeObjectOfClass:[CYPAFHTTPRequestSerializer class] forKey:NSStringFromSelector(@selector(requestSerializer))];
    self.responseSerializer = [decoder decodeObjectOfClass:[CYPAFHTTPResponseSerializer class] forKey:NSStringFromSelector(@selector(responseSerializer))];
    CYPAFSecurityPolicy *decodedPolicy = [decoder decodeObjectOfClass:[CYPAFSecurityPolicy class] forKey:NSStringFromSelector(@selector(securityPolicy))];
    if (decodedPolicy) {
        self.securityPolicy = decodedPolicy;
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.baseURL forKey:NSStringFromSelector(@selector(baseURL))];
    [coder encodeObject:self.requestSerializer forKey:NSStringFromSelector(@selector(requestSerializer))];
    [coder encodeObject:self.responseSerializer forKey:NSStringFromSelector(@selector(responseSerializer))];
    [coder encodeObject:self.securityPolicy forKey:NSStringFromSelector(@selector(securityPolicy))];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    CYPAFHTTPRequestOperationManager *HTTPClient = [[[self class] allocWithZone:zone] initWithBaseURL:self.baseURL];

    HTTPClient.requestSerializer = [self.requestSerializer copyWithZone:zone];
    HTTPClient.responseSerializer = [self.responseSerializer copyWithZone:zone];
    HTTPClient.securityPolicy = [self.securityPolicy copyWithZone:zone];

    return HTTPClient;
}

@end
