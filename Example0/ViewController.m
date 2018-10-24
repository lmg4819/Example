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



@interface ViewController ()<SDCycleScrollViewDelegate,YTKRequestDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) NSArray *imageNameArray;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *tempArray;
@property (nonatomic,strong) dispatch_semaphore_t semephore;
@property (nonatomic,strong) dispatch_queue_t serialQueue;
@end

@implementation ViewController

- (void)myTask
{
    for (NSInteger i = 0; i < 500000000; i++) {
        if (i == 0) {
            NSLog(@"任务 -> 开始---%@",[NSThread currentThread]);
        }
        if (i == 499999999) {
            NSLog(@"任务 -> 完成---%@",[NSThread currentThread]);
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib

   /*
    
    线程调度和操作队列
    
    
    
    通过[[NSOperationQueue alloc] init]这种方式得到的队列，它同时具备并发和串行的特征
    maxConcurrentOperationCount,值为0，则不会执行，值为1，队列中所有的任务都会串行执行的，不过，串行执行并不等于只开一条线程，当值大于0时，那么队列就是并发队列了。
    
    */
//    dispatch_apply(10, dispatch_get_global_queue(0, 0), ^(size_t idx) {
//        NSLog(@"%zu------%@",idx,[NSThread currentThread]);
//    });
//
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"hello"];
    [array addObject:@"world"];
    
    for (NSString *string in array) {
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
        NSLog(@"%@-----%@",string,[NSThread currentThread]);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_group_leave(group);
            });
        });
    }
    
    dispatch_async(queue, ^{
        dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC));
        NSLog(@"dispatch_group_wait 结束");
    });
    
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_notify(group, queue, ^{
         NSLog(@"iiiiiiiiiiiiiiiiii");
    });
//
//    NSLog(@"oooooooooooooooooooo");
    
//    dispatch_group_notify(group, queue, ^{
//
//    });
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, (self.view.js_width-100)/2, 44)];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"button" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 100+50, (self.view.js_width-100)/2, 44)];
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 setTitle:@"button2" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(button2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    
//    dispatch_get_current_queue();
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    
    
}

- (void)buttonClicked
{
    char *a = malloc(100*1024*1024);
    NSLog(@"%p",a);
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
