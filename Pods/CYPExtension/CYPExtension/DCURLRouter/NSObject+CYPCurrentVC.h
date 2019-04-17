//
//  NSObject+CYPCurrentVC.h
//  CYPExtension
//
//  Created by songhh on 2019/1/10.
//  Copyright © 2019 ma. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CYPCurrentVC)

- (UIViewController *)cyp_currentViewController;

- (UINavigationController *)cyp_currentNavigationVC;

@end

NS_ASSUME_NONNULL_END
