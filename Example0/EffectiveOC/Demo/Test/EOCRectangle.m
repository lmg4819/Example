//
//  EOCRectangle.m
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCRectangle.h"

@implementation EOCRectangle

- (instancetype)initWithWidth:(float)width height:(float)height
{
    self = [super init];
    if (self) {
        _width = width;
        _height = height;
    }
    return self;
}

-(instancetype)init
{
    return [self initWithWidth:5.0f height:10.0f];
}

#pragma mark -NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _width = [aDecoder decodeFloatForKey:@"width"];
        _height = [aDecoder decodeFloatForKey:@"height"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@:%p:%@>",[self class],self,@{
                                                                        @"width":@(_width),
                                                                        @"height":@(_height)
                                                                        }];
}

- (NSString *)debugDescription
{
    return nil;
}

@end
