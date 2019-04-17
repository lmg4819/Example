//
//  EOCHello.m
//  Example0
//
//  Created by lmg on 2019/4/11.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "EOCHello.h"

@implementation EOCHello

/**
默认YES，键值编码机制能否直接访问属性的支持变量，即成员变量
 */
+(BOOL)accessInstanceVariablesDirectly
{
    return YES;
}

-(id)valueForUndefinedKey:(NSString *)key
{
    if (key && [key isEqualToString:@"hi"]) {
        return self.greeting;
    }
    [NSException raise:NSUndefinedKeyException format:@"key %@ not defined",key];
    return nil;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
