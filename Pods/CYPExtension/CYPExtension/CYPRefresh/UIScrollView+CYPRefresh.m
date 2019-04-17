//
//  UIScrollView+CYPRefresh.m
//  车易拍SH
//
//  Created by 马敬龙 on 16/3/22.
//  Copyright © 2016年 mjl. All rights reserved.
//

#import "UIScrollView+CYPRefresh.h"
#import "CYPRefreshGifCarHeader.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefreshBackNormalFooter.h"

#import "CYPAutoRefreshFooter.h"
#import "CYPAutoRefreshFooter.h"
@implementation UIScrollView (CYPRefresh)

- (void)cypHeaderRefreshing:(void(^)(void))refreshing {
    self.header = [CYPRefreshGifCarHeader headerWithRefreshingBlock:^{
        refreshing();
    }];
}

- (void)cypHeaderBeginRefresh {
    [self.header beginRefreshing];
}

- (void)cypHeaderEndRefresh {
    [self.header endRefreshing];
}

- (BOOL)isCypRefreshing {
    return [self.header isRefreshing];
}

- (void)cypFooterRefreshing:(void(^)(void))refreshing {
    self.footer = [CYPAutoRefreshFooter footerWithRefreshingBlock:^{
        refreshing();
    }];
//     忽略掉底部inset
//    self.mj_footer.ignoredScrollViewContentInsetBottom = 30;
}

- (void)cypFooterEndRefresh {
    [self.footer endRefreshing];
}

- (void)cypFooterNoMoreDataRefresh {
    [self.footer endRefreshing];
}

- (void)cypResetNormalData {
    [self.footer resetNoMoreData];
}

- (void)cypAutoFooterRefreshing:(void(^)(void))refreshing
{
    self.footer = [CYPAutoRefreshFooter footerWithRefreshingBlock:^{
        refreshing();
    }];
}

-(void)cypFooterHidden:(BOOL)hidden
{
    [self.footer setHidden:hidden];
}

- (void)cypTradeListAutoFooterRefreshing:(void(^)(void))refreshing
{
    self.footer = [CYPAutoRefreshFooter footerWithRefreshingBlock:^{
        refreshing();
    }];
}
@end
