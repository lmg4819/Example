//
//  CYPMapComponents.m
//  CarEasyBuy
//
//  Created by 马敬龙 on 16/9/8.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import "CYPMapComponents.h"

@implementation CYPMapComponents {
    
    BOOL isUserCurrentLocation;//是否使用当前位置
}

+ (instancetype)mapCommonpents {
    
    static CYPMapComponents * mapCommonpents = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapCommonpents = [[CYPMapComponents alloc] init];
    });
    return mapCommonpents;
}

+ (instancetype)showMapBasedOnCurrentLocation:(CLLocationCoordinate2D)dCoord
                                        dName:(NSString *)destination {
    
    CYPMapComponents * mapComponents = [CYPMapComponents mapCommonpents];
    
    mapComponents->isUserCurrentLocation = YES;
    
    mapComponents.dCoord = dCoord;
    mapComponents.destination = destination;
    [mapComponents showMapNavigationList];
    return mapComponents;
}

+ (instancetype)showMapWithOrigin:(NSString *)origin
                      originCoord:(CLLocationCoordinate2D)originCoord
                           dCoord:(CLLocationCoordinate2D)dCoord
                            dName:(NSString *)destination {

    CYPMapComponents * mapComponents = [CYPMapComponents mapCommonpents];
    
    mapComponents->isUserCurrentLocation = NO;
    
    mapComponents.origin = origin;
    mapComponents.originCoord = originCoord;
    mapComponents.dCoord = dCoord;
    mapComponents.destination = destination;
    [mapComponents showMapNavigationList];
    return mapComponents;
}

- (void)showMapNavigationList {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"导航" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:AppleMap(), TCMap(), nil];
    if (BDMap()) {
        [actionSheet addButtonWithTitle:BDMap()];
    }
    if (GDMap()) {
        [actionSheet addButtonWithTitle:GDMap()];
    }
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString * title = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    MapNavigationType mapType = mapNull;
    if ([title isEqualToString:kMapNameApple]) {
        mapType = mapFromAppleGaoDe;
    } else if ([title isEqualToString:kMapNameGD]) {
        mapType = mapFromGaoDe;
    } else if ([title isEqualToString:kMapNameBD]) {
        mapType = mapFromBaidu;
    } else if ([title isEqualToString:kMapNameTC]) {
        mapType = mapFromTencent;
    } else {
    
    }
    if (mapType != mapNull) {
        if (isUserCurrentLocation) {
            [CYP_MapNavigation baseCLNavigation:mapType dCoord:_dCoord destination:_destination];
        } else {
            [CYP_MapNavigation switchForMap:mapType originCoord:_originCoord origin:_origin dCoord:_dCoord destination:_destination];
        }

    }
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}


NSString * AppleMap() {
    return kMapNameApple;
}

NSString * TCMap() {
    return kMapNameTC;
}

NSString * GDMap() {
    
    return kApplicationCanOpenURL(kMapHostGD) ? kMapNameGD : nil;
}

NSString * BDMap() {
    
    NSString * name = (kApplicationCanOpenURL(kMapHostBD)&&(!kCLLDisable)) ? kMapNameBD : nil;
    return name;
}

@end
