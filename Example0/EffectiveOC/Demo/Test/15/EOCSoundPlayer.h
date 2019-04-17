//
//  EOCSoundPlayer.h
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class EOCSoundPlayer;

@protocol EOCSoundPlayerDelegate <NSObject>

- (void)soundPlayerDidFinish:(EOCSoundPlayer *)player;

@end

@interface EOCSoundPlayer : NSObject

@property (nonatomic,weak) id<EOCSoundPlayerDelegate>delegate;
- (id)initWithURL:(NSURL *)url;
- (void)playSound;

@end

NS_ASSUME_NONNULL_END
