//
//  EOCSecondViewController.h
//  Example0
//
//  Created by lmg on 2018/10/25.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EOCSecondViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
/*
 //
 //  CYPGuideView.m
 //  MGMS
 //
 //  Created by songgp on 2018/1/9.
 //  Copyright © 2018年 北京巅峰科技有限公司. All rights reserved.
 //
 
 #import "CYPGuideView.h"
 #import "CD_MacroDefine.h"
 @implementation CYPGuideView{
 UIImageView*firstImageView;
 UIImageView*secondImageView;
 UIImageView*thirdImageView;
 UIImageView*fourImageView;
 }
 
 - (instancetype)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 if (self) {
 self.backgroundColor = UIColorMake(125, 125, 125);
 [self createView];
 }
 return self;
 }
 
 -(void)createView
 {
 [self fourImageView];
 [self thirdImageView];
 [self secondImageView];
 [self firstImageView];
 }
 
 - (void)fourImageView
 {
 fourImageView = [[UIImageView alloc]init];
 [fourImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
 fourImageView.image = kCloudImageName("千里眼-漆膜引导d");
 fourImageView.userInteractionEnabled = YES;
 fourImageView.contentMode = UIViewContentModeScaleAspectFit;
 [self addSubview:fourImageView];
 [fourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.top.mas_equalTo(0);
 make.bottom.mas_equalTo(0);
 }];
 
 UITapGestureRecognizer* gestureZer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFourMethod)];
 [fourImageView addGestureRecognizer:gestureZer];
 }
 
 -(void)firstImageView
 {
 firstImageView = [[UIImageView alloc]init];
 [firstImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
 firstImageView.image = kCloudImageName("千里眼-漆膜引导a");
 firstImageView.userInteractionEnabled = YES;
 firstImageView.contentMode = UIViewContentModeScaleAspectFit;
 [self addSubview:firstImageView];
 [firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.top.mas_equalTo(0);
 make.bottom.mas_equalTo(0);
 }];
 
 UIButton* firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
 firstButton.backgroundColor = [UIColor clearColor];
 firstButton.frame = CGRectMake(80, SCREEN_HEIGHT/3*2 - 30, SCREEN_WIDTH - 160, 80);
 [firstButton addTarget:self action:@selector(jumpGuideMethod) forControlEvents:UIControlEventTouchUpInside];
 [firstImageView addSubview:firstButton];
 
 UITapGestureRecognizer* gestureZer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFirstMethod)];
 [firstImageView addGestureRecognizer:gestureZer];
 }
 
 -(void)secondImageView
 {
 secondImageView = [[UIImageView alloc]init];
 [secondImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
 secondImageView.image = kCloudImageName("千里眼-漆膜引导b");
 secondImageView.userInteractionEnabled = YES;
 secondImageView.contentMode = UIViewContentModeScaleAspectFit;
 [self addSubview:secondImageView];
 [secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.top.mas_equalTo(0);
 make.bottom.mas_equalTo(0);
 }];
 
 UIButton* secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
 secondButton.backgroundColor = [UIColor clearColor];
 secondButton.frame = CGRectMake(80, SCREEN_HEIGHT/3*2 - 30, SCREEN_WIDTH - 160, 80);
 [secondButton addTarget:self action:@selector(jumpGuideMethod) forControlEvents:UIControlEventTouchUpInside];
 [secondImageView addSubview:secondButton];
 
 UITapGestureRecognizer* gestureZer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSecondMethod)];
 [secondImageView addGestureRecognizer:gestureZer];
 }
 
 -(void)thirdImageView
 {
 thirdImageView = [[UIImageView alloc]init];
 [thirdImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
 thirdImageView.image = kCloudImageName("千里眼-漆膜引导c");
 thirdImageView.userInteractionEnabled = YES;
 thirdImageView.contentMode = UIViewContentModeScaleAspectFit;
 [self addSubview:thirdImageView];
 [thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.top.mas_equalTo(0);
 make.bottom.mas_equalTo(0);
 }];
 
 UIButton* fourButton = [UIButton buttonWithType:UIButtonTypeCustom];
 fourButton.backgroundColor = [UIColor clearColor];
 fourButton.frame = CGRectMake(80, SCREEN_HEIGHT/3*2 - 30, SCREEN_WIDTH - 160, 80);
 [fourButton addTarget:self action:@selector(jumpGuideMethod) forControlEvents:UIControlEventTouchUpInside];
 [thirdImageView addSubview:fourButton];
 
 UITapGestureRecognizer* gestureZer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapThirdMethod)];
 [thirdImageView addGestureRecognizer:gestureZer];
 }
 
 #pragma mark - event
 
 -(void)tapFirstMethod
 {
 firstImageView.hidden = YES;
 }
 
 -(void)tapSecondMethod
 {
 secondImageView.hidden = YES;
 }
 
 -(void)tapThirdMethod
 {
 thirdImageView.hidden = YES;
 }
 
 -(void)jumpGuideMethod
 {
 [self removeFromSuperview];
 }
 
 - (void)tapFourMethod
 {
 [self removeFromSuperview];
 }
 
 @end

 
 
 */
