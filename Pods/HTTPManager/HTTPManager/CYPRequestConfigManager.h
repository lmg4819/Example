//
//  CYPRequestConfigManager.h
//  LHTeach
//
//  Created by 马敬龙 on 2017/8/30.
//  Copyright © 2017年 majinglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYPRequestConfigProtocol.h"
#import "CYPRequestConfigManager.h"

@interface CYPRequestConfigManager : NSObject

//网络请求前缀
@property (strong, nonatomic) NSString *prefixNetWorkUrl;//数据请求地址
@property (strong, nonatomic) NSString * uploadImageUrl;//上传图片地址
@property (nonatomic, weak) id<CYPRequestConfigProtocol> configDelegate;//协议配置代理

+ (CYPRequestConfigManager *)sharedInstance;

+ (NSString *)hostUrl;

@end
