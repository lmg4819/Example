//
//  VINTextField.m
//  车易拍
//
//  Created by Mac on 16/3/21.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import "CYPCustomTextField.h"
#import "NSObject+AssociatedObject.h"

@implementation CYPCustomTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lineColor = [UIColor colorWithRed:206/255. green:206/255. blue:206/255. alpha:1.];
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineColor = [UIColor colorWithRed:206/255. green:206/255. blue:206/255. alpha:1.];
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)setIsLimitChinese:(BOOL)isLimitChinese
{
    _isLimitChinese = isLimitChinese;
    if (_isLimitChinese) {
        self.keyboardType = UIKeyboardTypeASCIICapable;
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    if(_isShowLine)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(context, 1.0f);
        CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
        CGContextMoveToPoint(context, 0.0f, 0.0f);
        CGContextAddLineToPoint(context, rect.size.width, 0.0f);
        CGContextMoveToPoint(context, 0.0f, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        CGContextStrokePath(context);
        
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGFloat width_X = bounds.size.width - self.rightView.bounds.size.width - self.leftView.bounds.size.width-_rightOffset-_leftOffset;
    return CGRectMake(CGRectGetMaxX(self.leftView.frame)+_leftOffset, 0, width_X, bounds.size.height);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

-(CGRect)rightViewRectForBounds:(CGRect)bounds
{
    return [super rightViewRectForBounds:bounds];
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return [super leftViewRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))//禁止粘贴
    {
        return !_isLimitPaste;
    } else if (action==@selector(select:) || action==@selector(selectAll:)) {
        return !_isLimitSelect;
    }
    return [super canPerformAction:action withSender:sender];
}


- (void)textFieldDidChange:(UITextField *)textField
{
    if(_isLimitSymbol)//限制字符
    {
        textField.text = [self isValicateSymbolString:textField.text];
    }

    if(_limitCount&&textField.text.length>_limitCount)
    {
        textField.text = [textField.text substringToIndex:_limitCount];
    }
 
    if (_textDidChangeBlock) {
        _textDidChangeBlock(self);
    }
}
//限制标点
-(NSString *)isValicateSymbolString:(NSString *)string
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"~!@#$%^&*()_+{}|\"';/.,\\][=-`:?><～！@＃¥％……&＊（）——＋｜｝｛：“”‘’？》《—｀－＝［］、；／。，"];
    return [string stringByTrimmingCharactersInSet:set];
    
}

@end


@implementation CYPCustomTextField (CYPCommon)

- (instancetype)cyp_initAccountTFWithInputNumber:(NSInteger)inputNumber leftImage:(UIImage *)leftImage {
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    CYPCustomTextField * accountTF = [[CYPCustomTextField alloc] initWithFrame:CGRectMake(0,0, bounds.size.width, 44)];
    [accountTF setClearButtonMode:UITextFieldViewModeAlways];
    [accountTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    accountTF.autocorrectionType = UITextAutocorrectionTypeNo;
    accountTF.placeholder = @"账号/手机号";
    accountTF.font = [UIFont systemFontOfSize:14];
    accountTF.isLimitPaste = YES;
    accountTF.limitCount = inputNumber;
    if (leftImage) {
        UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [leftImageView setImage:leftImage];
        accountTF.leftView = leftImageView;
        accountTF.leftViewMode = UITextFieldViewModeAlways;
        accountTF.leftOffset = 5;
    }
    
    return accountTF;
}

- (instancetype)cyp_initPsdTFWithInputNumber:(NSInteger)inputNumber leftImage:(UIImage *)leftImage rightPsdShowImages:(NSArray *)psdShowImages {
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    CYPCustomTextField * psdTF = [[CYPCustomTextField alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
    [psdTF setClearButtonMode:UITextFieldViewModeAlways];
    [psdTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [psdTF setKeyboardType:UIKeyboardTypeNamePhonePad];
    [psdTF setSecureTextEntry:YES];
    psdTF.backgroundColor = [UIColor clearColor];
    psdTF.font = [UIFont systemFontOfSize:(14)];
    psdTF.placeholder = @"请输入密码，6~20位数字和字母组合";
    psdTF.isLimitPaste = YES;
    psdTF.isLimitChinese = YES;
    psdTF.isLimitSymbol = YES;
    psdTF.limitCount =inputNumber;
  
    if (leftImage) {
        UIImageView *pLeftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [pLeftImageView setImage:leftImage];
        psdTF.leftView = pLeftImageView;
        psdTF.leftViewMode = UITextFieldViewModeAlways;
        psdTF.leftOffset = 5.;
    }
    if (psdShowImages.count == 2) {
        UIButton * showButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [showButton setImage:[UIImage imageNamed:psdShowImages[0]] forState:UIControlStateNormal];
        [showButton setImage:[UIImage imageNamed:psdShowImages[1]] forState:UIControlStateSelected];
        [showButton associateValue:psdTF withKey:@"showPsdKey"];
        [showButton addTarget:self action:@selector(_psdShowStatusAction:) forControlEvents:UIControlEventTouchUpInside];
        psdTF.rightView = showButton;
        psdTF.rightOffset = 5;
    }
    
    return psdTF;
}

- (void)_psdShowStatusAction:(UIButton *)button
{
    button.selected = !button.isSelected;
    UITextField * tf = [button associatedValueForKey:@"showPsdKey"];
    tf.secureTextEntry = !button.isSelected;
}

- (instancetype)cyp_initImageCodeWithInputNumber:(NSInteger)inputNumber leftImage:(UIImage *)leftImage imageCodeURL:(NSString *)imageCodeURL{
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    CYPCustomTextField * _imageCodeTF = [[CYPCustomTextField alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
    _imageCodeTF.backgroundColor = [UIColor clearColor];
    _imageCodeTF.font = [UIFont systemFontOfSize:(14)];
    _imageCodeTF.placeholder = @"请输入图形验证码";
    [_imageCodeTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _imageCodeTF.autocorrectionType = UITextAutocorrectionTypeNo;
    [_imageCodeTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    _imageCodeTF.clearButtonMode = UITextFieldViewModeAlways;
   
    
    if (leftImage) {
        UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [leftImageView setImage:leftImage];
        _imageCodeTF.leftView = leftImageView;
        _imageCodeTF.leftViewMode = UITextFieldViewModeAlways;
        _imageCodeTF.leftOffset = 5;
    }
    if (imageCodeURL) {
        UIButton * codeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        [codeButton addTarget:self action:@selector(_imageCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        [codeButton associateValue:imageCodeURL withKey:@"imageCodeKey"];
        _imageCodeTF.rightView = codeButton;
        _imageCodeTF.rightOffset = 5;
        [self _imageCodeAction:codeButton];
        _imageCodeTF.rightViewMode = UITextFieldViewModeAlways;
    }
    
    return _imageCodeTF;
}

- (void)cyp_resetImageCodeURL:(NSString *)imageCodeURL
{
    if (imageCodeURL== nil) {
        return;
    }
    [self.rightView associateValue:imageCodeURL withKey:@"imageCodeKey"];
}

- (void)cyp_reloadImageCode
{
    [self _imageCodeAction:(UIButton *)self.rightView];
}

- (void)_imageCodeAction:(UIButton *)button
{
    __block UIButton * btn = button;
    NSString * imageURl = [button associatedValueForKey:@"imageCodeKey"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL * url = [[NSURL alloc] initWithString:imageURl];
        NSData * data = [NSData dataWithContentsOfURL:url];
        UIImage * image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [btn setImage:image forState:UIControlStateNormal];
        });
    });
}

- (instancetype)cyp_initSMSCodeWithInputNumber:(NSInteger)inputNumber leftImage:(UIImage *)leftImage rightSMSView:(UIView *)rightSMSView
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    
   CYPCustomTextField * _codeTF = [[CYPCustomTextField alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
    [_codeTF setClearButtonMode:UITextFieldViewModeAlways];
    [_codeTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_codeTF setAutocorrectionType:UITextAutocorrectionTypeNo];
    _codeTF.backgroundColor = [UIColor clearColor];
    _codeTF.font = [UIFont systemFontOfSize:(14)];
    _codeTF.placeholder = @"请输入验证码";
    _codeTF.limitCount = inputNumber;
    _codeTF.isLimitPaste = YES;
    [_codeTF setKeyboardType:UIKeyboardTypePhonePad];
 
    if (leftImage) {
        UIImageView *pLeftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [pLeftImageView setImage:leftImage];
        _codeTF.leftView = pLeftImageView;
        _codeTF.leftViewMode = UITextFieldViewModeAlways;
        _codeTF.leftOffset = 5.;
    }
    if (rightSMSView) {
        _codeTF.rightView = rightSMSView;
        _codeTF.rightOffset = 5;
        _codeTF.rightViewMode = UITextFieldViewModeAlways;
    }
    
    return _codeTF;
}
@end


