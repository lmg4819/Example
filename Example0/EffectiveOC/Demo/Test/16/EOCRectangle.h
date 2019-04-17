//
//  EOCRectangle.h
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EOCRectangle : NSObject<NSCoding>
@property (nonatomic,assign,readonly) float width;
@property (nonatomic,assign,readonly) float height;

- (instancetype)initWithWidth:(float)width height:(float)height NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
