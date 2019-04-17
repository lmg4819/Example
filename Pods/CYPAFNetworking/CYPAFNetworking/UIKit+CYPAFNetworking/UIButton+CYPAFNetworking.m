// UIButton+CYPAFNetworking.m
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

#import "UIButton+CYPAFNetworking.h"

#import <objc/runtime.h>

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import "CYPAFURLResponseSerialization.h"
#import "CYPAFHTTPRequestOperation.h"

#import "UIImageView+CYPAFNetworking.h"

@interface UIButton (_CYPAFNetworking)
@end

@implementation UIButton (_CYPAFNetworking)

+ (NSOperationQueue *)CYPAF_sharedImageRequestOperationQueue {
    static NSOperationQueue *_CYPAF_sharedImageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CYPAF_sharedImageRequestOperationQueue = [[NSOperationQueue alloc] init];
        _CYPAF_sharedImageRequestOperationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    });

    return _CYPAF_sharedImageRequestOperationQueue;
}

#pragma mark -

static char CYPAFImageRequestOperationNormal;
static char CYPAFImageRequestOperationHighlighted;
static char CYPAFImageRequestOperationSelected;
static char CYPAFImageRequestOperationDisabled;

static const char * CYPAF_imageRequestOperationKeyForState(UIControlState state) {
    switch (state) {
        case UIControlStateHighlighted:
            return &CYPAFImageRequestOperationHighlighted;
        case UIControlStateSelected:
            return &CYPAFImageRequestOperationSelected;
        case UIControlStateDisabled:
            return &CYPAFImageRequestOperationDisabled;
        case UIControlStateNormal:
        default:
            return &CYPAFImageRequestOperationNormal;
    }
}

- (CYPAFHTTPRequestOperation *)CYPAF_imageRequestOperationForState:(UIControlState)state {
    return (CYPAFHTTPRequestOperation *)objc_getAssociatedObject(self, CYPAF_imageRequestOperationKeyForState(state));
}

- (void)CYPAF_setImageRequestOperation:(CYPAFHTTPRequestOperation *)imageRequestOperation
                           forState:(UIControlState)state
{
    objc_setAssociatedObject(self, CYPAF_imageRequestOperationKeyForState(state), imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

static char CYPAFBackgroundImageRequestOperationNormal;
static char CYPAFBackgroundImageRequestOperationHighlighted;
static char CYPAFBackgroundImageRequestOperationSelected;
static char CYPAFBackgroundImageRequestOperationDisabled;

static const char * CYPAF_backgroundImageRequestOperationKeyForState(UIControlState state) {
    switch (state) {
        case UIControlStateHighlighted:
            return &CYPAFBackgroundImageRequestOperationHighlighted;
        case UIControlStateSelected:
            return &CYPAFBackgroundImageRequestOperationSelected;
        case UIControlStateDisabled:
            return &CYPAFBackgroundImageRequestOperationDisabled;
        case UIControlStateNormal:
        default:
            return &CYPAFBackgroundImageRequestOperationNormal;
    }
}

- (CYPAFHTTPRequestOperation *)CYPAF_backgroundImageRequestOperationForState:(UIControlState)state {
    return (CYPAFHTTPRequestOperation *)objc_getAssociatedObject(self, CYPAF_backgroundImageRequestOperationKeyForState(state));
}

- (void)CYPAF_setBackgroundImageRequestOperation:(CYPAFHTTPRequestOperation *)imageRequestOperation
                                     forState:(UIControlState)state
{
    objc_setAssociatedObject(self, CYPAF_backgroundImageRequestOperationKeyForState(state), imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark -

@implementation UIButton (CYPAFNetworking)

+ (id <CYPAFImageCache>)sharedImageCache {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    return objc_getAssociatedObject(self, @selector(sharedImageCache)) ?: [UIImageView sharedImageCache];
#pragma clang diagnostic pop
}

+ (void)setSharedImageCache:(__nullable id <CYPAFImageCache>)imageCache {
    objc_setAssociatedObject(self, @selector(sharedImageCache), imageCache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (id <CYPAFURLResponseSerialization>)imageResponseSerializer {
    static id <CYPAFURLResponseSerialization> _CYPAF_defaultImageResponseSerializer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CYPAF_defaultImageResponseSerializer = [CYPAFImageResponseSerializer serializer];
    });

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    return objc_getAssociatedObject(self, @selector(imageResponseSerializer)) ?: _CYPAF_defaultImageResponseSerializer;
#pragma clang diagnostic pop
}

- (void)setImageResponseSerializer:(id <CYPAFURLResponseSerialization>)serializer {
    objc_setAssociatedObject(self, @selector(imageResponseSerializer), serializer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (void)setImageForState:(UIControlState)state
                 withURL:(NSURL *)url
{
    [self setImageForState:state withURL:url placeholderImage:nil];
}

- (void)setImageForState:(UIControlState)state
                 withURL:(NSURL *)url
        placeholderImage:(UIImage *)placeholderImage
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];

    [self setImageForState:state withURLRequest:request placeholderImage:placeholderImage success:nil failure:nil];
}

- (void)setImageForState:(UIControlState)state
          withURLRequest:(NSURLRequest *)urlRequest
        placeholderImage:(UIImage *)placeholderImage
                 success:(void (^)(NSURLRequest *request, NSHTTPURLResponse * __nullable response, UIImage *image))success
                 failure:(void (^)(NSError *error))failure
{
    [self cancelImageRequestOperationForState:state];

    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage) {
        if (success) {
            success(urlRequest, nil, cachedImage);
        } else {
            [self setImage:cachedImage forState:state];
        }

        [self CYPAF_setImageRequestOperation:nil forState:state];
    } else {
        if (placeholderImage) {
            [self setImage:placeholderImage forState:state];
        }

        __weak __typeof(self)weakSelf = self;
        CYPAFHTTPRequestOperation *imageRequestOperation = [[CYPAFHTTPRequestOperation alloc] initWithRequest:urlRequest];
        imageRequestOperation.responseSerializer = self.imageResponseSerializer;
        [imageRequestOperation setCompletionBlockWithSuccess:^(CYPAFHTTPRequestOperation *operation, id responseObject) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if ([[urlRequest URL] isEqual:[operation.request URL]]) {
                if (success) {
                    success(operation.request, operation.response, responseObject);
                } else if (responseObject) {
                    [strongSelf setImage:responseObject forState:state];
                }
            }
            [[[strongSelf class] sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
        } failure:^(CYPAFHTTPRequestOperation *operation, NSError *error) {
            if ([[urlRequest URL] isEqual:[operation.request URL]]) {
                if (failure) {
                    failure(error);
                }
            }
        }];

        [self CYPAF_setImageRequestOperation:imageRequestOperation forState:state];
        [[[self class] CYPAF_sharedImageRequestOperationQueue] addOperation:imageRequestOperation];
    }
}

#pragma mark -

- (void)setBackgroundImageForState:(UIControlState)state
                           withURL:(NSURL *)url
{
    [self setBackgroundImageForState:state withURL:url placeholderImage:nil];
}

- (void)setBackgroundImageForState:(UIControlState)state
                           withURL:(NSURL *)url
                  placeholderImage:(UIImage *)placeholderImage
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];

    [self setBackgroundImageForState:state withURLRequest:request placeholderImage:placeholderImage success:nil failure:nil];
}

- (void)setBackgroundImageForState:(UIControlState)state
                    withURLRequest:(NSURLRequest *)urlRequest
                  placeholderImage:(UIImage *)placeholderImage
                           success:(void (^)(NSURLRequest *request, NSHTTPURLResponse * __nullable response, UIImage *image))success
                           failure:(void (^)(NSError *error))failure
{
    [self cancelBackgroundImageRequestOperationForState:state];

    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage) {
        if (success) {
            success(urlRequest, nil, cachedImage);
        } else {
            [self setBackgroundImage:cachedImage forState:state];
        }

        [self CYPAF_setBackgroundImageRequestOperation:nil forState:state];
    } else {
        if (placeholderImage) {
            [self setBackgroundImage:placeholderImage forState:state];
        }

        __weak __typeof(self)weakSelf = self;
        CYPAFHTTPRequestOperation *backgroundImageRequestOperation = [[CYPAFHTTPRequestOperation alloc] initWithRequest:urlRequest];
        backgroundImageRequestOperation.responseSerializer = self.imageResponseSerializer;
        [backgroundImageRequestOperation setCompletionBlockWithSuccess:^(CYPAFHTTPRequestOperation *operation, id responseObject) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if ([[urlRequest URL] isEqual:[operation.request URL]]) {
                if (success) {
                    success(operation.request, operation.response, responseObject);
                } else if (responseObject) {
                    [strongSelf setBackgroundImage:responseObject forState:state];
                }
            }
            [[[strongSelf class] sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
        } failure:^(CYPAFHTTPRequestOperation *operation, NSError *error) {
            if ([[urlRequest URL] isEqual:[operation.request URL]]) {
                if (failure) {
                    failure(error);
                }
            }
        }];

        [self CYPAF_setBackgroundImageRequestOperation:backgroundImageRequestOperation forState:state];
        [[[self class] CYPAF_sharedImageRequestOperationQueue] addOperation:backgroundImageRequestOperation];
    }
}

#pragma mark -

- (void)cancelImageRequestOperationForState:(UIControlState)state {
    [[self CYPAF_imageRequestOperationForState:state] cancel];
    [self CYPAF_setImageRequestOperation:nil forState:state];
}

- (void)cancelBackgroundImageRequestOperationForState:(UIControlState)state {
    [[self CYPAF_backgroundImageRequestOperationForState:state] cancel];
    [self CYPAF_setBackgroundImageRequestOperation:nil forState:state];
}

@end

#endif
