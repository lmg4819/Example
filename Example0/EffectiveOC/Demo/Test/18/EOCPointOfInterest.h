//
//  EOCPointOfInterest.h
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EOCPointOfInterest : NSObject

@property (nonatomic,copy,readonly) NSString *identifier;
@property (nonatomic,copy,readonly) NSString *title;
@property (nonatomic,assign,readonly) float latitude;
@property (nonatomic,assign,readonly) float longitude;

- (instancetype)initWithIdentifier:(NSString *)identifier
                             title:(NSString *)title
                          latitude:(float)latitude
                         longitude:(float)longitude;


@end

NS_ASSUME_NONNULL_END
