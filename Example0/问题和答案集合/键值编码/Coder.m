
//
//  Coder.m
//  Example0
//
//  Created by lmg on 2019/4/11.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Coder.h"

@implementation Coder

-(NSUInteger)countOfLanguages
{
    return [self.languages count];
}

-(NSString *)objectInLanguagesAtIndex:(NSUInteger)index
{
    return [self.languages objectAtIndex:index];
}

-(void)insertObject:(NSString *)object inLanguagesAtIndex:(NSUInteger)index{
    [self.languages insertObject:object atIndex:index];
}

-(void)removeObjectFromLanguagesAtIndex:(NSUInteger)index
{
    [self.languages removeObjectAtIndex:index];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSString *newValue = change[NSKeyValueChangeNewKey];
    NSLog(@"value change for %@ object,key path:%@,new value:%@",[object class],keyPath,newValue);
}

@end
