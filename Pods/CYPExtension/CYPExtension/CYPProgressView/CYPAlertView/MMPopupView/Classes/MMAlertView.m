//
//  MMAlertView.m
//  MMPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "MMAlertView.h"
#import "MMPopupItem.h"
#import "MMPopupCategory.h"
#import "MMPopupDefine.h"
#import "CYPCountDownButton.h"
#import "Masonry.h"
#import "C_MacroDefine.h"
#import "UIView+ViewAddtions.h"
@interface MMAlertView()

@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UILabel      *detailLabel;
@property (nonatomic, strong) UIScrollView *detailContentScroller;

@property (nonatomic, strong) UITextField  *inputView;
@property (nonatomic, strong) UIView       *buttonView;

@property (nonatomic, strong) NSArray      *actionItems;

@property (nonatomic, copy) MMPopupInputHandler inputHandler;

@end

@implementation MMAlertView

- (instancetype) initWithInputTitle:(NSString *)title
                             detail:(NSString *)detail
                        placeholder:(NSString *)inputPlaceholder
                            handler:(MMPopupInputHandler)inputHandler
{
    MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
    
    NSArray *items =@[
                      MMItemMake(config.defaultTextCancel, MMItemTypeHighlight, nil),
                      MMItemMake(config.defaultTextConfirm, MMItemTypeHighlight, nil)
                      ];
    return [self initWithTitle:title detail:[[NSAttributedString alloc] initWithString:detail]  items:items inputPlaceholder:inputPlaceholder inputHandler:inputHandler];
}

- (instancetype) initWithConfirmTitle:(NSString*)title
                               detail:(NSString*)detail
{
    MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
    
    NSArray *items =@[
                      MMItemMake(config.defaultTextOK, MMItemTypeHighlight, nil)
                      ];
    
    return [self initWithTitle:title detail:detail items:items];
}

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray*)items
{
    return [self initWithTitle:title detail:[[NSAttributedString alloc] initWithString:detail] items:items inputPlaceholder:nil inputHandler:nil];
}
- (instancetype) initWithTitle:(NSString*)title
          detailAttributedText:(NSAttributedString*)detailAttributedText
                         items:(NSArray*)items {
    return [self initWithTitle:title detail:detailAttributedText items:items inputPlaceholder:nil inputHandler:nil];
}
- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSAttributedString *)detail
                        items:(NSArray *)items
             inputPlaceholder:(NSString *)inputPlaceholder
                 inputHandler:(MMPopupInputHandler)inputHandler
{
    self = [super init];
    
    if ( self )
    {
        NSAssert(items.count>0, @"Could not find any items.");
        
        MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
        
        self.type = MMPopupTypeAlert;
        self.withKeyboard = (inputHandler!=nil);
        
        self.inputHandler = inputHandler;
        self.actionItems = items;
        
        self.layer.cornerRadius = config.cornerRadius;
        self.clipsToBounds = YES;
        self.backgroundColor = config.backgroundColor;
        self.layer.borderWidth = MM_SPLIT_WIDTH;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(config.width);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        if ( title.length > 0 )
        {
            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(20);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
            }];
            self.titleLabel.textColor = config.titleColor;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = KRegularFont(config.titleFontSize);
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.backgroundColor = self.backgroundColor;
            self.titleLabel.text = title;
            
            lastAttribute = self.titleLabel.mas_bottom;
        }
        
        if ( detail.length > 0 )
        {
            self.detailContentScroller = [UIScrollView new];
            self.detailContentScroller.showsHorizontalScrollIndicator = NO;
            self.detailContentScroller.showsVerticalScrollIndicator = NO;
            self.detailContentScroller.backgroundColor = [UIColor clearColor];
            self.detailLabel = [UILabel new];
            [self addSubview:self.detailContentScroller];
            [self.detailContentScroller addSubview:self.detailLabel];
           
            [self.detailContentScroller mas_makeConstraints:^(MASConstraintMaker *make) {
                CGFloat offB = 20;
                if (title.length>0) {
                    offB = 16;
                }
                make.top.equalTo(lastAttribute).offset(offB);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
            }];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(0);
                make.left.equalTo(self.detailContentScroller.mas_left);
                make.width.equalTo(self.detailContentScroller.mas_width);
            }];
           
            self.detailLabel.textAlignment = NSTextAlignmentCenter;
            self.detailLabel.textColor = config.detailColor;
            self.detailLabel.font = [UIFont systemFontOfSize:config.detailFontSize];
            self.detailLabel.numberOfLines = 0;
            self.detailLabel.backgroundColor = [UIColor clearColor];
            self.detailLabel.attributedText = detail;
            
            [self.detailContentScroller layoutIfNeeded];
            [self layoutIfNeeded];
            CGFloat offB = 20;
            if (title.length>0) {
                offB = 16;
            }
            CGFloat maxHeight = (307 - self.titleLabel.frame.size.height - 20-offB -44.5-20 );
            if (maxHeight<self.detailLabel.height_v) {
                [self.detailContentScroller mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastAttribute).offset(16);
                    make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
                    make.height.mas_lessThanOrEqualTo((307 - self.titleLabel.frame.size.height - 20-16 -44.5-20 ));
                }];
            }else {
                [self.detailContentScroller mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastAttribute).offset(16);
                    make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
                    make.height.mas_equalTo(self.detailLabel.height_v);
                }];
            }
            
            self.detailContentScroller.contentSize = CGSizeMake(self.detailLabel.frame.size.width, self.detailLabel.frame.size.height);
            lastAttribute = self.detailContentScroller.mas_bottom;
        }
        
        if ( self.inputHandler )
        {
            self.inputView = [UITextField new];
            [self addSubview:self.inputView];
            [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(10);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
                make.height.mas_equalTo(40);
            }];
            self.inputView.backgroundColor = self.backgroundColor;
            self.inputView.layer.borderWidth = MM_SPLIT_WIDTH;
            self.inputView.layer.borderColor = config.splitColor.CGColor;
            self.inputView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            self.inputView.leftViewMode = UITextFieldViewModeAlways;
            self.inputView.clearButtonMode = UITextFieldViewModeWhileEditing;
            self.inputView.placeholder = inputPlaceholder;
            
            lastAttribute = self.inputView.mas_bottom;
        }
        
        self.buttonView = [UIView new];
        [self addSubview:self.buttonView];
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).offset(20);
            make.left.right.equalTo(self);
        }];
        
        __block UIButton *firstButton = nil;
        __block UIButton *lastButton = nil;
        for ( NSInteger i = 0 ; i < items.count; ++i )
        {
            MMPopupItem *item = items[i];
            
            CYPCountDownButton *btn = [CYPCountDownButton mm_buttonWithTarget:self action:@selector(actionButton:)];
            [self.buttonView addSubview:btn];
            btn.tag = i;
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                if ( items.count <= 2 )
                {
                    make.top.bottom.equalTo(self.buttonView);
                    make.height.mas_equalTo(config.buttonHeight);
                    
                    if ( !firstButton )
                    {
                        firstButton = btn;
                        make.left.equalTo(self.buttonView.mas_left).offset(-MM_SPLIT_WIDTH);
                    }
                    else
                    {
                        make.left.equalTo(lastButton.mas_right).offset(-MM_SPLIT_WIDTH);
                        make.width.equalTo(firstButton);
                    }
                }
                else
                {
                    make.left.right.equalTo(self.buttonView);
                    make.height.mas_equalTo(config.buttonHeight);
                    
                    if ( !firstButton )
                    {
                        firstButton = btn;
                        make.top.equalTo(self.buttonView.mas_top).offset(-MM_SPLIT_WIDTH);
                    }
                    else
                    {
                        make.top.equalTo(lastButton.mas_bottom).offset(-MM_SPLIT_WIDTH);
                        make.width.equalTo(firstButton);
                    }
                }
                
                lastButton = btn;
            }];
            if (item.unUseTime>0) {
                [btn countDownButtonHandler:^(CYPCountDownButton*sender, NSInteger tag) {
                    sender.enabled = !item.disabled;
                    
                    [sender startCountDownWithSecond:item.unUseTime];
                    
                    [sender countDownChanging:^NSString *(CYPCountDownButton *countDownButton,NSUInteger second) {
                        NSString *title = [NSString stringWithFormat:@"%@(%lu秒)",item.title,(unsigned long)second];
                        if (item.disabled) {
                            [countDownButton setTitleColor:config.itemDisableColor forState:UIControlStateNormal];
                        }else {
                            [countDownButton setTitleColor:item.highlight?config.itemHighlightColor:config.itemNormalColor forState:UIControlStateNormal];
                        }
                        return title;
                    }];
                    [sender countDownFinished:^NSString *(CYPCountDownButton *countDownButton, NSUInteger second) {
                        countDownButton.enabled = YES;
                        [countDownButton setTitleColor:item.highlight?config.itemHighlightColor:config.itemNormalColor forState:UIControlStateNormal];
                        
                        return item.title;
                        
                    }];
                    
                }];
            }
            [btn setBackgroundImage:[UIImage mm_imageWithColor:self.backgroundColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage mm_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
            [btn setTitle:item.title forState:UIControlStateNormal];
            [btn setTitleColor:item.highlight?config.itemHighlightColor:config.itemNormalColor forState:UIControlStateNormal];
            btn.layer.borderWidth = MM_SPLIT_WIDTH;
            btn.layer.borderColor = config.splitColor.CGColor;
            btn.titleLabel.font = KRegularFont(config.buttonFontSize);
        }
        [lastButton mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if ( items.count <= 2 )
            {
                make.right.equalTo(self.buttonView.mas_right).offset(MM_SPLIT_WIDTH);
            }
            else
            {
                make.bottom.equalTo(self.buttonView.mas_bottom).offset(MM_SPLIT_WIDTH);
            }
            
        }];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.buttonView.mas_bottom);
            
        }];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)actionButton:(UIButton*)btn
{
    MMPopupItem *item = self.actionItems[btn.tag];
    
//    if ( item.disabled )
//    {
//        return;
//    }
//
    if ( self.withKeyboard && (btn.tag==1) )
    {
        if ( self.inputView.text.length > 0 )
        {
            [self hide];
        }
    }
    else
    {
        [self hide];
    }
    
    if ( self.inputHandler && (btn.tag>0) )
    {
        self.inputHandler(self.inputView.text);
    }
    else
    {
        if ( item.handler )
        {
            item.handler(btn.tag);
        }
    }
}

- (void)notifyTextChange:(NSNotification *)n
{
    if ( self.maxInputLength == 0 )
    {
        return;
    }
    
    if ( n.object != self.inputView )
    {
        return;
    }
    
    UITextField *textField = self.inputView;
    
    NSString *toBeString = textField.text;

    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > self.maxInputLength) {
            textField.text = [toBeString mm_truncateByCharLength:self.maxInputLength];
        }
    }
}

- (void)showKeyboard
{
    [self.inputView becomeFirstResponder];
}

- (void)hideKeyboard
{
    [self.inputView resignFirstResponder];
}

@end


@interface MMAlertViewConfig()

@end

@implementation MMAlertViewConfig

+ (MMAlertViewConfig *)globalConfig
{
    static MMAlertViewConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [MMAlertViewConfig new];
        
    });
    
    return config;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.width          = 275.0f;
        self.buttonHeight   = 50.0f;
        self.innerMargin    = 25.0f;
        self.cornerRadius   = 5.0f;

        self.titleFontSize  = 18.0f;
        self.detailFontSize = 14.0f;
        self.buttonFontSize = 17.0f;
        
        self.backgroundColor    = MMHexColor(0xFFFFFFFF);
        self.titleColor         = MMHexColor(0x333333FF);
        self.detailColor        = MMHexColor(0x333333FF);
        self.splitColor         = MMHexColor(0xCCCCCCFF);

        self.itemNormalColor    = MMHexColor(0x333333FF);
        self.itemHighlightColor = MMHexColor(0xE76153FF);
        self.itemPressedColor   = MMHexColor(0xEFEDE7FF);
        self.itemDisableColor   = UIColorRGB(0xCCCCCC);
        
        self.defaultTextOK      = @"好";
        self.defaultTextCancel  = @"取消";
        self.defaultTextConfirm = @"确定";
    }
    
    return self;
}

@end
