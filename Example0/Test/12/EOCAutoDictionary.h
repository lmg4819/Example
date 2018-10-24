//
//  EOCAutoDictionary.h
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EOCAutoDictionary : NSObject

@property (nonatomic,strong) NSString *string;
@property (nonatomic,strong) NSNumber *number;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) id opaqueObject;

@end

NS_ASSUME_NONNULL_END
