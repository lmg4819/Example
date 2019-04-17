//
//  EOCDatabaseConnection.h
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EOCDatabaseConnection <NSObject>

- (void)connect;
- (void)disConnect;
- (BOOL)isConnected;
- (NSArray *)performQuery:(NSString *)query;

@end

NS_ASSUME_NONNULL_END
