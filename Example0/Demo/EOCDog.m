//
//  EOCDog.m
//  Example0
//
//  Created by lmg on 2018/11/16.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCDog.h"
/*
 找不到set方法的话
 按照_key,_iskey,key,iskey的顺序
 
 */
@implementation EOCDog
{
    NSString *toSetName;
    NSString *isName;
    NSString *_name;
    NSString *_isName;
    NSInteger _count;
}

+ (BOOL)accessInstanceVariablesDirectly
{
    return YES;
}

- (id)valueForUndefinedKey:(NSString *)key
{
    NSLog(@"出现异常，该key不存在%@",key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"出现异常，该key不存在%@",key);
}

-(void)setNilValueForKey:(NSString *)key
{
    NSLog(@"不能将%@设成nil",key);
}


@end
