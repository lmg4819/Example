// UIWebView+CYPAFNetworking.m
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

#import "UIWebView+CYPAFNetworking.h"

#import <objc/runtime.h>

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import "CYPAFHTTPRequestOperation.h"
#import "CYPAFURLResponseSerialization.h"
#import "CYPAFURLRequestSerialization.h"

@interface UIWebView (_CYPAFNetworking)
@property (readwrite, nonatomic, strong, setter = CYPAF_setHTTPRequestOperation:) CYPAFHTTPRequestOperation *CYPAF_HTTPRequestOperation;
@end

@implementation UIWebView (_CYPAFNetworking)

- (CYPAFHTTPRequestOperation *)CYPAF_HTTPRequestOperation {
    return (CYPAFHTTPRequestOperation *)objc_getAssociatedObject(self, @selector(CYPAF_HTTPRequestOperation));
}

- (void)CYPAF_setHTTPRequestOperation:(CYPAFHTTPRequestOperation *)operation {
    objc_setAssociatedObject(self, @selector(CYPAF_HTTPRequestOperation), operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark -

@implementation UIWebView (CYPAFNetworking)

- (CYPAFHTTPRequestSerializer <CYPAFURLRequestSerialization> *)requestSerializer {
    static CYPAFHTTPRequestSerializer <CYPAFURLRequestSerialization> *_CYPAF_defaultRequestSerializer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CYPAF_defaultRequestSerializer = [CYPAFHTTPRequestSerializer serializer];
    });

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    return objc_getAssociatedObject(self, @selector(requestSerializer)) ?: _CYPAF_defaultRequestSerializer;
#pragma clang diagnostic pop
}

- (void)setRequestSerializer:(CYPAFHTTPRequestSerializer<CYPAFURLRequestSerialization> *)requestSerializer {
    objc_setAssociatedObject(self, @selector(requestSerializer), requestSerializer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CYPAFHTTPResponseSerializer <CYPAFURLResponseSerialization> *)responseSerializer {
    static CYPAFHTTPResponseSerializer <CYPAFURLResponseSerialization> *_CYPAF_defaultResponseSerializer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CYPAF_defaultResponseSerializer = [CYPAFHTTPResponseSerializer serializer];
    });

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    return objc_getAssociatedObject(self, @selector(responseSerializer)) ?: _CYPAF_defaultResponseSerializer;
#pragma clang diagnostic pop
}

- (void)setResponseSerializer:(CYPAFHTTPResponseSerializer<CYPAFURLResponseSerialization> *)responseSerializer {
    objc_setAssociatedObject(self, @selector(responseSerializer), responseSerializer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (void)loadRequest:(NSURLRequest *)request
           progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
            success:(NSString * (^)(NSHTTPURLResponse *response, NSString *HTML))success
            failure:(void (^)(NSError *error))failure
{
    [self loadRequest:request MIMEType:nil textEncodingName:nil progress:progress success:^NSData *(NSHTTPURLResponse *response, NSData *data) {
        NSStringEncoding stringEncoding = NSUTF8StringEncoding;
        if (response.textEncodingName) {
            CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)response.textEncodingName);
            if (encoding != kCFStringEncodingInvalidId) {
                stringEncoding = CFStringConvertEncodingToNSStringEncoding(encoding);
            }
        }

        NSString *string = [[NSString alloc] initWithData:data encoding:stringEncoding];
        if (success) {
            string = success(response, string);
        }

        return [string dataUsingEncoding:stringEncoding];
    } failure:failure];
}

- (void)loadRequest:(NSURLRequest *)request
           MIMEType:(NSString *)MIMEType
   textEncodingName:(NSString *)textEncodingName
           progress:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
            success:(NSData * (^)(NSHTTPURLResponse *response, NSData *data))success
            failure:(void (^)(NSError *error))failure
{
    NSParameterAssert(request);

    if (self.CYPAF_HTTPRequestOperation) {
        [self.CYPAF_HTTPRequestOperation cancel];
    }

    request = [self.requestSerializer requestBySerializingRequest:request withParameters:nil error:nil];

    self.CYPAF_HTTPRequestOperation = [[CYPAFHTTPRequestOperation alloc] initWithRequest:request];
    self.CYPAF_HTTPRequestOperation.responseSerializer = self.responseSerializer;

    __weak __typeof(self)weakSelf = self;
    [self.CYPAF_HTTPRequestOperation setDownloadProgressBlock:progress];
    [self.CYPAF_HTTPRequestOperation setCompletionBlockWithSuccess:^(CYPAFHTTPRequestOperation *operation, id __unused responseObject) {
        NSData *data = success ? success(operation.response, operation.responseData) : operation.responseData;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf loadData:data MIMEType:(MIMEType ?: [operation.response MIMEType]) textEncodingName:(textEncodingName ?: [operation.response textEncodingName]) baseURL:[operation.response URL]];

        if ([strongSelf.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
            [strongSelf.delegate webViewDidFinishLoad:strongSelf];
        }

#pragma clang diagnostic pop
    } failure:^(CYPAFHTTPRequestOperation * __unused operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    [self.CYPAF_HTTPRequestOperation start];

    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:self];
    }
}

@end

#endif
