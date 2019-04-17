//
//  UIScrollView+CYPRefresh.h
//  车易拍SH
//
//  Created by 马敬龙 on 16/3/22.
//  Copyright © 2016年 mjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CYPRefresh)

/*
    下拉刷新视图初始化，刷新回调
 */
- (void)cypHeaderRefreshing:(void(^)(void))refreshing;

/*
    启动刷新
 */
- (void)cypHeaderBeginRefresh;
/*
    结束刷新
 */
- (void)cypHeaderEndRefresh;

/*
    是否正在刷新
 */
- (BOOL)isCypRefreshing;

/*
    上拉加载
 */
- (void)cypFooterRefreshing:(void(^)(void))refreshing;
/*
 自动加载
 */
- (void)cypAutoFooterRefreshing:(void(^)(void))refreshing;
/*
    结束加载数据
 */
- (void)cypFooterEndRefresh;

/*
    没有更多加载数据
 */
- (void)cypFooterNoMoreDataRefresh;
/*
    重置无更多加载数据状态
 */
- (void)cypResetNormalData;


/**
  Footer是否隐藏
 */
-(void)cypFooterHidden:(BOOL)hidden;


/*
 交易大厅使用   底端footer 高度为 70
 */
- (void)cypTradeListAutoFooterRefreshing:(void(^)(void))refreshing;

@end
