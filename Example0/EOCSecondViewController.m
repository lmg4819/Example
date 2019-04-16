//
//  EOCSecondViewController.m
//  Example0
//
//  Created by lmg on 2018/10/25.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCSecondViewController.h"
#import "NSTimer+EOCBlockSupport.h"

@interface EOCSecondViewController ()
{
    NSTimer *_timer;
}
@end

@implementation EOCSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   _timer =  [NSTimer eoc_scheduleTimerWithTimeInterval:2.0 block:^{
        NSLog(@"11111111111111");
    } repeats:YES];
}

-(void)dealloc
{
    [_timer invalidate];
    NSLog(@"22222222222222");
}

@end
