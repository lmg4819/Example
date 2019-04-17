//
//  ReadLocation.h
//  cheyipai
//
//  Created by 马敬龙 on 16/6/6.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


typedef void(^LocationResultBlock)(BOOL isSucc, CLPlacemark * placemark, NSError * error);

@interface CYPReadLocation : NSObject<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locationManager;

@property (nonatomic, strong) LocationResultBlock resultBlock;

+ (id)locationSingleton;

//开启定位，未开启 不提 示跳转
- (void)readUserCurrentLocation:(LocationResultBlock)resultBlock;
//开启定位，未开启时是否需要提示：跳转设置
- (void)readUserCurrentLocation:(BOOL)isNeedRemind resultBlock:(LocationResultBlock)resultBlock;

@end
