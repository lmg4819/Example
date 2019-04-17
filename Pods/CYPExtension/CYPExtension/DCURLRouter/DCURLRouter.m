//
//  DCURLRouter.m
//  DCURLRouterDemo
//
//  Created by Dariel on 16/8/17.
//  Copyright © 2016年 DarielChen. All rights reserved.
//

#import "DCURLRouter.h"
#import "DCURLNavgation.h"
//#import "NSObject+MJKeyValue.h"
#import "UIViewController+CYPReserveValue.h"
#import "NSObject+CYPCurrentVC.h"
@interface DCURLRouter()

/** 存储读取的plist文件数据 */
@property(nonatomic,strong) NSDictionary *configDict;
@property (nonatomic, strong) NSDictionary *pushOrPresentPlist;
@end

@implementation DCURLRouter
DCSingletonM(DCURLRouter)

+ (void)loadConfigDictFromPlist:(NSString *)pistName{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:pistName ofType:nil];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (configDict) {
        [DCURLRouter sharedDCURLRouter].configDict = configDict;
    }else {
        return;
        NSAssert(0, @"请按照说明添加对应的plist文件");
    }
}

+ (void)loadConfigDictFromPath:(NSString *)path
{
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (configDict) {
        [DCURLRouter sharedDCURLRouter].configDict = configDict;
    }else {
        return;
        NSAssert(0, @"请按照说明添加对应的plist文件");
    }
}

+ (void)loadPushOrPresentPlistFromPath:(NSString *)path
{
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (configDict) {
        [DCURLRouter sharedDCURLRouter].pushOrPresentPlist = configDict;
    }else {
        return;
        NSAssert(0, @"请按照说明添加对应的plist文件");
    }
}

+ (void)loadPushOrPresentPlist:(NSString *)pushOrPresentName
{
    NSString *pushOrPresentPath = [[NSBundle mainBundle] pathForResource:pushOrPresentName ofType:nil];
    NSDictionary *pushOrPresentPlist = [NSDictionary dictionaryWithContentsOfFile:pushOrPresentPath];
    if (pushOrPresentPlist) {
        [DCURLRouter sharedDCURLRouter].pushOrPresentPlist = pushOrPresentPlist;
    }
}
+ (NSDictionary *)configDictionary
{
    return [DCURLRouter sharedDCURLRouter].configDict;
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [DCURLNavgation pushViewController:viewController animated:animated replace:NO];
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated replace:(BOOL)replace {
    [DCURLNavgation pushViewController:viewController animated:animated replace:replace];
}

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated {
    
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    [DCURLNavgation pushViewController:viewController animated:animated replace:NO];
}
+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated needManualHidesBottomBar:(BOOL)isNeed reverseBlock:(void (^)(id value))reverse {
    
    
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    viewController.cyp_reserveValue = ^(id value){
        if (reverse) {
            reverse(value);
        }
    };
    if (!viewController) {
        return;
    }
    if (isNeed == YES) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [DCURLNavgation pushViewController:viewController animated:animated replace:NO];
}
+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated navgation:(UINavigationController*)navgationSelf
{
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    [DCURLNavgation pushViewController:viewController animated:animated replace:NO navgation:navgationSelf];
}

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated navgation:(UINavigationController*)navgationSelf needManualHidesBottomBar:(BOOL)isNeed reverseBlock:(void (^)(id value))reverse
{
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    viewController.cyp_reserveValue = ^(id value){
        if (reverse) {
            reverse(value);
        }
    };
    if (!viewController) {
        return;
    }
    if (isNeed == YES) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [DCURLNavgation pushViewController:viewController animated:animated replace:NO navgation:navgationSelf];
}

+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    [DCURLNavgation pushViewController:viewController animated:animated replace:NO];
}

+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated navgation:(UINavigationController*)navgationSelf
{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    [DCURLNavgation pushViewController:viewController animated:animated replace:NO navgation:navgationSelf];
}

+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated navgation:(UINavigationController*)navgationSelf needManualHidesBottomBar:(BOOL)isNeed reverseBlock:(void (^)(id value))reverse
{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    viewController.cyp_reserveValue = ^(id value){
        if (reverse) {
            reverse(value);
        }
    };
    if (!viewController) {
        return;
    }
    if (isNeed == YES) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [DCURLNavgation pushViewController:viewController animated:animated replace:NO navgation:navgationSelf];
}

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated replace:(BOOL)replace{
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    [DCURLNavgation pushViewController:viewController animated:YES replace:replace];
}
+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated replaceVCNums:(NSInteger)vcNums
{
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    [DCURLNavgation pushViewController:viewController animated:YES replace:YES replaceVCNums:vcNums];
}

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated replaceVCNums:(NSInteger)vcNums reverseBlock:(void (^)(id value))reverse
{
    [self pushURLString:urlString query:@{} animated:animated replaceVCNums:vcNums reverseBlock:reverse];
}
+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated replaceVCNums:(NSInteger)vcNums reverseBlock:(void (^)(id value))reverse
{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    viewController.cyp_reserveValue = ^(id value){
        if (reverse) {
            reverse(value);
        }
    };
    if (!viewController) {
        return;
    }
    //    if (isNeed == YES) {
    viewController.hidesBottomBarWhenPushed = YES;
    //    }
    [DCURLNavgation pushViewController:viewController animated:animated replace:YES replaceVCNums:vcNums];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    [DCURLNavgation presentViewController:viewControllerToPresent animated:flag completion:completion];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag withNavigationClass:(Class)classType completion:(void (^ __nullable)(void))completion {
    
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[classType alloc]initWithRootViewController:viewControllerToPresent];
        [DCURLNavgation presentViewController:nav animated:flag completion:completion];
    }
}


+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    [DCURLNavgation presentViewController:viewController animated:animated completion:completion];
}


+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    [DCURLNavgation presentViewController:viewController animated:animated completion:completion];
}


+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated replace:(BOOL)replace{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    [DCURLNavgation pushViewController:viewController animated:animated replace:replace];
}


+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated withNavigationClass:(Class)classType completion:(void (^ __nullable)(void))completion{
    
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[classType alloc]initWithRootViewController:viewController];
        [DCURLNavgation presentViewController:nav animated:animated completion:completion];
    }
}

+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated withNavigationClass:(Class)clazz completion:(void (^ __nullable)(void))completion{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    if ([clazz isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[clazz alloc]initWithRootViewController:viewController];
        [DCURLNavgation presentViewController:nav animated:animated completion:completion];
    }
}

+ (void)popViewControllerAnimated:(BOOL)animated {
    [DCURLNavgation popViewControllerWithTimes:1 animated:animated];
}

+ (void)popTwiceViewControllerAnimated:(BOOL)animated {
    [DCURLNavgation popTwiceViewControllerAnimated:animated];
}
+ (void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated {
    [DCURLNavgation popViewControllerWithTimes:times animated:animated];
}
+ (void)popToRootViewControllerAnimated:(BOOL)animated {
    [DCURLNavgation popToRootViewControllerAnimated:animated];
}


+ (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion {
    [DCURLNavgation dismissViewControllerWithTimes:1 animated:flag completion:completion];
}
+ (void)dismissTwiceViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion {
    [DCURLNavgation dismissTwiceViewControllerAnimated:flag completion:completion];
}

+ (void)dismissViewControllerWithTimes:(NSUInteger)times animated: (BOOL)flag completion: (void (^ __nullable)(void))completion {
    [DCURLNavgation dismissViewControllerWithTimes:times animated:flag completion:completion];
}

+ (void)dismissToRootViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion {
    [DCURLNavgation dismissToRootViewControllerAnimated:flag completion:completion];
}

- (UIViewController*)currentViewController {
    return [DCURLNavgation sharedDCURLNavgation].currentViewController;
}

- (UINavigationController*)currentNavigationViewController {
    return [DCURLNavgation sharedDCURLNavgation].currentNavigationViewController;
}


// 将url的参数部分转化成字典
+ (NSMutableDictionary *)paramsURL:(NSString *)urlString withSelfModelName:(NSString*)model {
    NSString* stringUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:stringUrl];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    if (NSNotFound != [url.absoluteString rangeOfString:@"?"].location) {
        NSString *paramString = [url.absoluteString substringFromIndex:
                                 ([url.absoluteString rangeOfString:@"?"].location + 1)];
        NSString *domainString = [url.absoluteString substringToIndex:
                                  ([url.absoluteString rangeOfString:@"?"].location)];
        [pairs setValue:domainString forKey:@"domainName"];
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
            }else if (kvPair.count > 2)
            {//处理url里面在带有参数的问题@"url=http://2ctest.cheyipai.com/activity/openPacket.html?promotion=1"
                NSRange range = [pairString rangeOfString:@"="];
                NSString* keys = [pairString substringToIndex:range.location];
                NSString* values = [pairString substringFromIndex:range.location+1];
                [pairs setValue:values forKey:keys];
                
            }
        }
    }
    if (model) {
        Class myObj = NSClassFromString(model);
        //        [pairs setValue:[myObj objectWithKeyValues:pairs] forKey:model];
    }
    return  pairs;
}

+(BOOL)checkISHaveRegister:(NSURL*)url
{
    NSString* home;
    if(url.path == nil){ // 处理url,去掉有可能会拼接的参数
        home = [NSString stringWithFormat:@"%@://%@", url.scheme, url.host];
    }else{
        home = [NSString stringWithFormat:@"%@://%@%@", url.scheme, url.host,url.path];
    }
    NSDictionary* config = [[DCURLRouter sharedDCURLRouter].configDict objectForKey:url.scheme]; // 根据协议头取出值
    if([config.allKeys containsObject:home]){
        return YES;
        
    }else
    {
        return NO;
    }
    
}


+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated withNavigationClass:(Class)classType completion:(void (^ __nullable)(void))completion needManualHidesBottomBar:(BOOL)isNeed reverseBlock:(void (^)(id value))reverse{
    
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:nil fromConfig:[DCURLRouter sharedDCURLRouter].configDict reverseBlock:reverse];
    viewController.cyp_reserveValue = ^(id value){
        if (reverse) {
            reverse(value);
        }
    };
    if (!viewController) {
        return;
    }
    if (isNeed == YES) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[classType alloc]initWithRootViewController:viewController];
        [DCURLNavgation presentViewController:nav animated:animated completion:completion];
    }
}
+ (BOOL)isPushWithUrlString:(NSString *)urlString
{
    NSString *encodeStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodeStr];
    NSString *home;
    if(url.path == nil){ // 处理url,去掉有可能会拼接的参数
        home = [NSString stringWithFormat:@"%@://%@", url.scheme, url.host];
    }else{
        home = [NSString stringWithFormat:@"%@://%@%@", url.scheme, url.host,url.path];
    }
    NSDictionary *jumpplist = [DCURLRouter sharedDCURLRouter].pushOrPresentPlist;
    if([jumpplist isKindOfClass:[NSDictionary class]]){ // 自定义的url情况
        if([jumpplist.allKeys containsObject:home]){
            NSString *jumpValue = [jumpplist objectForKey:home];
            if ([jumpValue containsString:@"present"]) {
                return NO;
            }else{
                return YES;
            }
        }
    }
    return YES;
}
//+ (BOOL)isMatchCypRouterWithUrlString:(NSString *)urlString withQuery:(NSDictionary *)query
//{
//    NSDictionary *configDict =  [DCURLRouter configDictionary];
//    UIViewController *vc =  [UIViewController initFromString:urlString withQuery:query fromConfig:configDict];
//    if (vc == nil) {
//        return NO;
//    }else{
//        return YES;
//    }
//}
+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query reverseBlock:(void (^)(id value))reverse
{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[DCURLRouter sharedDCURLRouter].configDict reverseBlock:reverse];
    viewController.cyp_reserveValue = ^(id value){
        if (reverse) {
            reverse(value);
        }
    };
    if (!viewController) {
        return;
    }
    viewController.hidesBottomBarWhenPushed = YES;
    NSString *classTypeString = @"MyNavigationController";
    Class classType=  NSClassFromString(classTypeString);
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[classType alloc]initWithRootViewController:viewController];
        [DCURLNavgation presentViewController:nav animated:YES completion:nil];
    }
}
+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query  reverseBlock:(void (^)(id value))reverse
{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[DCURLRouter sharedDCURLRouter].configDict];
    viewController.cyp_reserveValue = ^(id value){
        if (reverse) {
            reverse(value);
        }
    };
    if (!viewController) {
        return;
    }
    viewController.hidesBottomBarWhenPushed = YES;
    
    [DCURLNavgation pushViewController:viewController animated:YES replace:NO navgation:[DCURLRouter sharedDCURLRouter].cyp_currentNavigationVC];
}

@end
