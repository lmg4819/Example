//
//  EOCServerConnection.h
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EOCServerConnection : NSObject

- (void)open:(NSString *)address;
- (void)close;

@end

NS_ASSUME_NONNULL_END
