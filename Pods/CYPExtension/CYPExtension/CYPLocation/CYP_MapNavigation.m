//
//  CYP_MapNavigation.m
//  CarEasyBuy
//
//  Created by 马敬龙 on 16/9/6.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import "CYP_MapNavigation.h"

@implementation CYP_MapNavigation

static BOOL isNeedStartLocation = NO;

+ (void)baseCLNavigation:(MapNavigationType)mapType
                  dCoord:(CLLocationCoordinate2D)dCoord
             destination:(NSString *)destination {
//     CLAuthorizationStatus s = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied;
    if (!(kCLLDisable)) {
        isNeedStartLocation = YES;
        
        __block typeof(self) blockSelf = self;
        CYPReadLocation * rLoc = [CYPReadLocation locationSingleton];
        
        [rLoc readUserCurrentLocation:YES resultBlock:^(BOOL isSucc, CLPlacemark *placemark, NSError *error) {
            
            //当前位置 coordinate
            if (isSucc) {
                [blockSelf switchForMap:mapType
                            originCoord:placemark.location.coordinate
                                 origin:placemark.thoroughfare
                                 dCoord:dCoord
                            destination:destination];
            } else {
                [[[UIAlertView alloc] initWithTitle:@"" message:@"定位失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            }
            rLoc.resultBlock = nil;

        }];
     
    } else {
        isNeedStartLocation = NO;
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0, 0);
        [self switchForMap:mapType
                originCoord:coordinate
                     origin:@""
                     dCoord:dCoord
                destination:destination];
    }
}

+ (void)mapNavigation:(MapNavigationType)mapType
          originCoord:(CLLocationCoordinate2D)originCoord
               origin:(NSString *)orgin
               dCoord:(CLLocationCoordinate2D)dCoord
          destination:(NSString *)destination
{
    isNeedStartLocation = YES;
    [self switchForMap:mapType
           originCoord:originCoord
                origin:orgin
                dCoord:dCoord
           destination:destination];
}

+ (BOOL)isNeedOriginCoord {
    return isNeedStartLocation;
}

+ (void)switchForMap:(MapNavigationType)mapType
         originCoord:(CLLocationCoordinate2D)originCoord
              origin:(NSString *)orgin
              dCoord:(CLLocationCoordinate2D)dCoord
         destination:(NSString *)destination
{

    switch (mapType) {
        case mapFromAppleGaoDe:
            [self mapForApple:originCoord origin:orgin dCoord:dCoord destination:destination];
            break;
        case mapFromGaoDe:
            [self mapForGaoDe:originCoord origin:orgin dCoord:dCoord destination:destination];
            break;
        case mapFromBaidu:
            [self mapForBD:originCoord origin:orgin dCoord:dCoord destination:destination];
            break;
        case mapFromTencent:
            [self mapForTC:originCoord origin:orgin dCoord:dCoord destination:destination];
            break;
            
        default:
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"未提供此类型的导航" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
            break;
    }
}

//URI API  http://lbs.amap.com/api/uri-api/ios-uri-explain/
+ (void)mapForGaoDe:(CLLocationCoordinate2D)originCoord
             origin:(NSString *)origin
             dCoord:(CLLocationCoordinate2D)dCoord
        destination:(NSString *)destination
{
    
    NSString * applicationName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    applicationName = [applicationName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    //start
    CLLocationDegrees startLat = originCoord.latitude;
    CLLocationDegrees startLon = originCoord.longitude;
    NSString * startName = [origin stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //end
    CLLocationDegrees dlat = dCoord.latitude;
    CLLocationDegrees dlon = dCoord.longitude;
    NSString * dName = [destination stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSInteger dev = 0;
    NSInteger m = 0;
    NSInteger t = 0;
    
    //路线规划
    NSString * host = kMapHostGD;//需在LSApplicationQueriesSchemes添加
    NSString * url = [[NSString alloc] initWithFormat:@"%@path?sourceApplication=%@&sid=BGVIS1&slat=%lf&slon=%lf&sname=%@&did=BGVIS2&dlat=%lf&dlon=%lf&dname=%@&dev=%ld&m=%ld&t=%ld",host,applicationName,startLat,startLon,startName,dlat,dlon,dName,(long)dev,(long)m,(long)t];
    if ([self isNeedOriginCoord] == NO) {
        
        url = [[NSString alloc] initWithFormat:@"%@path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%lf&dlon=%lf&dname=%@&dev=%ld&m=%ld&t=%ld",host,applicationName,dlat,dlon,dName,(long)dev,(long)m,(long)t];
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:host]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
    }else{
        [[[UIAlertView alloc]initWithTitle:@"没有安装高德地图" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        
    }
}


+ (void)mapForApple:(CLLocationCoordinate2D)originCoord
             origin:(NSString *)origin
             dCoord:(CLLocationCoordinate2D)dCoord
        destination:(NSString *)destination
{
    
    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc]                         initWithCoordinate:originCoord  addressDictionary:nil]];
    if ([self isNeedOriginCoord] == NO) {
        currentLocation = [MKMapItem mapItemForCurrentLocation];
    }
    currentLocation.name =origin;
    
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:dCoord addressDictionary:nil]];
    toLocation.name = destination;
    
    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation,nil];
    NSString * mode = MKLaunchOptionsDirectionsModeDriving;
   
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:mode,
                               MKLaunchOptionsMapTypeKey: @(MKMapTypeStandard),
                               MKLaunchOptionsShowsTrafficKey:@YES
                               };
    
    //打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];

}
//URI API  http://lbsyun.baidu.com/index.php?title=uri/api/ios
+ (void)mapForBD:(CLLocationCoordinate2D)originCoord
          origin:(NSString *)origin
          dCoord:(CLLocationCoordinate2D)dCoord
     destination:(NSString *)destination
{
    //"baidumap://map/direction?origin=34.264642646862,108.95108518068&destination=40.007623,116.360582&mode=driving&src=webapp.navi.yourCompanyName.yourAppName
    
    NSString * originC = [[NSString alloc] initWithFormat:@"%lf,%lf",originCoord.latitude,originCoord.longitude];
    NSString * destinationC = [[NSString alloc] initWithFormat:@"%lf,%lf",dCoord.latitude,dCoord.longitude];
    NSString * model = @"driving";
    
    NSString * applicationName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString * src = [[NSString alloc] initWithFormat:@"webapp.navi.%@.%@",@"车易拍（北京）汽车技术服务有限公司",applicationName];
    src = [applicationName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    /**
     *  允许的值为bd09ll、bd09mc、gcj02、wgs84。
        bd09ll表示百度经纬度坐标，
        bd09mc表示百度墨卡托坐标，
        gcj02表示经过国测局加密的坐标，
        wgs84表示gps获取的坐标。
     */
    NSString * coord_type = @"gcj02";
    //路线规划
    NSString * host = kMapHostBD;//需在LSApplicationQueriesSchemes添加
    NSString * url = [[NSString alloc] initWithFormat:@"%@map/direction?origin=%@&destination=%@&mode=%@&src=%@&coord_type=%@",host,originC,destinationC,model,src,coord_type];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:host]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
    }else{
        [[[UIAlertView alloc]initWithTitle:@"没有安装百度地图" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        
    }

}

+ (void)mapForTC:(CLLocationCoordinate2D)originCoord
          origin:(NSString *)origin
          dCoord:(CLLocationCoordinate2D)dCoord
     destination:(NSString *)destination
{

    //http ://apis.map.qq.com/uri/v1/routeplan?type=bus&from=我的家&fromcoord=39.980683,116.302&to=中关村&tocoord=39.9836,116.3164&policy=1&referer=myapp
    //start
    NSString * from = [origin stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * fromCoord = [[NSString alloc] initWithFormat:@"%lf,%lf",originCoord.latitude,originCoord.longitude];
    //end
    NSString * to = [destination stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * toCoord = [[NSString alloc] initWithFormat:@"%lf,%lf",dCoord.latitude,dCoord.longitude];
    /**
     *  公交：bus  驾车：drive    步行：walk（仅适用移动端）
     */
    NSString * type = @"drive";
    /**
     *  公交：type=bus  0：较快捷  1：少换乘   2：少步行   3：不坐地铁
     *  驾车：type=drive   0：较快捷   1：无高速   2：距离
     */
    NSInteger policy = 0;
    NSString * referer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    referer = [referer stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * url = [[NSString alloc] initWithFormat:@"http://apis.map.qq.com/uri/v1/routeplan?type=%@&from=%@&fromcoord=%@&to=%@&tocoord=%@&policy=%ld&referer=%@",type,from,fromCoord,to,toCoord,(long)policy,referer];
    if ([self isNeedOriginCoord] == NO) {
        url = [[NSString alloc] initWithFormat:@"http://apis.map.qq.com/uri/v1/routeplan?type=%@&to=%@&tocoord=%@&policy=%ld&referer=%@",type,to,toCoord,(long)policy,referer];

    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


@end
