//
//  ViewController.m
//  Example0
//
//  Created by lmg on 2018/9/10.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "ViewController.h"
#import <MyLibrary/SDCycleScrollView.h>
#import <MyLibrary/UIView+SDExtension.h>
//#import "JSPhotoBrowser/JSPhotoBrowserViewController.h"
#import "JSPhotoBrowser/JSPhotoBrowserViewController.h"
#import "JSPhotoBrowser/UIView+JSLayout.h"
#import "RegisterAPI.h"
#import "GetUserInfoAPI.h"
#import "AppDelegate.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "JSCombination.h"
#import "EOCClass.h"
#import <OpenGLES/EAGL.h>
#import "EOCSecondViewController.h"
#import <TTGTextTagCollectionView.h>
#import "EOCCPPerson.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "Capture18.h"
#import <ReactiveObjC.h>
#import "OrderItem.h"
#import "EOCSubViewController.h"

@interface JSButton : UIButton

@end

@implementation JSButton

-(void)setHighlighted:(BOOL)highlighted
{
    
}

@end


@interface ViewController ()<SDCycleScrollViewDelegate,YTKRequestDelegate,UIAlertViewDelegate,TTGTextTagCollectionViewDelegate>
@property (nonatomic,strong) NSArray *imageNameArray;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *tempArray;
@property (nonatomic,strong) dispatch_semaphore_t semephore;
@property (nonatomic,strong) dispatch_queue_t serialQueue;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) EOCCPPerson *person;
@end

@implementation ViewController

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ( [keyPath isEqualToString:@"age"]) {
        NSLog(@"%@",change);
    }
}

-(void)printClassMethodNamesOfClass:(Class)cls{
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i=0; i<count; i++) {
        Method method = methodList[i];
        NSString *methosName = NSStringFromSelector(method_getName(method));
        NSLog(@"方法名：%@ \n",methosName);
    }
    free(methodList);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.person.age = 10;
}

- (void)testKVO{
    self.person = [EOCCPPerson new];
    self.person.age = 5;
    //(Example0`-[EOCCPPerson setAge:] at EOCCPPerson.h:14)
    NSLog(@"person添加监听之前---%p",[self.person methodForSelector:@selector(setAge:)]);
    [self.person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    //(Foundation`_NSSetLongLongValueAndNotify)
    NSLog(@"person添加监听之后---%p",[self.person methodForSelector:@selector(setAge:)]);
    NSLog(@"%@",object_getClass(self.person));
    
    [self printClassMethodNamesOfClass:object_getClass(self.person)];
}

- (void)test{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 250, 70, 70)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    btn.tag = 1001;
    //监听点击事件
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"按钮点击了%@",x);
    }];
    
    [[btn rac_valuesAndChangesForKeyPath:@"frame" options:(NSKeyValueObservingOptionNew) observer:self] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"frame改变了%@",x.second);
    }];
    
}
static int countIndex = 0;
- (void)textHello{
    countIndex ++;
    NSLog(@"==========%d",countIndex);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
//    OrderItem *item0 = [OrderItem new];
//    OrderItem *item1 = [OrderItem new];
//    OrderItem *item2 = [OrderItem new];
//    OrderItem *item3 = [OrderItem new];
//    OrderItem *item4 = [OrderItem new];
//    NSArray *orderItems = @[item0,item1,item2,item3,item4];
//    NSNumber *totalPrices = [orderItems valueForKeyPath:@"@sum.price"];
//    NSNumber *totalItems = [orderItems valueForKeyPath:@"@count"];
//    NSArray *itemTypes = [orderItems valueForKeyPath:@"@distinctUnionOfObjects.desc"];
//
//
//    Order *order = [Order new];
//    NSNumber *items = [order valueForKeyPath:@"items.@count"];
    
//    for (int i=0; i<10; i++) {
//        [self textHello];
//    }
//
    JSButton * agreeButton = [JSButton buttonWithType:UIButtonTypeCustom];
    agreeButton.frame = CGRectMake((self.view.js_width-200)/2, 200, 200, 44);
    agreeButton.backgroundColor = [UIColor lightGrayColor];
    agreeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [agreeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [agreeButton setImage:[UIImage imageNamed:@"duoxuan"] forState:UIControlStateNormal];
    [agreeButton setImage:[UIImage imageNamed:@"xuanzhong6"] forState:UIControlStateSelected];
    [agreeButton setTitle:@"漆膜检测" forState:UIControlStateNormal];
    [agreeButton setTitle:@"漆膜检测222" forState:UIControlStateSelected];
    agreeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [agreeButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreeButton];
    agreeButton.selected = YES;
    
    
    
    
}

- (void)btnSelected:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self test];
}


/*
 1:51
 2:108
 */
- (void)testTagCollectionView
{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    TTGTextTagCollectionView *tagCollectionView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectMake(20, 100, self.view.js_width-40, 200)];
    
    tagCollectionView.delegate = self;
    tagCollectionView.selectionLimit = 1;
    tagCollectionView.defaultConfig.tagBackgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    tagCollectionView.defaultConfig.tagSelectedBackgroundColor = [UIColor colorWithRed:228/255.0 green:237/255.0 blue:255/255.0 alpha:1.0];
    
    tagCollectionView.defaultConfig.tagTextColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1/1.0];
    tagCollectionView.defaultConfig.tagSelectedTextColor = [UIColor colorWithRed:83/255.0 green:142/255.0 blue:235/255.0 alpha:1/1.0];
    
    
    tagCollectionView.defaultConfig.tagTextFont = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    tagCollectionView.defaultConfig.tagExtraSpace = CGSizeMake(30, 30);
    tagCollectionView.horizontalSpacing = 10;
    
    tagCollectionView.verticalSpacing = 10;
    tagCollectionView.defaultConfig.tagShadowColor = [UIColor clearColor];
    
    tagCollectionView.defaultConfig.tagBorderColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1/1.0];
    tagCollectionView.defaultConfig.tagSelectedBorderColor = [UIColor colorWithRed:160/255.0 green:191/255.0 blue:243/255.0 alpha:1.0];
    
    tagCollectionView.defaultConfig.tagShadowOffset = CGSizeMake(0, 0);
    [self.view addSubview:tagCollectionView];
    //    [tagCollectionView addTags:@[@"新款选择错误", @"需重新评级", @"补充信息", @"补充照片信息",@"评估检测信息不符"]];
    [tagCollectionView addTags:@[@"新款选择错误", @"需重新评级", @"补充信息",@"新款选择错误", @"需重新评级", @"补充信息", @"补充照片信息",@"评估检测信息不符",@"新款选择错误", @"需重新评级", @"补充信息", @"补充照片信息",@"评估检测信息不符"]];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",NSStringFromCGSize(tagCollectionView.contentSize));
    });
    
}


#pragma mark -TTGTextTagCollectionViewDelegate
- (BOOL)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView
                    canTapTag:(NSString *)tagText
                      atIndex:(NSUInteger)index
              currentSelected:(BOOL)currentSelected
                    tagConfig:(TTGTextTagConfig *)config
{
    return YES;
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView
                    didTapTag:(NSString *)tagText
                      atIndex:(NSUInteger)index
                     selected:(BOOL)selected
                    tagConfig:(TTGTextTagConfig *)config
{
    self.currentIndex = index;
    
    NSLog(@"%d",index);
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView
            updateContentSize:(CGSize)contentSize
{
    
}


- (void)buttonClicked
{
    EOCSubViewController *vc = [[EOCSubViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)button2Clicked
{
    char *a = malloc(100*1024*1024);
    NSLog(@"%p",a);
    for (int i=0; i<3*1024*1024; i++) {
        a[i] = rand();
    }
}

-(void)didReceiveMemoryWarning
{
    NSLog(@"%p-----yyyyy",__func__);
}

#pragma mark -YTKRequestDelegate
-(void)requestFinished:(__kindof YTKBaseRequest *)request
{
    
}

-(void)requestFailed:(__kindof YTKBaseRequest *)request
{
    
}

#pragma mark -SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //    UIImage *image = [UIImage imageNamed:@"005.jpg"];
    JSPhotoBrowserViewController *vc = [[JSPhotoBrowserViewController alloc]initWithPhotos:self.imageNameArray];
    vc.needCircleCrop = NO;
    vc.currentIndex = index;
    vc.allowCrop = YES;
    CGFloat cropViewWH = MIN(self.view.js_width, self.view.js_height);
    vc.cropRect = CGRectMake(0, (self.view.js_height - cropViewWH/3*2) / 2, cropViewWH, cropViewWH/3*2);
    __weak typeof(self) weakSelf = self;
    vc.doneButtonClickBlockCropMode = ^(UIImage * _Nonnull cropedImage) {
        weakSelf.imageView.image = cropedImage;
    };
    [self.navigationController pushViewController:vc animated:YES];
    //    NSLog(@"------%ld------",(long)index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    //    NSLog(@"======%ld======",(long)index);
}

//动态消息添加
//void loadDataWithString(id self,SEL _cmd,id value)
//{
//    NSLog(@"111111----%@",value);
//}
//
//
//+(BOOL)resolveInstanceMethod:(SEL)sel
//{
//    NSString *selectorName = NSStringFromSelector(sel);
//    if ([selectorName isEqualToString:@"loadData:"]) {
//        class_addMethod(self, sel, (IMP)loadDataWithString, "v@:@");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

//备援接受者
-(id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}
//完整的消息转发流程

-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    
}

-(void)doesNotRecognizeSelector:(SEL)aSelector
{
    
}



@end
