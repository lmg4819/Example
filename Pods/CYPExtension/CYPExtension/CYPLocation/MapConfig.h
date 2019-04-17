//
//  MapConfig.h
//  CarEasyBuy
//
//  Created by 马敬龙 on 16/9/8.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#ifndef MapConfig_h
#define MapConfig_h

#define kMapNameApple   @"苹果地图"
#define kMapNameGD      @"高德地图"
#define kMapNameBD      @"百度地图"
#define kMapNameTC      @"腾讯地图"

#define kMapHostGD      @"iosamap://"
#define kMapHostBD      @"baidumap://"



#define kApplicationCanOpenURL(host)     [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:host]]
#define kApplicationOpenURL(url)        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
#define kCLLDisable           ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)


#define kReadLocationMsg        @"需要知道您的位置,请到设置->隐私->定位服务中开启!"

/*
    CoreLocation  MapKit
 */

#endif /* MapConfig_h */
