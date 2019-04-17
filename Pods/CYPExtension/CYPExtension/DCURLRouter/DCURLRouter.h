//
//  DCURLRouter.h
//  DCURLRouterDemo
//
//  Created by Dariel on 16/8/17.
//  Copyright © 2016年 DarielChen. All rights reserved.
//  核心类 通过调用类方法实现自定义URL跳转




/*
 
  // 1.  传入的字符串地址
    NSString* urlstring = [NSString stringWithFormat:@"dariel://twoitem?Url=444&Content=333"];
  
  // 2.  将域名后拼接的参数，转化成你想要的model（例：CYPHomeBannerModel）
    返回值：
        dicc={
                CYPHomeBannerModel = "<CYPHomeBannerModel: 0x17011500>";
                Content = 333;
                Url = 444;
                domainName = "dariel://twoitem?";
            }
 
    NSDictionary* dicc = [DCURLRouter paramsURL:urlstring  withSelfModelName:@"CYPHomeBannerModel"];
 
  // 3. navgation: 自己设定要push控制器的导航控制器
    [DCURLRouter pushURLString:[dicc objectForKey:@"domainName"] query:dicc animated:NO navgation:kWindowRootController];
 
 */



#import <Foundation/Foundation.h>
#import "DCSingleton.h"
#import "UIViewController+DCURLRouter.h"
#import "CYPModuleURLInitInterceptor.h"
NS_ASSUME_NONNULL_BEGIN

@interface DCURLRouter : NSObject
DCSingletonH(DCURLRouter)

@property(nonatomic, strong)id<CYPModuleURLInitInterceptor>interceptor;

/**
 *  加载plist文件中的URL配置信息
 *
 *  @param pistName plist文件名称,不用加后缀
 */
+ (void)loadConfigDictFromPlist:(NSString *)pistName;
+ (void)loadConfigDictFromPath:(NSString *)path;
+ (void)loadPushOrPresentPlistFromPath:(NSString *)path;
+ (void)loadPushOrPresentPlist:(NSString *)pushOrPresentName;

+ (NSDictionary *)configDictionary;

#pragma mark --------  拿到导航控制器 和当前控制器 --------

/** 返回当前控制器 */
- (UIViewController*)currentViewController;

/** 返回当前控制器的导航控制器 */
- (UINavigationController*)currentNavigationViewController;

#pragma mark --------  push控制器 --------
/**
 *  push控制器 同系统的
 *
 *  @param viewController 目标控制器
 */
+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/**
 *  push控制器 类似系统的
 *
 *  @param viewController 目标控制器
 *  @param replace        如果当前控制器和要push的控制器是同一个,可以将replace设置为Yes,进行替换.同一个才能替换哦!
 */
+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated replace:(BOOL)replace;

/**
 *  push控制器
 *
 *  @param urlString 自定义的URL,可以拼接参数
 */
+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated;
/**
 *  push控制器 needManualHidesBottomBar
 *
 *  @param urlString 自定义的URL,可以拼接参数
 */
+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated needManualHidesBottomBar:(BOOL)isNeed reverseBlock:(void (^)(id value))reverse;
/**
 *  push控制器
 *
 *  @param urlString 自定义URL,也可以拼接参数,但会被下面的query替换掉
 *  @param query     存放参数
 */
+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated;
/**
 *  push控制器
 *
 *  @param urlString 自定义的URL,可以拼接参数
 *  @param replace   如果当前控制器和要push的控制器是同一个,可以将replace设置为Yes,进行替换.同一个才能替换哦!
 */
+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated replace:(BOOL)replace;

/**
 *  push控制器
 *
 *  @param urlString 自定义URL,也可以拼接参数,但会被下面的query替换掉
 *  @param query     存放参数
 *  @param replace   如果当前控制器和要push的控制器是同一个,可以将replace设置为Yes,进行替换.同一个才能替换哦!
 */
+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated replace:(BOOL)replace;

//可以指定删除栈内的控制器个数
+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated replaceVCNums:(NSInteger)vcNums;
+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated replaceVCNums:(NSInteger)vcNums reverseBlock:(void (^)(id value))reverse;
+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated replaceVCNums:(NSInteger)vcNums reverseBlock:(void (^)(id value))reverse;

#pragma mark -------给这个第三方新添加方法用于方便项目使用
/**
 *  push控制器
 *
 *  @param navgationSelf 使用自己传入的UINavigationController 作为跳转

 */
+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated navgation:(UINavigationController*)navgationSelf;

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated navgation:(UINavigationController*)navgationSelf;

/**
 push控制器
 @param navgationSelf navgationSelf 使用自己传入的UINavigationController 作为跳转
 @param reverse 目标控制器回传值的block
 @param isNeed  默认传NO  传YES调viewController.hidesBottomBarWhenPushed = YES;
 */
+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated navgation:(UINavigationController*)navgationSelf needManualHidesBottomBar:(BOOL)isNeed reverseBlock:(void (^)(id value))reverse;
+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated navgation:(UINavigationController*)navgationSelf needManualHidesBottomBar:(BOOL)isNeed reverseBlock:(void (^)(id value))reverse;

#pragma mark --------  pop控制器 --------

/** pop掉一层控制器 */
+ (void)popViewControllerAnimated:(BOOL)animated;
/** pop掉两层控制器 */
+ (void)popTwiceViewControllerAnimated:(BOOL)animated;
/** pop掉times层控制器 */
+ (void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated;
/** pop到根层控制器 */
+ (void)popToRootViewControllerAnimated:(BOOL)animated;

#pragma mark --------  modal控制器 --------

/**
 *  modal控制器
 *
 *  @param viewControllerToPresent 目标控制器
 */
+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;

/**
 *  modal控制器
 *
 *  @param viewControllerToPresent 目标控制器
 *  @param classType               需要添加的导航控制器 eg.[UINavigationController class]
 */
+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag withNavigationClass:(Class)classType completion:(void (^ __nullable)(void))completion;

/**
 *  modal控制器
 *
 *  @param urlString 自定义的URL,可以拼接参数
 */
+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

/**
 *  modal控制器
 *
 *  @param urlString 自定义URL,也可以拼接参数,但会被下面的query替换掉
 *  @param query     存放参数
 */
+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

/**
 *  modal控制器,并且给modal出来的控制器添加一个导航控制器
 *
 *  @param urlString 自定义的URL,可以拼接参数
 *  @param classType     需要添加的导航控制器 eg.[UINavigationController class]
 */
+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated withNavigationClass:(Class)classType completion:(void (^ __nullable)(void))completion;

/**
 *  modal控制器,并且给modal出来的控制器添加一个导航控制器
 *
 *  @param urlString 自定义URL,也可以拼接参数,但会被下面的query替换掉
 *  @param query     存放参数
 *  @param clazz     需要添加的导航控制器 eg.[UINavigationController class]
 */
+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated withNavigationClass:(Class)clazz completion:(void (^ __nullable)(void))completion;

+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated withNavigationClass:(Class)classType completion:(void (^ __nullable)(void))completion needManualHidesBottomBar:(BOOL)isNeed reverseBlock:(void (^)(id value))reverse;

#pragma mark --------  dismiss控制器 --------
/** dismiss掉1层控制器 */
+ (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion;
/** dismiss掉2层控制器 */
+ (void)dismissTwiceViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion;
/** dismiss掉times层控制器 */
+ (void)dismissViewControllerWithTimes:(NSUInteger)times animated: (BOOL)flag completion: (void (^ __nullable)(void))completion;
/** dismiss到根层控制器 */
+ (void)dismissToRootViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion;
/**
 *  modal控制器,并且给modal出来的控制器添加一个导航控制器
 *
 *  @param urlString 接口传入的带有参数的url
 *  @param model  想要将参数转换的model类名
 
 返回值：{
  1. domainName 域名
  2. 参数
  3. model（将参数转化成你自己传入的model类型）
 }
 
 */
+ (NSMutableDictionary *)paramsURL:(NSString *)urlString withSelfModelName:(NSString*)model;
+(BOOL)checkISHaveRegister:(NSURL*)url;

+ (BOOL)isPushWithUrlString:(NSString *)urlString;
//+ (BOOL)isMatchCypRouterWithUrlString:(NSString *)urlString withQuery:(NSDictionary *)query;

+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query reverseBlock:(void (^)(id value))reverse;
+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query  reverseBlock:(void (^)(id value))reverse;
NS_ASSUME_NONNULL_END
@end
