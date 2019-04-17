//
//  CYP_MapNavigation.h
//  CarEasyBuy
//
//  Created by 马敬龙 on 16/9/6.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CYPReadLocation.h"
#import "MapConfig.h"

typedef NS_ENUM(NSInteger, MapNavigationType) {
    
    mapNull,
    mapFromAppleGaoDe,
    mapFromGaoDe,
    mapFromBaidu,
    mapFromTencent,
};

@interface CYP_MapNavigation : NSObject


/**
 *  基于当前位置为起始位置
 *
 *  @param mapType     地图类型
 *  @param dCoord      目的地坐标
 *  @param destination 目的地
 */
+ (void)baseCLNavigation:(MapNavigationType)mapType
                  dCoord:(CLLocationCoordinate2D)dCoord
             destination:(NSString *)destination;

/**
 *  导航
 *
 *  @param mapType     地图类型
 *  @param originCoord 起点坐标
 *  @param orgin       起点
 *  @param dCoord      目的地坐标
 *  @param destination 目的地
 */
+ (void)switchForMap:(MapNavigationType)mapType
         originCoord:(CLLocationCoordinate2D)originCoord
              origin:(NSString *)orgin
              dCoord:(CLLocationCoordinate2D)dCoord
         destination:(NSString *)destination;

@end
