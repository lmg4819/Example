//
//  EOCPerson.h
//  Example0
//
//  Created by lmg on 2018/10/16.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EOCPerson : NSObject<NSCopying>

@property (nonatomic,copy,readwrite) NSString *firstName;
@property (nonatomic,copy,readwrite) NSString *lastName;
@property (nonatomic,strong,readwrite) NSSet *friends;

- (instancetype)initWithFirstName:(NSString *)firstName
                      andLastName:(NSString *)lastName;


@end


@interface EOCPerson (FriendShip)

/**
 FriendShip Methods
 */
- (void)addFriend:(EOCPerson *)person;
- (void)removeFriend:(EOCPerson *)person;

@end


@interface EOCPerson (Work)

/**
 Work Methods
 */
- (void)performDaysWork;
- (void)takeVacationFromWork;

@end

@interface EOCPerson (Play)

/**
 Play Methods
 */
- (void)goToTheCinema;
- (void)goToSportsGame;


@end

NS_ASSUME_NONNULL_END
