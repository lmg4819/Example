//
//  RegisterAPI.h
//  Example0
//
//  Created by lmg on 2018/9/29.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "YTKRequest.h"


NS_ASSUME_NONNULL_BEGIN

@interface RegisterAPI : YTKRequest

- (id)initWithUsername:(NSString *)username password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
