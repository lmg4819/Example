//
//  CYPRequestConfigProtocol.h
//  LHTeach
//
//  Created by 马敬龙 on 2017/8/31.
//  Copyright © 2017年 majinglong. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^AnalysisBlock)(NSInteger resultCode, NSString *codeDes, id jsonData);

@protocol CYPRequestConfigProtocol <NSObject>

/**
 *  联网是否失败
 **/
- (BOOL) connectNetFail;

/**
 *  公共参数设置
 *  @businessParams     业务参数
 *  return      请求所需全部参数
 */
- (NSDictionary *)paramsConfig:(NSDictionary *)businessParams;

/**
 *  header数据设置
 ***/
- (NSDictionary *)headerFieldValueConfig;

/**
 *  请求失败统一返回提示
 */
- (NSString *)netFailPrompt;

/**
 *  解析数据
 *  @cls            实体数据类型
 *  @json           转Model诗句
 *  @analysisBlock  解析出请求状态值、状态描述、实体数据
 *  return          实体数据
 **/
- (id)jsonToModel:(Class)cls json:(id)json analysisSuccBlock:(AnalysisBlock)analysisBlock;

/**
 *  特殊状态处理
 *  @model  请求返回数据 
 *  return  YES:特殊状态  NO:非特殊状态
 */
- (BOOL)specialStatusHandle:(id)model;

//列表使用
- (NSDictionary *)headerForCarListValueDictionary;
@end
