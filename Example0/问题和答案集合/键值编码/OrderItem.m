//
//  OrderItem.m
//  Example0
//
//  Created by lmg on 2019/4/11.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem
-(instancetype)init
{
    self = [super init];
    if (self) {
        _desc = @"hello";
        _quantity = 10;
        _price = 10.0;
    }
    return self;
}
@end

@implementation Order

-(instancetype)init
{
    self = [super init];
    if (self) {
        _items = @[@1,@2,@3,@4,@5];
    }
    return self;
}

@end
