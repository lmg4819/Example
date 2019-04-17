//
//  CYPModuleURLInitInterceptor.h
//  OpenPlatform
//
//  Created by dasheng on 2019/1/9.
//  Copyright © 2019年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CYPModuleURLInitInterceptor <NSObject>
- (void)cypInterceptOriginURL:(NSString *)URL withQuery:(NSDictionary *)query reverseBlock:(void (^)(id _Nonnull))reverse;
@end
