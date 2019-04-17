
//
//  EOCCPPerson.m
//  Example0
//
//  Created by lmg on 2018/11/19.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCCPPerson.h"

@implementation EOCCPPerson
-(void)willChangeValueForKey:(NSString *)key
{
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey");
}


-(void)didChangeValueForKey:(NSString *)key
{
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey");
}


@end
