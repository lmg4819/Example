//
//  Capture38.h
//  Example0
//
//  Created by lmg on 2018/10/18.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ACAccountStoreSaveComplentionHandle)(BOOL success,NSError *error);

typedef void (^ACAccountStoreRequestComplentionHandle)(BOOL granted,NSError *error);

@interface Capture38 : NSObject
//38.为常用的快类型创建typedef
@end

NS_ASSUME_NONNULL_END
