//
//  EOCPointOfInterest.m
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCPointOfInterest.h"

@implementation EOCPointOfInterest

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title latitude:(float)latitude longitude:(float)longitude
{
    self = [super init];
    if (self) {
        _identifier = identifier;
        _title = title;
        _latitude = latitude;
        _longitude = longitude;
        
    }
    return self;
}

@end
