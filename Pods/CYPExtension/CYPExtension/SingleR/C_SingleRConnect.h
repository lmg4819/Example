//
//  C_SingleRConnect.h
//  CarEasyBuy
//
//  Created by 马敬龙 on 17/3/29.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SingleRDelegate <NSObject>

@optional
- (void)singleRStartConnect;
- (void)singleRConnectReceiveData:(id)data dataType:(NSString *)dataType;
- (void)singleRConnectClose;
//自动调用关闭singleR
- (void)singleRConnectError:(NSString *)error;
//地址存在问题
- (void)singleRUrlError:(NSString *)url;

@end

@interface C_SingleRConnect : NSObject

@property (nonatomic, copy) NSString * url;
@property (nonatomic) id<SingleRDelegate>delegate;

- (void)connectSocketWithUrl:(NSString *)url hubProxy:(NSString *)hubProxy;

- (void)closeConnect;

-(NSString*)getConnectionId;

@end
