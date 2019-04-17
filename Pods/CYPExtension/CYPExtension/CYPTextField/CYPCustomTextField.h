//
//  VINTextField.h
//  车易拍
//
//  Created by Mac on 16/3/21.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYPCustomTextField;

typedef void (^TextFieldBlock) (UITextField *tf);
typedef void (^CYPTextFieldDidChangeBlock)(CYPCustomTextField * textField);

@interface CYPCustomTextField : UITextField

@property(assign,nonatomic)CGFloat rightOffset;//rightview与text左右间距
@property(assign,nonatomic)CGFloat leftOffset;//leftview与text左右间距

@property(assign,nonatomic)NSInteger limitCount;//限制字数
@property(assign,nonatomic)BOOL isLimitSymbol;//是否限制符号
@property(assign,nonatomic)BOOL isLimitChinese;//是否限制中文
@property(assign,nonatomic)BOOL isLimitPaste;//是否禁止粘贴
@property(assign,nonatomic)BOOL isLimitSelect;//禁止选择

@property(assign,nonatomic)BOOL isShowLine;//是否显示上下边线
@property(strong,nonatomic)UIColor *lineColor;//边线颜色

@property (strong, nonatomic) CYPTextFieldDidChangeBlock textDidChangeBlock;



@end


@interface CYPCustomTextField (CYPCommon)
//实现一些如：账号、密码、短信验证码、图片验证的组合TextField

/* 账号
    描述： 高度44 图标 30,30大小,带clear button
    限制： 中文、特殊符号
    左边图标； 与文本间距为5px
    @param  inputNumber 字数限制 0为不限
    @param  leftImage 左边图片
 */
- (instancetype)cyp_initAccountTFWithInputNumber:(NSInteger)inputNumber leftImage:(UIImage *)leftImage;


/* 密码
    描述： 高度44 图标 30,30大小,带clear button
    限制：中文、粘贴、特殊符号
    左视图； 与文本间距为5px
    @param  inputNumber 字数限制 0为不限
    @param  leftImage 左边图片
    @Param  psdShowImages 密码明文图标 @[@"密文",@"明文"]
 */
- (instancetype)cyp_initPsdTFWithInputNumber:(NSInteger)inputNumber leftImage:(UIImage *)leftImage rightPsdShowImages:(NSArray *)psdShowImages;

/* 图形验证码
    限制：中文、粘贴、特殊符号
    左视图； 与文本间距为5px
    @param  inputNumber 字数限制 0为不限
    @param  leftImage 左边图片
    @param  imageCodeURL 图片验证码地址
 */
- (instancetype)cyp_initImageCodeWithInputNumber:(NSInteger)inputNumber leftImage:(UIImage *)leftImage imageCodeURL:(NSString *)imageCodeURL;
//设置图片URL
- (void)cyp_resetImageCodeURL:(NSString *)imageCodeURL;
//重新加载验证码图片
- (void)cyp_reloadImageCode;

/* 短信验证码, 只支持数字输入
    限制：中文、粘贴、特殊符号
    左视图； 与文本间距为5px
    @param  inputNumber 字数限制 0为不限
    @param  leftImage 左边图片
    @param  rightSMSView 短信验证码视图
 */
- (instancetype)cyp_initSMSCodeWithInputNumber:(NSInteger)inputNumber leftImage:(UIImage *)leftImage rightSMSView:(UIView *)rightSMSView;



@end
