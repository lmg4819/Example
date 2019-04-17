//
//  CYPMapComponents.h
//  CarEasyBuy
//
//  Created by 马敬龙 on 16/9/8.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYP_MapNavigation.h"
#import "MapConfig.h"

@interface CYPMapComponents : NSObject<UIActionSheetDelegate>
//起点
@property (nonatomic, assign) CLLocationCoordinate2D originCoord;
@property (nonatomic, strong) NSString *origin;
//目的地
@property (nonatomic, assign) CLLocationCoordinate2D dCoord;
@property (nonatomic, strong) NSString *destination;

/**
 *  map导航单例
 *
 *  @return map单例
 */
+ (instancetype)mapCommonpents;


/**
 *  基于用户当前位置导航
 *
 *  @param dCoord      目的地坐标
 *  @param destination 目的地
 *
 *  @return map单例
 */
+ (instancetype)showMapBasedOnCurrentLocation:(CLLocationCoordinate2D)dCoord
                                        dName:(NSString *)destination;

/**
 *  基于给定起点坐标导航
 *
 *  @param origin      起点
 *  @param originCoord 起点坐标
 *  @param dCoord      目的地坐标
 *  @param destination 目的地
 *
 *  @return map单例
 */
+ (instancetype)showMapWithOrigin:(NSString *)origin
                      originCoord:(CLLocationCoordinate2D)originCoord
                           dCoord:(CLLocationCoordinate2D)dCoord
                            dName:(NSString *)destination;


/**
 *  展示mapList
 */
- (void)showMapNavigationList;

@end
