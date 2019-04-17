//
//  C_MacroDefine.h
//

#ifndef C_MacroDefine_h
#define C_MacroDefine_h
/***************************
    常用宏定义
 ***************************/
#define kUserDefaults               [NSUserDefaults standardUserDefaults]
/********设备大小*********/
#define SCREEN_WIDTH                ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT               ([UIScreen mainScreen].bounds.size.height)

#define kScreenHeight               [UIScreen mainScreen].bounds.size.height
#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenBounds               [UIScreen mainScreen].bounds
#define kKeyWindow                  [[UIApplication sharedApplication] keyWindow]

#define kStatusBarHeight            [[UIApplication sharedApplication] statusBarFrame].size.height
#define kTabBarHeight               49.f
#define kNaviBarHeight              (kStatusBarHeight + 44.f)
#define IS_IPHONE_XSerial  (((int)((kScreenHeight/kScreenWidth)*100) == 216)?YES:NO)
#define kIndicatorHeight            (IS_IPHONE_XSerial ? 34.f : 0.f)
/********设备大小*********/

/******尺寸适配*******/
#define kSHRATIO(ratio)             floor((kScreenWidth/375.)*ratio)

#define DesignedWidth 750.0f
#define FixedWidthReal(x) ((x) * SCREEN_WIDTH / DesignedWidth)
#define FixedWidth(x) ceilf(FixedWidthReal(x))

#define DesignedWidth2 375.0f
#define FixedWidthReal2(x) ((x) * SCREEN_WIDTH / DesignedWidth2)
#define FixedWidth2(x) ceilf(FixedWidthReal2(x))

#define FixedWidthAuto(x) ((x) * SCREEN_WIDTH / DesignWidth)
#define DesignWidth  320.f
//只为4寸屏缩放
#define FixedWidth_4ft(x) (SCREEN_WIDTH < 375.f?ceilf(FixedWidthReal2(x)):x)
/******尺寸适配*******/

//获取UIimage
#define kNameImage(N)               [UIImage imageNamed:N]
#define kBundleImage(N,T)           [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:N ofType:T]]
#define kCYPBaseClassImageName(N)         kNameImage(@"CYPBaseClass.bundle/" N)
//Color
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
                                                colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                                green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
                                                blue:((float)(rgbValue & 0x0000FF))/255.0 \
                                                alpha:alphaValue]

#define CYPColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define CYPColorAlpha(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define UIColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorRGBA(rgb,a) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:a])

//////////FONT
#define KRegularFont(font)       [[[UIDevice currentDevice]systemVersion] floatValue] > 9.0?[UIFont fontWithName:@"PingFangSC-Regular" size:font]:[UIFont systemFontOfSize:font]
#define KSemiboldFont(font)      [[[UIDevice currentDevice]systemVersion] floatValue] > 9.0?[UIFont fontWithName:@"PingFangSC-Semibold" size:font]:[UIFont boldSystemFontOfSize:font]
#define KMediumFont(font)        [[[UIDevice currentDevice]systemVersion] floatValue] > 9.0?[UIFont fontWithName:@"PingFangSC-Medium" size:font]:[UIFont boldSystemFontOfSize:font]


//调试输出
#define __BEE_TESTING__  (1) // 是否启用开发模式
#define __BEE_LOG__      (1) // 是否打印LOG
#define __BEE_DEBUGGER__ (1) // 是否开启Debug
#ifdef DEBUG
#   define CYPLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define CYPLog(...)
#endif

///block
#define DefineWeakSelf  __weak  typeof(self) weakSelf  = self;
#define DefineBlockSelf __block typeof(self) blockSelf = self;

//系统判断
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0
#define IOS9 [[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0
#define IOS10 [[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0

//判断字符串是否为空
#define JudgeString(A) ((A==nil)||[A isEqual:[NSNull null]]||[A isEqualToString:@"<null>"]||[A isEqualToString:@"null"]||[A isEqualToString:@"(null)"])?@"":A

/*****请求BLOCK******/
#define RquestFailPrompt    @"加载错误，请稍后重试"

typedef void (^CYPSuccessBlock)(id model, NSInteger resultCode, NSString* stateDescription);
typedef void (^SuccessArrayBlock)(NSArray *successArray,NSInteger resultCode, NSString* stateDescription);
typedef void (^SuccessOnlyArrayBlock)(NSArray *successArray);
typedef void (^SuccessOnlyDicBlock)(NSDictionary *successDic);
typedef void (^SuccessOnlyStrBlock)(NSString *msg);
typedef void (^CYPFailBlock)(NSString *errorStr);
typedef void (^FailErrorBlock)(NSString *errorStr,NSInteger resultCode, NSString* stateDescription);

#endif /* C_MacroDefine_h */
