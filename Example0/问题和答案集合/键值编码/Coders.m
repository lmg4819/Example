//
//  Coders.m
//  Example0
//
//  Created by lmg on 2019/4/12.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Coders.h"
#import <UIKit/UIKit.h>

@implementation Coders

-(instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

-(NSUInteger)countOfDevelopers
{
    return [self.developers count];
}

-(NSEnumerator *)enumeratorOfDevelopers
{
    return [self.developers objectEnumerator];
}

-(Coder *)memberOfDevelopers:(Coder *)member object:(Coder *)anObject
{

    return [self.developers member:anObject];
}


@end
