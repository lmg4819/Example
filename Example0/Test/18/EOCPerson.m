//
//  EOCPerson.m
//  Example0
//
//  Created by lmg on 2018/10/16.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCPerson.h"

@interface EOCPerson ()


@end

@implementation EOCPerson
{
    NSMutableSet *_internalFriends;
}

- (NSSet *)friends
{
    return [_internalFriends copy];
}

- (void)addFriend:(EOCPerson *)person
{
    [_internalFriends addObject:person];
}

- (void)removeFriend:(EOCPerson *)person
{
    [_internalFriends removeObject:person];
}

- (instancetype)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName
{
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _internalFriends = [NSMutableSet new];
    }
    return self;
}

#pragma mark -<NSCopying>
- (id)copyWithZone:(NSZone *)zone
{
    EOCPerson *person = [[[self class] allocWithZone:zone] initWithFirstName:_firstName andLastName:_lastName];
    person->_internalFriends = [[NSMutableSet alloc]initWithSet:_internalFriends copyItems:YES];
    return person;
}


@end
