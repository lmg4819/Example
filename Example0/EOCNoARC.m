//
//  EOCNoARC.m
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCNoARC.h"
#import "EOCPerson.h"

@interface EOCNoARC ()
@property (nonatomic,retain) NSString *userName;
@end

@implementation EOCNoARC


//+ (EOCPerson *)newPerson
//{
//    EOCPerson *person = [[EOCPerson alloc]init];
//    return person;
//}
//
//+ (EOCPerson *)somePerson
//{
//    EOCPerson *person = [[EOCPerson alloc]init];
//    return [person autorelease];
//}
//
//id objc_autoreleaseReturnValue(id object)
//{
//    if (/* caller will retain object */) {
//        set_flag(object);
//        return object;//No autorelease
//    }else
//    {
//        [object autorelease];
//    }
//}
//
//id objc_retainAutoreleasedReturnValue(id object)
//{
//    if (get_flag(object)) {
//        clearflag(object);
//        return object;//No retain
//    }else
//    {
//        return [object retain];
//    }
//}


//+ (EOCPerson *)personWithName:(NSString *)name
//{
//    EOCPerson *person = [[EOCPerson alloc]init];
//    person.firstName = name;
//    objc_autoreleaseReturnValue(person);
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        NSNumber *number = [[NSNumber alloc]initWithInt:1337];
        [array addObject:number];
        
//        EOCPerson *tmp = [EOCNoARC personWithName:@"Matt Galloway"];
//        _myPerson = objc_retainAutoreleasedReturnValue(tmp);
//
//
//        EOCPerson *personOne = [EOCNoARC newPerson];
//        [personOne release];
//
//        EOCPerson *personTwo = [EOCNoARC somePerson];
        
        
        
        [number release];
        number = nil;
        [array release];
    }
    return self;
}

- (NSString *)stringValue
{
    NSString *str = [[NSString alloc]initWithFormat:@"T am this :%@",self];
    return [str autorelease];
}

-(void)setUserName:(NSString *)userName
{
    [userName retain];
    [_userName release];
    _userName = userName;
}

@end
