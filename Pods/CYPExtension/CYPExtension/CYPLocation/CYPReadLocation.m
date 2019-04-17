//
//  ReadLocation.m
//  cheyipai
//
//  Created by 马敬龙 on 16/6/6.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPReadLocation.h"
#import "MapConfig.h"

@interface CYPReadLocation ()<UIAlertViewDelegate>

@end

@implementation CYPReadLocation

+ (id)locationSingleton {
    static CYPReadLocation * location  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[CYPReadLocation alloc] init];
    });
    return location;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 实例化一个位置管理器
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        self.locationManager.distanceFilter = 1000.0f; // 如果设为kCLDistanceFilterNone，则每秒更新一次;
        if ([[[UIDevice currentDevice]systemVersion] floatValue] > 8.0) {
            //开启时定位
            [self.locationManager requestWhenInUseAuthorization];
        }
        
    }
    return self;
}

- (void)readUserCurrentLocation:(LocationResultBlock)resultBlock
{
    [self readUserCurrentLocation:NO resultBlock:resultBlock];
}

- (void)readUserCurrentLocation:(BOOL)isNeedRemind resultBlock:(LocationResultBlock)resultBlock
{
    self.resultBlock = resultBlock;
    CLAuthorizationStatus type = [CLLocationManager authorizationStatus];
    if (![CLLocationManager locationServicesEnabled] || type == kCLAuthorizationStatusDenied) {
    
        if (isNeedRemind) {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            
            NSString * descripte = [[NSString alloc] initWithFormat:@"[%@]%@",app_Name,kReadLocationMsg];
            UIAlertView * positioningAlertivew = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:descripte delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消",nil];
            
            [positioningAlertivew show];
        }
    } else {
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark- UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0) {//大于ios8
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        } 
    }
}

#pragma mark - CLLocationManagerDelegate
// 地理位置发生改变时触发
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation * newLocation = [locations firstObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    __block typeof(self) blockSelf = self;
    [geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark * placemark in placemarks) {
            
            if (blockSelf.resultBlock) {
                blockSelf.resultBlock(YES, placemark, nil);
            }
        }
    }];
    // 停止位置更新
    [manager stopUpdatingLocation];

}
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
//
//    [geoCoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
//
//        for (CLPlacemark * placemark in placemarks) {
//
//            if (_resultBlock) {
//                _resultBlock(YES, placemark, nil);
//            }
//        }
//    }];
//    // 停止位置更新
//    [manager stopUpdatingLocation];
//}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (_resultBlock) {
        _resultBlock(NO, nil, error);
    }
}

@end
