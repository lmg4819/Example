//
//  EOCServerConnection.m
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCServerConnection.h"

@interface EOCServerConnection ()
@property (nonatomic,assign) BOOL closed;
@end

@implementation EOCServerConnection

- (void)close
{
    _closed = YES;
}

- (void)dealloc
{
    if (!_closed) {
        NSLog(@"ERROR : close was not called before dealloc");
        [self close];
    }
}

@end
