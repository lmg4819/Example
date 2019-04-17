//
//  NSObject+CYPCurrentVC.m
//  CYPExtension
//
//  Created by songhh on 2019/1/10.
//  Copyright © 2019 ma. All rights reserved.
//

#import "NSObject+CYPCurrentVC.h"

@implementation NSObject (CYPCurrentVC)

- (UIViewController *) cyp_findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self cyp_findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count > 0) {
            return [self cyp_findBestViewController:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *)vc;
        if (svc.viewControllers.count > 0) {
            return [self cyp_findBestViewController:svc.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0) {
            return [self cyp_findBestViewController:svc.selectedViewController];
        } else {
            return vc;
        }
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

- (UIViewController *)cyp_currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self cyp_findBestViewController:viewController];
}

- (UINavigationController *)cyp_currentNavigationVC {
    return [[self cyp_currentViewController] navigationController];
}

@end
