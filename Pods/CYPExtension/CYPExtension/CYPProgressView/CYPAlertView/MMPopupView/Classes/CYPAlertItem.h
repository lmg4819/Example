//
//  CYPAlertItem.h
//  CarEasyBuy
//
//  Created by cheyipai.com on 2018/8/9.
//  Copyright © 2018年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPAlertItem : NSObject
//初始状态是否可点
@property (nonatomic, assign) BOOL     isDisabled;
//倒计时时间 如果传0则无倒计时
@property (nonatomic, assign) NSTimeInterval unUseTime;
//按钮标题
@property (nonatomic, strong) NSString *title;
@end
NS_INLINE CYPAlertItem* CYPAlertItemMake(NSString* title,BOOL isDisabled,NSTimeInterval unUseTime )
{
    CYPAlertItem *item = [CYPAlertItem new];
    item.title = title;
    item.isDisabled = isDisabled;
    item.unUseTime = unUseTime;
    return item;
}
