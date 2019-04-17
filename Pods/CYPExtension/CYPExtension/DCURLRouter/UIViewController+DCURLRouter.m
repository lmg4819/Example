//
//  UIViewController+DCURLRouter.m
//  DCURLRouterDemo
//
//  Created by Dariel on 16/8/17.
//  Copyright © 2016年 DarielChen. All rights reserved.
//

#import "UIViewController+DCURLRouter.h"
#import <objc/runtime.h>
#import "DCURLRouter.h"
static char URLoriginUrl;
static char URLpath;
static char URLparams;

static char dataCallBack;

@implementation UIViewController (DCURLRouter)


- (void)setOriginUrl:(NSURL *)originUrl {
    // 为分类设置属性值
    objc_setAssociatedObject(self, &URLoriginUrl,
                             originUrl,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURL *)originUrl {
    // 获取分类的属性值
    return objc_getAssociatedObject(self, &URLoriginUrl);
}

- (void)setValueBlock:(void (^)(id _Nonnull))valueBlock {
    objc_setAssociatedObject(self, &dataCallBack,
                             valueBlock,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(id _Nonnull))valueBlock {
    return objc_getAssociatedObject(self, &dataCallBack);
}

- (NSString *)path {
    return objc_getAssociatedObject(self, &URLpath);
}

- (void)setPath:(NSURL *)path{
    objc_setAssociatedObject(self, &URLpath,
                             path,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, &URLparams);
}

- (void)setParams:(NSDictionary *)params{
    objc_setAssociatedObject(self, &URLparams,
                             params,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIViewController *)initFromString:(NSString *)urlString fromConfig:(NSDictionary *)configDict{
    
    // 支持对中文字符的编码
    NSString *encodeStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [UIViewController initFromURL:[NSURL URLWithString:encodeStr] withQuery:nil fromConfig:configDict reverseBlock:nil];
}

+ (UIViewController *)initFromString:(NSString *)urlString withQuery:(NSDictionary *)query fromConfig:(NSDictionary *)configDict{
    
    // 支持对中文字符的编码
    NSString *encodeStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [UIViewController initFromURL:[NSURL URLWithString:encodeStr] withQuery:query fromConfig:configDict reverseBlock:nil] ;
}

+ (UIViewController *)initFromString:(NSString *)urlString withQuery:(NSDictionary *)query fromConfig:(NSDictionary *)configDict reverseBlock:(void (^)(id _Nonnull))reverse{
    
    NSString *encodeStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [UIViewController initFromURL:[NSURL URLWithString:encodeStr] withQuery:query fromConfig:configDict reverseBlock:reverse] ;
}

- (void)open:(NSURL *)url withQuery:(NSDictionary *)query{
    self.path = [url path];
    self.originUrl = url;
    if (query) {   // 如果自定义url后面有拼接参数,而且又通过query传入了参数,那么优先query传入了参数
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        dic = [self paramsURL:url];
        
        [dic addEntriesFromDictionary:query];
        [self handleRouterH5UrlWithURL:url dic:dic];
        self.params = dic;
    }else {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        dic = [self paramsURL:url];
        //处理跳转h5 url带参数的情况
        [self handleRouterH5UrlWithURL:url dic:dic];
        self.params = dic;
        
       
    }
}
- (void)handleRouterH5UrlWithURL:(NSURL *)url dic:(NSMutableDictionary *)dic{
    if (NSNotFound != [url.absoluteString rangeOfString:@"?"].location) {
        //参数url
        NSString *paramString = [url.absoluteString substringFromIndex:
                                 ([url.absoluteString rangeOfString:@"?"].location + 1)];
        if (NSNotFound != [paramString rangeOfString:@"?"].location) {
            //有h5地址 取h5后面的参数
            NSString *paramString1 = [paramString substringFromIndex:
                                     ([paramString rangeOfString:@"?"].location + 1)];
            //取allkeys
            NSArray *allkeyArr = dic.allKeys;
            if ([allkeyArr isKindOfClass:[NSArray class]]&&allkeyArr.count) {
                for (int i = 0; i < allkeyArr.count; i++) {
                    NSString * Kstr = allkeyArr[i];
                    NSString *Vstr = dic[Kstr];
                    if (NSNotFound != [Vstr rangeOfString:@"?"].location) {
                         NSString *Nurlstring = [Vstr substringToIndex:[Vstr rangeOfString:@"?"].location +1];
                        NSString *newStr = [Nurlstring stringByAppendingString:paramString1];
                        [dic setObject:newStr forKey:Kstr];
                    }
                    
                }
            }
            
        }
    }
}
+ (UIViewController *)initFromURL:(NSURL *)url withQuery:(NSDictionary *)query fromConfig:(NSDictionary *)configDict reverseBlock:(void (^)(id _Nonnull))reverse
{
    UIViewController *VC = nil;
    NSString *home;
    if(url.path == nil){ // 处理url,去掉有可能会拼接的参数
        home = [NSString stringWithFormat:@"%@://%@", url.scheme, url.host];
    }else{
        home = [NSString stringWithFormat:@"%@://%@%@", url.scheme, url.host,url.path];
    }
    if([configDict.allKeys containsObject:url.scheme]){ // 字典中的所有的key是否包含传入的协议头
        id config = [configDict objectForKey:url.scheme]; // 根据协议头取出值
        Class class = nil;
        if([config isKindOfClass:[NSString class]]){ //当协议头是http https的情况
            class =  NSClassFromString(config);
        }else if([config isKindOfClass:[NSDictionary class]]){ // 自定义的url情况
            NSDictionary *dict = (NSDictionary *)config;
            if([dict.allKeys containsObject:home]){
                class =  NSClassFromString([dict objectForKey:home]); // 根据key拿到对应的控制器名称
                if (class == nil) { // 兼容swift,字符串转类名的时候前面加上命名空间
                    NSString *spaceName = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
                    class =  NSClassFromString([NSString stringWithFormat:@"%@.%@",spaceName,[dict objectForKey:home]]);
                }
            }
        }
        if(class !=nil){
            VC = [[class alloc]init];
            if([VC respondsToSelector:@selector(open:withQuery:)]){
                [VC open:url withQuery:query];
            }
        }
        // 处理网络地址的情况
        if ([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"]) {
            class =  NSClassFromString([configDict objectForKey:url.scheme]);
            VC.params = @{@"urlStr": [url absoluteString]};
        }
    }
    
    if (!VC) {
        [[DCURLRouter sharedDCURLRouter].interceptor cypInterceptOriginURL:[url absoluteString] withQuery:query reverseBlock:reverse];
    }
    
    return VC;
}

// 将url的参数部分转化成字典
- (NSMutableDictionary *)paramsURL:(NSURL *)url {
    
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    if (NSNotFound != [url.absoluteString rangeOfString:@"?"].location) {
        NSString *paramString = [url.absoluteString substringFromIndex:
                                 ([url.absoluteString rangeOfString:@"?"].location + 1)];
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString* key = [[kvPair objectAtIndex:0] stringByRemovingPercentEncoding];
                NSString* value = [[kvPair objectAtIndex:1] stringByRemovingPercentEncoding];
                [pairs setValue:value forKey:key];
            }else if (kvPair.count > 2)//处理url里面出现多个‘=’时候的问题
            {
                NSRange range = [pairString rangeOfString:@"="];
                NSString* keys = [pairString substringToIndex:range.location];
                NSString* values = [pairString substringFromIndex:range.location+1];
                [pairs setValue:values forKey:keys];
                
            }
        }
    }
    
    return pairs;
}

@end
