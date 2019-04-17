// UIImageView+CYPAFNetworking.m
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

#import "UIImageView+CYPAFNetworking.h"

#import <objc/runtime.h>

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import "CYPAFHTTPRequestOperation.h"

@interface CYPAFImageCache : NSCache <CYPAFImageCache>
@end

#pragma mark -

@interface UIImageView (_CYPAFNetworking)
@property (readwrite, nonatomic, strong, setter = CYPAF_setImageRequestOperation:) CYPAFHTTPRequestOperation *CYPAF_imageRequestOperation;
@end

@implementation UIImageView (_CYPAFNetworking)

+ (NSOperationQueue *)CYPAF_sharedImageRequestOperationQueue {
    static NSOperationQueue *_CYPAF_sharedImageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CYPAF_sharedImageRequestOperationQueue = [[NSOperationQueue alloc] init];
        _CYPAF_sharedImageRequestOperationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    });

    return _CYPAF_sharedImageRequestOperationQueue;
}

- (CYPAFHTTPRequestOperation *)CYPAF_imageRequestOperation {
    return (CYPAFHTTPRequestOperation *)objc_getAssociatedObject(self, @selector(CYPAF_imageRequestOperation));
}

- (void)CYPAF_setImageRequestOperation:(CYPAFHTTPRequestOperation *)imageRequestOperation {
    objc_setAssociatedObject(self, @selector(CYPAF_imageRequestOperation), imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark -

@implementation UIImageView (CYPAFNetworking)
@dynamic imageResponseSerializer;

+ (id <CYPAFImageCache>)sharedImageCache {
    static CYPAFImageCache *_CYPAF_defaultImageCache = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _CYPAF_defaultImageCache = [[CYPAFImageCache alloc] init];

        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __unused notification) {
            [_CYPAF_defaultImageCache removeAllObjects];
        }];
    });

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    return objc_getAssociatedObject(self, @selector(sharedImageCache)) ?: _CYPAF_defaultImageCache;
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

- (void)setImageWithURL:(NSURL *)url {
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];

    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:nil failure:nil];
}

- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(UIImage *)placeholderImage
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse * __nullable response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse * __nullable response, NSError *error))failure
{
    [self cancelImageRequestOperation];

    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage) {
        if (success) {
            success(urlRequest, nil, cachedImage);
        } else {
            self.image = cachedImage;
        }

        self.CYPAF_imageRequestOperation = nil;
    } else {
        if (placeholderImage) {
            self.image = placeholderImage;
        }

        __weak __typeof(self)weakSelf = self;
        self.CYPAF_imageRequestOperation = [[CYPAFHTTPRequestOperation alloc] initWithRequest:urlRequest];
        self.CYPAF_imageRequestOperation.responseSerializer = self.imageResponseSerializer;
        [self.CYPAF_imageRequestOperation setCompletionBlockWithSuccess:^(CYPAFHTTPRequestOperation *operation, id responseObject) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if ([[urlRequest URL] isEqual:[strongSelf.CYPAF_imageRequestOperation.request URL]]) {
                if (success) {
                    success(urlRequest, operation.response, responseObject);
                } else if (responseObject) {
                    strongSelf.image = responseObject;
                }

                if (operation == strongSelf.CYPAF_imageRequestOperation){
                        strongSelf.CYPAF_imageRequestOperation = nil;
                }
            }

            [[[strongSelf class] sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
        } failure:^(CYPAFHTTPRequestOperation *operation, NSError *error) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if ([[urlRequest URL] isEqual:[strongSelf.CYPAF_imageRequestOperation.request URL]]) {
                if (failure) {
                    failure(urlRequest, operation.response, error);
                }

                if (operation == strongSelf.CYPAF_imageRequestOperation){
                        strongSelf.CYPAF_imageRequestOperation = nil;
                }
            }
        }];

        [[[self class] CYPAF_sharedImageRequestOperationQueue] addOperation:self.CYPAF_imageRequestOperation];
    }
}

- (void)cancelImageRequestOperation {
    [self.CYPAF_imageRequestOperation cancel];
    self.CYPAF_imageRequestOperation = nil;
}

@end

#pragma mark -

static inline NSString * CYPAFImageCacheKeyFromURLRequest(NSURLRequest *request) {
    return [[request URL] absoluteString];
}

@implementation CYPAFImageCache

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request {
    switch ([request cachePolicy]) {
        case NSURLRequestReloadIgnoringCacheData:
        case NSURLRequestReloadIgnoringLocalAndRemoteCacheData:
            return nil;
        default:
            break;
    }

	return [self objectForKey:CYPAFImageCacheKeyFromURLRequest(request)];
}

- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request
{
    if (image && request) {
        [self setObject:image forKey:CYPAFImageCacheKeyFromURLRequest(request)];
    }
}

@end

#endif
