//
//  Capture48.m
//  Example0
//
//  Created by lmg on 2018/10/25.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture48.h"

@implementation Capture48


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *tempArray = @[@1,@2,@3,@4,@5,@6];
        
        //1 for循环
        for (int i=0; i<tempArray.count; i++) {
            NSLog(@"%d---%@",i,tempArray[i]);
        }
        
        //2 NSEnumerator
        NSEnumerator *enumerator = [tempArray objectEnumerator];
        NSNumber *number;
        while ((number = [enumerator nextObject]) != nil) {
            NSLog(@"%@",number);
        }
        
        
        //3 快速遍历
        for (NSNumber *number in tempArray) {
            NSLog(@"%@",number);
        }
        
        //4 NSEnumerator
        [tempArray enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%lu-----%@",(unsigned long)idx,number);
        }];
        
        
    }
    return self;
}

/*
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.遍历collection有四种方法，最基本的方法是for循环，其次是NSEnumerator遍历法及快速遍历法，最新最先进的方法是快枚举法
 2.块枚举法本身就能通过GCD来并发执行遍历操作，无需另行编写代码
 3.若提前知道遍历的collection含有何种对象，则应修改块签名，指出对象的具体类型
 
 */
@end
