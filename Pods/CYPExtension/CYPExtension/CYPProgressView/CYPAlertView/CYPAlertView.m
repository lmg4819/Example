//
//  CYPAlertView.m
//  CarEasyBuy
//
//  Created by cheyipai.com on 2018/8/6.
//  Copyright © 2018年 北京巅峰科技有限公司. All rights reserved.
//

#import "CYPAlertView.h"
#import "C_MacroDefine.h"

@implementation CYPAlertView
- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                    titleItems:(NSArray<NSString *>*)titleItems
                   selectBlock:(void (^)(NSInteger index))selectIndex {
    MMPopupItemHandler block = selectIndex;
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i<titleItems.count; i++) {
        if (titleItems.count == 1) {
            MMPopupItem *item = MMItemMake(titleItems[i], MMItemTypeHighlight, block);
            [items addObject:item];
        }else if (titleItems.count == 2){
            if (i == 0) {
                MMPopupItem *item = MMItemMake(titleItems[i], MMItemTypeNormal, block);
                [items addObject:item];
            }else {
                MMPopupItem *item = MMItemMake(titleItems[i], MMItemTypeHighlight, block);
                [items addObject:item];
            }
        }
    }
    [self globalConfig];
    CYPAlertView *alertView = [[CYPAlertView alloc] initWithTitle:title
                                                         detail:detail
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    return alertView;
}
- (instancetype) initWithTitle:(NSString*)title
          detailAttributedText:(NSAttributedString*)detailattributedText
                         items:(NSArray*)titleItems
                   selectBlock:(void (^)(NSInteger index))selectIndex {
    
    MMPopupItemHandler block = selectIndex;
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i<titleItems.count; i++) {
         CYPAlertItem * item1 = titleItems[i];
        if (titleItems.count == 1) {
            MMPopupItem *item = MMItemMake(item1.title, MMItemTypeHighlight, block);
            item.disabled = item1.isDisabled;
            item.unUseTime = item1.unUseTime;
            [items addObject:item];
        }else if (titleItems.count == 2){
            if (i == 0) {
                MMPopupItem *item = MMItemMake(item1.title, MMItemTypeNormal, block);
                item.disabled = item1.isDisabled;
                item.unUseTime = item1.unUseTime;
                [items addObject:item];
            }else {
                MMPopupItem *item = MMItemMake(item1.title, MMItemTypeHighlight, block);
                item.disabled = item1.isDisabled;
                item.unUseTime = item1.unUseTime;
                [items addObject:item];
            }
        }
    }
    
    [self globalConfig];
    CYPAlertView *alertView = [[CYPAlertView alloc] initWithTitle:title
                                                           detailAttributedText:detailattributedText
                                                            items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    return alertView;
}
- (void)globalConfig {
    [MMAlertViewConfig globalConfig].width = 270;
    [MMAlertViewConfig globalConfig].backgroundColor = UIColorRGB(0xfafafa);
    [MMAlertViewConfig globalConfig].buttonFontSize = 16;
    [MMAlertViewConfig globalConfig].innerMargin = 16;
    [MMAlertViewConfig globalConfig].itemNormalColor = UIColorRGB(0x1a1a1a);
    [MMAlertViewConfig globalConfig].itemHighlightColor = UIColorRGB(0xFF571A);
    [MMAlertViewConfig globalConfig].splitColor = UIColorRGB(0xdddddd);
    [MMAlertViewConfig globalConfig].itemPressedColor = UIColorRGB(0xe6e6e6);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
