//
//  EOCSquare.m
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCSquare.h"

@implementation EOCSquare

- (instancetype)initWithDimension:(float)dimension
{
    return [super initWithWidth:dimension height:dimension];
}

- (instancetype)initWithWidth:(float)width height:(float)height
{
    float dimension = MAX(width, height);
    return [self initWithDimension:dimension];
}

- (instancetype)init
{
    return [self initWithDimension:5.0f];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

@end
