//
//  Capture16.m
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture16.h"

@implementation Capture16




-(instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

/*
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.在类中提供一个全能初始化方法，并在文档中指明。其他初始化方法均应调用次方法。
 2.若全能初始化方法与超类不同，则需覆写超类中的对应方法。
 3.如果超类的全能初始化方法不适用于子类，那么应该覆写超类方法，并在其中抛出异常。
 */
@end
