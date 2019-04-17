//
//  CYPAlertView.h
//  CarEasyBuy
//
//  Created by cheyipai.com on 2018/8/6.
//  Copyright © 2018年 北京巅峰科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMAlertView.h"

@interface CYPAlertView : MMAlertView
/**
 * alert弹框 用于警示或告知用户操作可能会产生的后果
 * title       标题
 * detail      文案
 * titleItems  按钮标题
 * selectIndex 点击回调
 */
- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                    titleItems:(NSArray<NSString *>*)titleItems
                   selectBlock:(void (^)(NSInteger index))selectIndex;
/**
 * alert弹框 富文本情况
 * title                     标题
 * detailattributedText      富文本文案
 * items                     按钮 CYPAlertItem 类型数组
 * selectIndex               点击回调
 */
- (instancetype) initWithTitle:(NSString*)title
          detailAttributedText:(NSAttributedString*)detailattributedText
                         items:(NSArray<CYPAlertItem*>*)items
                   selectBlock:(void (^)(NSInteger index))selectIndex;
@end
