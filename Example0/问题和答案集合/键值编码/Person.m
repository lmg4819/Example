//
//  Person.m
//  Example0
//
//  Created by lmg on 2019/4/11.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Person.h"

#define CodesErrorDomain @"CodesErrorDomain"
#define kInvalidValueError 1


@implementation Person

-(instancetype)initWithFirstName:(NSString *)fname lastName:(NSString *)lname
{
    if (self = [super init]) {
        _firstName = fname;
        _lastName = lname;
    }
    return self;
}

-(NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
}

//方法用于注册依赖建
+(NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"fullName"]) {
        NSArray *effactingKeys = @[@"lastName",@"firstName"];
        keyPaths = [keyPaths setByAddingObjectsFromArray:effactingKeys];
    }
    return keyPaths;
}

@end
