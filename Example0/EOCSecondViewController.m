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
@end

@implementation EOCSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i=0; i<10; i++) {
        [self calculator];
    }
}
int countIndex = 0;
- (void)calculator
{
//    static int index = 0;
    countIndex ++ ;
//    NSLog(@"------%d-----",countIndex);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"111111111111111");
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"222222222222222");
}

@end
