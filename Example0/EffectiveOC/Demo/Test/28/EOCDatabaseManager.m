//
//  EOCDatabaseManager.m
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCDatabaseManager.h"
#import "EOCDatabaseConnection.h"


@interface EOCDatabaseManager ()<EOCDatabaseConnection>

+ (id)sharedInstance;
- (id<EOCDatabaseConnection>)connectWithIdentifier:(NSString *)identifier;

@end

@implementation EOCDatabaseManager


- (void)connect {
    
}

- (void)disConnect {
    
}

- (BOOL)isConnected {
    return YES;
}

- (nonnull NSArray *)performQuery:(nonnull NSString *)query {
    return [NSArray array];
}

+ (id)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id<EOCDatabaseConnection>)connectWithIdentifier:(NSString *)identifier
{
    return nil;
}

@end
