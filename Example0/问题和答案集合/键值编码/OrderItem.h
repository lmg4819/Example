//
//  OrderItem.h
//  Example0
//
//  Created by lmg on 2019/4/11.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderItem : NSObject
@property NSString *desc;
@property NSUInteger quantity;
@property float price;
@end

@interface Order : NSObject
@property NSArray *items;
@end

NS_ASSUME_NONNULL_END
