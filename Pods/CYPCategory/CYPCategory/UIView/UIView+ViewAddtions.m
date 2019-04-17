//
//  UIView+ViewAddtions.m
//  ManagementCockpit
//
//  Created by songgp on 15/9/1.
//  Copyright (c) 2015年 车易拍. All rights reserved.
//

#import "UIView+ViewAddtions.h"

@implementation UIView (ViewAddtions)
//上边界
- (void)setTop_v:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
- (CGFloat)top_v
{
    return self.frame.origin.y;
}

//左边界
- (void)setLeft_v:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}
- (CGFloat)left_v
{
    return self.frame.origin.x;
}

//下边界
- (void)setBottom_v:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)bottom_v
{
    return self.frame.origin.y + self.frame.size.height;
}

//右边界
- (void)setRight_v:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)right_v
{
    return self.frame.origin.x + self.frame.size.width;
}

//宽
- (void)setWidth_v:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width_v
{
    return self.frame.size.width;
}

//高
-(void)setHeight_v:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height_v
{
    return self.frame.size.height;
}

//中点X
- (CGFloat)centerX_v {
    return self.center.x;
}

- (void)setCenterX_v:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.centerY_v);
}
//中点Y
- (CGFloat)centerY_v {
    return self.center.y;
}

- (void)setCenterY_v:(CGFloat)centerY {
    self.center = CGPointMake(self.centerX_v, centerY);
}

- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
