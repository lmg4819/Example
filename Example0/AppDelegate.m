//
//  AppDelegate.m
//  Example0
//
//  Created by lmg on 2018/9/10.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "AppDelegate.h"
#import <YTKNetwork/YTKNetworkConfig.h>
#import "YTKUrlArgumentsFilter.h"
#import <YTKNetwork/YTKBatchRequest.h>
#import <YTKNetwork/YTKChainRequest.h>
#import "RegisterAPI.h"
#import "GetImageAPI.h"
#import "GetUserInfoAPI.h"
#import "NSString+EOCURL.h"
#import "NSString+HTTP.h"
#import "EOCDog.h"

#if defined(DEBUG)||defined(_DEBUG)
#import <JPFPSStatus.h>
#endif

@interface AppDelegate ()<YTKChainRequestDelegate>

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    NSLog(@"continueUserActivity");
    if ([userActivity.activityType isEqualToString:@"loying.LearnSiriShortcut.type"]) {
        // 做自己的业务逻辑
    }
    
    return YES;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"loying.LearnSiriShortcut.type"];
    if (@available(iOS 12.0, *)) // 如果要支持老版本，加上判断
    {
        userActivity.eligibleForPrediction = YES;
    }
    userActivity.title = @"测试标题";
    userActivity.userInfo = @{@"testKey" : @"testValue"};
    self.userActivity = userActivity;
    
//    NSMutableArray *array = @[@12,@8,@9,@6,@10].mutableCopy;
//    //maopaofa
//    for (int i=0; i<(int)array.count; i++) {
//        for (int j=0;j<array.count-i-1; j++) {
//            if ([array[j] intValue] > [array[j+1] intValue]) {
//                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//            }
//        }
//    }
//    NSLog(@"---%@--",array);
    
    /*
     12 8 9 6 10
     8 12 9 6 10
     6 12 9 8 10
     
     */
//        NSMutableArray *array = @[@12,@8,@9,@6,@10].mutableCopy;
//        //选择
//        for (int i=0; i<(int)array.count-1; i++) {
//            for (int j=i+1;j<array.count; j++) {
//                if ([array[i] intValue] > [array[j] intValue]) {
//                    [array exchangeObjectAtIndex:i withObjectAtIndex:j];
//                }
//            }
//        }
//        NSLog(@"---%@--",array);

    
    /*
     12 8 9 6 10
     8 12 9 6 10
     8 9 12 6 10
     6 8 9 12 10
     6 8 9 10 12
     */
//            NSMutableArray *array = @[@12,@8,@9,@6,@10].mutableCopy;
//            //插入
//            for (int i=1; i<(int)array.count; i++) {
//                NSNumber *temp = array[i];
//                for (int j=i-1;j>=0; j--) {
//                    if ([array[j] intValue] > [temp intValue]) {
//                        array[j+1] = array[j];
//                        array[j] = temp;
//                    }
//                }
//            }
//            NSLog(@"---%@--",array);
    

    
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif
    
    return YES;
}

- (void)sendChainRequest
{
    RegisterAPI *api = [[RegisterAPI alloc]initWithUsername:@"username" password:@"password"];
    YTKChainRequest *chainRequest = [[YTKChainRequest alloc]init];
    [chainRequest addRequest:api callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        RegisterAPI *result = (RegisterAPI *)baseRequest;
        NSString *userId = result.responseString;
        GetUserInfoAPI *infoAPI = [[GetUserInfoAPI alloc]initWithUserId:userId];
        [chainRequest addRequest:infoAPI callback:nil];
    }];
    chainRequest.delegate = self;
    [chainRequest start];
    
}

#pragma mark -YTKChainRequestDelegate
-(void)chainRequestFinished:(YTKChainRequest *)chainRequest
{
    // all requests are done
}

-(void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest *)request
{
    // some one of request is failed
}

- (void)sendBatchRequest
{
    GetImageAPI *a = [[GetImageAPI alloc]initWithImageId:@"1.jpg"];
    GetImageAPI *b = [[GetImageAPI alloc]initWithImageId:@"2.jpg"];
    GetImageAPI *c = [[GetImageAPI alloc]initWithImageId:@"3.jpg"];
    GetUserInfoAPI *d = [[GetUserInfoAPI alloc]initWithUserId:@"123"];
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc]initWithRequestArray:@[a,b,c,d]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSLog(@"success");
        NSArray *requests = batchRequest.requestArray;
        GetImageAPI *a = (GetImageAPI *)requests[0];
        GetImageAPI *b = (GetImageAPI *)requests[1];
        GetImageAPI *c = (GetImageAPI *)requests[2];
        GetUserInfoAPI *d = (GetUserInfoAPI *)requests[3];
        
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSLog(@"failure");
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

static inline BOOL isIPhoneXSeries(){
    BOOL iPhoneXSeries = NO;
    if ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    } else {
    }
    return iPhoneXSeries;
}
/*
 给定一个字符串，找出不含有重复字符的最长子串的长度。
 
 示例 1:
 
 输入: "abcabcbb"
 输出: 3
 解释: 无重复字符的最长子串是 "abc"，其长度为 3。
 示例 2:
 
 输入: "bbbbb"
 输出: 1
 解释: 无重复字符的最长子串是 "b"，其长度为 1。
 示例 3:
 
 输入: "pwwkew"
 输出: 3
 解释: 无重复字符的最长子串是 "wke"，其长度为 3。
 请注意，答案必须是一个子串，"pwke" 是一个子序列 而不是
 */

- (void)test{
    NSString *str = @"abcabcbb";
    unichar character = [str characterAtIndex:0];
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationByLines usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
    }];
}

@end
